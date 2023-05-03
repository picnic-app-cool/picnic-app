#!/bin/bash

GIT_DIR=$(git rev-parse --git-dir)
mkdir -p $GIT_DIR/hooks/

echo "Installing git hooks"
rm -f $GIT_DIR/hooks/pre-commit
rm -f $GIT_DIR/hooks/prepare-commit-msg
ln -s ../../scripts/hook-pre-commit.sh $GIT_DIR/hooks/pre-commit
ln -s ../../scripts/hook-prepare-commit-msg.sh $GIT_DIR/hooks/prepare-commit-msg
echo "Done!" 