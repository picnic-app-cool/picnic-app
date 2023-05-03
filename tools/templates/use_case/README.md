# use_case

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

Creates the UseCase along with the associated failure

creates following files:

```
- lib/features/$FEATURE_NAME$/domain/use_cases/$NAME$_use_case.dart
- lib/features/$FEATURE_NAME$/domain/failures/$NAME$_failure.dart

- test/domain/$NAME$_use_case_test.dart
```

also modifies following files

- `app_component.dart` - adds getIt registration for the use case
- `test/mock_definitions.dart` - adds mock definitions for the use case
- `test/mocks.dart` - creates the mocks as static fields for use in tests