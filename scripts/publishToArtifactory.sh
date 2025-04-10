#!/bin/bash
set -e

chmod +x gradlew
./gradlew addCredentials -PartifactoryUsername=github-actions -PartifactoryApiKey="$API_KEY"
./gradlew artifactoryPublish
