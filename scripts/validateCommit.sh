#!/bin/bash
set -e
MESSAGE=$1

if [[ "$MESSAGE" =~ ^(feat|fix|refactor|revert|perf)(\(.+\)\:){1}.*$ ]]; then
  TYPE=$(echo "$MESSAGE" | cut -d '(' -f 1)
  echo "increment_type=$TYPE" >> $GITHUB_ENV
elif [[ "$MESSAGE" =~ ^(build|cd|ci|docs|feat|fix|perf|refactor|revert)(\(.+\)\!\:){1}.*$ ]]; then
  echo "increment_type=breakingchange" >> $GITHUB_ENV
else
  echo "ERROR: Commit message does not match conventional pattern."
  exit 1
fi
