#!/bin/bash
set -e

chmod +x gradlew
./gradlew nextSnapshot

git config user.name "github-actions"
git config user.email "github-actions@github.com"
git add .
git commit -m "[github-action] prepare for next development iteration" || echo "No changes"
git push origin HEAD
