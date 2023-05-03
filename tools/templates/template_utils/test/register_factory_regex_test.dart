import 'package:template_utils/replacements_utils.dart';
import 'package:test/test.dart';

void main() {
  test("description", () {
    final replaced = example.replaceAllMapped(
      getItFactoryRegex("AuthRepository"),
      (match) {
        print("AUTH MATCHES\n-----------------\n");
        print(match.groups(List.generate(match.groupCount, (index) => index + 1)).join("\n\n-----------------\n\n"));
        print("\n############ END ############\n");
        return "/* REMOVED AUTH*/\n${match[2]}${match[3] ?? ''}${match[4] ?? ''}${match[5] ?? ''}";
      },
    ).replaceAllMapped(
      getItFactoryRegex("PrivateProfileRepository"),
      (match) {
        print("PRIVATE PROFILE MATCHES\n-----------------");
        print(match.groups(List.generate(match.groupCount, (index) => index + 1)).join("\n-----------------\n"));
        print("\n############ END ############\n");
        return "/* REMOVED PRIVATE_PROFILE*/\n${match[2]}${match[3] ?? ''}${match[4] ?? ''}${match[5] ?? ''}";
      },
    );
    print("\nFINAL\n================\nFINAL\n$replaced");
    expect(replaced.contains("REMOVED AUTH"), true);
    expect(replaced.contains("REMOVED PRIVATE_PROFILE"), true);
    expect(replaced.contains("UsersRepository"), true);
    expect(replaced.contains("RuntimePermissionsRepository"), true);
    expect(replaced.contains(RegExp("[^\.]registerFactory")), false);
  });
}

final example = """
import 'package:picnic_app/features/video_editor/dependency_injection/feature_component.dart' as video_editor;

final getIt = GetIt.instance;

void configureDependencies() {
  _configureRepositories();
}

//ignore: long-method
void _configureRepositories() {
  // ignore: unnecessary_statements
  getIt
        ..registerFactory<AuthRepository>(
          () => OldBackendAuthRepository(
            getIt(),
            getIt(),
          ), //TODO replace it with FirebaseGraphqlAuthRepository
        )
        ..registerFactory<RuntimePermissionsRepository>(
          () => const FlutterRuntimePermissionsRepository(),
        )
        ..registerFactory<UsersRepository>(
          () => GraphqlUsersRepository(
            getIt(),
          ), //TODO replace it with New backend
        )
        ..registerFactory<LocalStorageRepository>(
          () => HiveLocalStorageRepository(
            getIt(),
          ),
        )
        ..registerFactory<PrivateProfileRepository>(
          () => const GraphqlPrivateProfileRepository(),
        )
      //DO-NOT-REMOVE REPOSITORIES_GET_IT_CONFIG

      ;
}
""";
