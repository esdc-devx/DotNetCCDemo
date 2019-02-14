#!/bin/bash

docker run  \
-v "$(pwd)"/out:/app/webpoctest/TestResults \
autotests:latest