.PHONY : check format_code generate unit_tests prepare_unit_tests calc_unit_test
package := picnic_app
file := test/coverage_helper_test.dart

format_code:
	@echo "\033[32m Formatting code... \033[0m"
	@fvm dart format --line-length 120 lib test

generate:
	@echo "\033[32m run 'pub get' \033[0m"
	@pushd tools/custom_lints/clean_architecture_lints ; fvm flutter pub get ; popd ; fvm flutter pub get
	@echo "\033[32m Run fluttergen... \033[0m"
	@fvm dart pub global activate flutter_gen 5.1.0+1
	@fvm dart pub global run flutter_gen:flutter_gen_command -c pubspec.yaml
	@echo "\033[32m Validate localization files... \033[0m"
	@fvm dart tools/arb_files_validator/bin/arb_files_validator.dart lib/localization/

check: format_code generate
	@./scripts/disable_analysis_plugins.sh
	@echo "\033[32m Flutter analyze... \033[0m"
	@fvm flutter analyze
	@echo "\033[32m Flutter clean architecture lints... \033[0m"
	@./scripts/enable_custom_lint.sh ; fvm flutter pub run custom_lint ; ./scripts/disable_analysis_plugins.sh
	@./scripts/enable_dart_code_metrics.sh
	@echo "\033[32m Code metrics analyze: \033[0m"
	@fvm flutter pub run dart_code_metrics:metrics analyze lib --set-exit-on-violation-level=warning --fatal-style --fatal-performance --fatal-warnings
	@echo "\033[32m Code metrics check-unused-code: \033[0m"
	@fvm flutter pub run dart_code_metrics:metrics check-unused-code . --fatal-unused
	@echo "\033[32m Code metrics check-unused-files: \033[0m"
	@fvm flutter pub run dart_code_metrics:metrics check-unused-files . --fatal-unused --exclude="{.fvm/**,ios/**,tools/**,packages/**,.dart_tool/**,lib/generated/**,widgetbook/**}"
	@./scripts/disable_analysis_plugins.sh
	@echo "\033[32m Flutter test... \033[0m"
	@fvm flutter test || (echo "\033[1;31m \n\n\ LOOKS LIKE TESTS HAVE FAILED, IF THOSE WERE SCREENSHOT TESTS, MAKE SURE TO GENERATE NEW ONES USING CI (IN YOUR PR, ADD 'Generate Screenshots' label that will trigger screenshot regeneration" && exit 1)
	@echo "\033[1;32m \n\nGOOD JOB, THE CODE IS SPOTLESS CLEAN AND READY FOR PULL REQUEST! \n \033[42m Make sure to commit any code changes \033[0m  \n\n"

prepare_unit_tests:
	@echo "// Helper file to make coverage work for all dart files\n" > ${file}
	@echo "// ignore_for_file: unused_import" >> ${file}
	@echo "// https://github.com/flutter/flutter/issues/27997#issuecomment-926524213" >> ${file}
	@echo "// ignore_for_file: directives_ordering" >> ${file}
	@find lib -not -name '*.g.dart' -and -not -name '**/gen/*.dart' -and -not -name '**/generated/*.dart' -and -not -name '*.gen.dart'  -and -not -name 'generated_plugin_registrant.dart' -and -name '*.dart'| cut -c4- | awk -v package=${package} '{printf "import '\''package:%s%s'\'';\n", package, $$1}' >> ${file}
	@echo "void main(){}" >> ${file}
	$(info generated ${file})

unit_tests:
	@fvm flutter test --dart-define=IS_CI=true --coverage --coverage-path=coverage/lcov.info || true

calc_unit_test:
	@lcov --remove coverage/lcov.info 'lib/*/*.g.dart' 'lib/*/*.gen.dart' 'lib/generated_plugin_registrant.dart' -o coverage/lcov.info
	dart tools/coverage.dart pr_branch_percentage

# Creates new page using class mason templates
new_page:
	@pushd tools/templates; mason get; mason make page --root_folder_path $(shell pwd); popd

# Creates new use_case class using mason templates
new_use_case:
	@pushd tools/templates; mason get; mason make use_case --root_folder_path $(shell pwd); popd

# Creates new repository class using mason templates
new_repository:
	@pushd tools/templates; mason get; mason make repository --root_folder_path $(shell pwd); popd

# Moves and/or renames repository class using mason templates
move_repository:
	@pushd tools/templates; mason get; mason make move_repository --root_folder_path $(shell pwd); popd

# Moves and/or renames page class using mason templates
move_page:
	@pushd tools/templates; mason get; mason make move_page --root_folder_path $(shell pwd); popd

# builds the iOS app from scratch and releases it to testflight
deploy_testflight:
	@echo "\033[32m flutter precache --ios: \033[0m"
	@fvm flutter precache --ios
	@echo "\033[32m flutter clean \033[0m"
	@fvm flutter clean
	@echo "\033[32m bundle install \033[0m"
	@pushd ios ; bundle install
	@echo "\033[32m refresh_profiles... \033[0m"
	@pushd ios ; bundle exec fastlane refresh_profiles
	@echo "\033[32m build IPA file... \033[0m"
	fvm flutter build ipa --release --export-options-plist ios/export-appstore.plist
	@echo "\033[32m deploy_testflight \033[0m"
	@pushd ios ; bundle exec fastlane deploy_testflight

run_pub_get_everywhere:
	@echo "\033[32m running pub get everywhere \033[0m"
	@find . -name 'pubspec.yaml' ! -path "**/.dart_tool/**" ! -path "**/packages/dart-custom-lint/**" -exec dirname {} \; | xargs -L1 fvm flutter pub get
run_pub_get_everywhere_ci:
	@echo "\033[32m running pub get everywhere on CI \033[0m"
	@find . -name 'pubspec.yaml' ! -path "**/.dart_tool/**" ! -path "**/packages/dart-custom-lint/**" -exec dirname {} \; | xargs -L1 flutter pub get

# builds the Android app from scratch and releases it to google play - alpha
deploy_google_play_alpha:
	@echo "\033[32m flutter clean \033[0m"
	@fvm flutter clean
	@echo "\033[32m bundle install \033[0m"
	@pushd android ; bundle install; popd
	@echo "\033[32m build APK file... \033[0m"
	fvm flutter build appbundle --release
	@echo "\033[32m deploy_google_alpha \033[0m"
	@pushd android ; bundle exec fastlane deploy_google_alpha


# creates new feature branch. you can set JIRA_ACCESS_TOKEN env variable with your personal access token
# and it will fetch info about JIRA ticket before creating feature branch
new_feature_branch:
	@echo "\033[32m Creating new feature branch from latest develop...\033[0m"
	@echo "\n \n \033[33m use JIRA_ACCESS_TOKEN env variable to get info about ticket from JIRA automatically! \033[0m \n\n"
	@pushd ios ; bundle exec fastlane new_feature_branch

extract_config:
	@echo "extracting config.zip file..."
	@unzip -o config.zip -d .
	@echo "moving files to proper spots..."
	@mv GoogleService-Info.plist ios/Runner/GoogleService-Info.plist
	@mv google-services.json android/app/google-services.json
	@echo "\033[32m done! your config should be now properly set up \033[0m"