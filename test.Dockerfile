FROM microsoft/dotnet:2.2-sdk AS build
LABEL Maintainer "Calvin Rodo"

WORKDIR /app

# copy csproj and restore as distinct layers
COPY webpoc/*.csproj ./webpoc/
WORKDIR /app/webpoc
RUN dotnet restore


# copy and publish app and libraries
WORKDIR /app/
COPY webpoc/. ./webpoc/
WORKDIR /app/webpoc
RUN dotnet publish -c Release -o out

# test application -- see: dotnet-docker-unit-testing.md
FROM build AS testrunner
WORKDIR /app/webpoctest

RUN dotnet tool install coverlet.console --tool-path  /app/tools/

COPY webpoctest/. .

RUN dotnet test

ENTRYPOINT ["/app/tools/coverlet", \
 "/app/webpoctest/bin/Debug/netcoreapp2.0/webpoctest.dll", \
 "--target", "dotnet", \
 "--targetargs", "test --no-build", \
 "--format", "json", \
 "--output", "/app/test-results/codecoverage"]
# ENTRYPOINT ["dotnet", "test", "--logger:trx", "/p:CollectCoverage=true"]