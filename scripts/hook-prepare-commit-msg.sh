#!/bin/bash

printf "\e[33;32m%s\e[0m\n" 'Add JIRA issue id'

if [ -z "$BRANCHES_TO_SKIP" ]; then
  BRANCHES_TO_SKIP=(master develop test release)
fi

BRANCH_NAME=$(git symbolic-ref --short HEAD)
BRANCH_NAME="${BRANCH_NAME##*/}"
ISSUE_ID=$(echo $BRANCH_NAME | grep -o "GS-\d*")

BRANCH_EXCLUDED=$(printf "%s\n" "${BRANCHES_TO_SKIP[@]}" | grep -c "^$BRANCH_NAME$")
BRANCH_IN_COMMIT=$(grep -c "\[$ISSUE_ID\]" $1)

if [ -n "$BRANCH_NAME" ] && ! [[ $BRANCH_EXCLUDED -eq 1 ]] && ! [[ $BRANCH_IN_COMMIT -ge 1 ]]; then 
  echo $ISSUE_ID
  sed -i.bak -e "1s/^/$ISSUE_ID /" $1
fi