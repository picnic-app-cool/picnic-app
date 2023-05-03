#!/bin/bash
echo "Starting pre commit hook"

printf "\e[33;32m%s\e[0m\n" 'Formatting code...'
fvm dart format --line-length 120 --set-exit-if-changed lib test
if [ $? -ne 0 ]; then
    exit 1
fi

printf "\e[33;32m%s\e[0m\n" 'Formatting analyze...'
fvm flutter analyze
if [ $? -ne 0 ]; then
    exit 1
fi
printf "\e[33;32m%s\e[0m\n" 'Code metrics analyze:'
fvm flutter pub run dart_code_metrics:metrics analyze lib --set-exit-on-violation-level=warning --fatal-style --fatal-performance --fatal-warnings
if [ $? -ne 0 ]; then
    exit 1
fi

printf "\e[33;32m%s\e[0m\n" 'Code metrics check-unused-code:'
fvm flutter pub run dart_code_metrics:metrics check-unused-code lib --exclude="{lib/resources/**,lib/generated/**,lib/ui/widgets/*,lib/core/utils/*.dart,lib/core/helpers.dart,lib/constants/**,lib/navigation/**,**/main_navigator.dart}"
if [ $? -ne 0 ]; then
    exit 1
fi

printf "\e[33;32m%s\e[0m\n" 'Code metrics check-unused-files:'
fvm flutter pub run dart_code_metrics:metrics check-unused-files lib --exclude="{lib/resources/**,lib/generated/**,lib/ui/widgets/*,lib/core/utils/*.dart,lib/core/helpers.dart,lib/constants/**}"
if [ $? -ne 0 ]; then
    exit 1
fi

printf "\e[1;32m%s\e[0m\n" 'GOOD JOB, THE CODE IS READY TO COMMIT'