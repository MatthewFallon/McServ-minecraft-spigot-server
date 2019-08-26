#!/bin/sh

echo "$(pwd)"

export LD_LIBRARY_PATH=.

exec ./bedrock_server