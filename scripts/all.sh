#!/bin/bash
./build.sh && \
./check.sh && \
./check_versions.sh && \
./deploy.sh && \
./run.sh
