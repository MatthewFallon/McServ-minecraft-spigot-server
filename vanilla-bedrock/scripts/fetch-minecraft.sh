#!/bin/sh

set -e

MINECRAFT_VERSION=${1:-latest}

if test "${MINECRAFT_VERSION}" = "latest"; then
    # Sample URL
    # https://minecraft.azureedge.net/bin-linux/bedrock-server-1.12.0.28.zip
    URL_REGEX="https:\/\/minecraft\.azureedge\.net/bin-linux/bedrock-server-[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+\.zip"
    ZIP_URL=$(curl "https://www.minecraft.net/en-us/download/server/bedrock/" --silent -o -|grep -Eo "$URL_REGEX")
else
    ZIP_URL="https://minecraft.azureedge.net/bin-linux/bedrock-server-${MINECRAFT_VERSION}.zip"
fi

curl -o minecraft.zip ${ZIP_URL}

unzip minecraft.zip
rm minecraft.zip