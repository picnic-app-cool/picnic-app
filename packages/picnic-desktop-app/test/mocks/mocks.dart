import 'package:mocktail/mocktail.dart';

import '../features/main/mocks/main_mocks.dart';
import 'mock_definitions.dart';
import '../features/app_init/mocks/app_init_mocks.dart';
import '../../../../test/mocks/mocks.dart' as picnic_app;
import '../features/profile/mocks/profile_mocks.dart';
import '../features/image_picker/mocks/image_picker_mocks.dart';
import '../features/media_picker/mocks/media_picker_mocks.dart';
//DO-NOT-REMOVE IMPORTS_MOCKS

class Mocks {
  static late MockAppNavigator appNavigator;

  // MVP

  //DO-NOT-REMOVE MVP_MOCKS_STATIC_FIELD

  // USE CASES

  static late MockEnableLaunchAtStartupUseCase enableLaunchAtStartupUseCase;

//DO-NOT-REMOVE USE_CASE_MOCKS_STATIC_FIELD

  // REPOSITORIES

//DO-NOT-REMOVE REPOSITORIES_MOCKS_STATIC_FIELD

  // STORES
  static late MockUserStore userStore;

  //DO-NOT-REMOVE STORES_MOCKS_STATIC_FIELD

  static void init() {
    picnic_app.Mocks.init();
    MainMocks.init();
    AppInitMocks.init();
    ProfileMocks.init();
    ImagePickerMocks.init();
    MediaPickerMocks.init();
//DO-NOT-REMOVE FEATURE_MOCKS_INIT

    _initMocks();
    _initFallbacks();
  }

  static void _initMocks() {
    //DO-NOT-REMOVE FEATURES_MOCKS
    appNavigator = MockAppNavigator();
    // MVP
    //DO-NOT-REMOVE MVP_INIT_MOCKS

    // USE CASES

    enableLaunchAtStartupUseCase = MockEnableLaunchAtStartupUseCase();

//DO-NOT-REMOVE USE_CASE_INIT_MOCKS

    // REPOSITORIES
//DO-NOT-REMOVE REPOSITORIES_INIT_MOCKS

    // STORES
    userStore = MockUserStore();
    //DO-NOT-REMOVE STORES_INIT_MOCKS
  }

  static void _initFallbacks() {
    //DO-NOT-REMOVE FEATURES_FALLBACKS
    // MVP
    //DO-NOT-REMOVE MVP_MOCK_FALLBACK_VALUE

    // USE CASES

//DO-NOT-REMOVE USE_CASE_MOCK_FALLBACK_VALUE

    // REPOSITORIES
//DO-NOT-REMOVE REPOSITORIES_MOCK_FALLBACK_VALUE

    // STORES
    registerFallbackValue(MockUserStore());
    //DO-NOT-REMOVE STORES_MOCK_FALLBACK_VALUE
  }
}
