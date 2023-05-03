# page

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

Creates the MVP  (Model-View-Presenter) structure for a screen

creates following files:

```
- lib/features/$FEATURE_NAME$/$NAME$_page.dart
- lib/features/$FEATURE_NAME$/$NAME$_presenter.dart
- lib/features/$FEATURE_NAME$/$NAME$_presentation_model.dart
- lib/features/$FEATURE_NAME$/$NAME$_initial_params.dart
- lib/features/$FEATURE_NAME$/$NAME$_navigator.dart

- test/pages/$NAME$_page_test.dart
- test/presenters/$NAME$_presenter_test.dart
```

also modifies following files

- `app_component.dart` - adds getIt registration for the page and its dependencies
- `test/mock_definitions.dart` - adds mock definitions for the MVP classes
- `test/mocks.dart` - creates the mocks as static fields for use in tests