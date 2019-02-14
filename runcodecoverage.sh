#!/bin/bash

docker run  \
-v "$(pwd)"/out:/app/test-results \
autotests:latest