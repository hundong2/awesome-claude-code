#!/bin/bash

# Check if a commit message is provided
if [ -z "$1" ]; then
  echo "Error: Commit message is required."
  echo "Usage: ./scripts/commit_and_push.sh \"Your commit message\""
  exit 1
fi

# Git add, commit, and push
git add .
git commit -m "$1"
git push
