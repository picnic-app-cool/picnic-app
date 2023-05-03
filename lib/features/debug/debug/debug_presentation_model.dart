import 'package:picnic_app/core/environment_config/environment_config_slug.dart';
import 'package:picnic_app/features/debug/debug/debug_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class DebugPresentationModel implements DebugViewModel {
  /// Creates the initial state
  DebugPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    DebugInitialParams initialParams,
  )   : selectedEnvironment = EnvironmentConfigSlug.staging,
        usesShortLivedTokens = false,
        additionalGraphqlHeaders = {};

  /// Used for the copyWith method
  DebugPresentationModel._({
    required this.selectedEnvironment,
    required this.additionalGraphqlHeaders,
    required this.usesShortLivedTokens,
  });

  @override
  final Map<String, String> additionalGraphqlHeaders;

  @override
  final EnvironmentConfigSlug selectedEnvironment;

  @override
  final bool usesShortLivedTokens;

  @override
  bool get hasCustomHeaders => additionalGraphqlHeaders.isNotEmpty;

  @override
  List<EnvironmentConfigSlug> get environments => EnvironmentConfigSlug.values;

  DebugViewModel byRemovingHeader(String key) => copyWith(
        additionalGraphqlHeaders: {...additionalGraphqlHeaders}..remove(key),
      );

  DebugViewModel byUpdatingHeader(MapEntry<String, String> newHeader) {
    final newHeaders = {...additionalGraphqlHeaders};
    newHeaders[newHeader.key] = newHeader.value;
    return copyWith(additionalGraphqlHeaders: newHeaders);
  }

  DebugPresentationModel copyWith({
    Map<String, String>? additionalGraphqlHeaders,
    EnvironmentConfigSlug? selectedEnvironment,
    bool? usesShortLivedTokens,
  }) {
    return DebugPresentationModel._(
      additionalGraphqlHeaders: additionalGraphqlHeaders ?? this.additionalGraphqlHeaders,
      selectedEnvironment: selectedEnvironment ?? this.selectedEnvironment,
      usesShortLivedTokens: usesShortLivedTokens ?? this.usesShortLivedTokens,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class DebugViewModel {
  List<EnvironmentConfigSlug> get environments;

  EnvironmentConfigSlug get selectedEnvironment;

  Map<String, String> get additionalGraphqlHeaders;

  bool get hasCustomHeaders;

  bool get usesShortLivedTokens;
}
