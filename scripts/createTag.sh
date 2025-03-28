#!/bin/bash
set -e
VERSION=$1
MESSAGE=$2
PREFIX=$3
DRY_RUN=$4

TAG="${PREFIX}-${VERSION}"

if [ "$DRY_RUN" == "true" ]; then
  echo "[DRY RUN] Would create and push tag: $TAG"
  echo "[DRY RUN] Commit message: $MESSAGE"
else
  git config user.name "github-actions"
  git config user.email "github-actions@github.com"

  echo "🏷️ Creating tag: $TAG"
  git tag -a "$TAG" -m "$MESSAGE"
  git push origin "$TAG"
fi
