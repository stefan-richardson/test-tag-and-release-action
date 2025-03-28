#!/bin/bash
set -e

chmod +x gradlew
./gradlew addCredentials --key artifactoryUsername --value github-actions
./gradlew addCredentials --key artifactoryApiKey --value "$API_KEY"
./gradlew artifactoryPublish
