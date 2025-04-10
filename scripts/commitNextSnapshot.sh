#!/bin/bash
set -e

git config user.name "github-actions"
git config user.email "github-actions@github.com"
git add build.gradle
git commit -m "[github-action] prepare for next development iteration" || echo "No changes to commit"
git push origin HEAD