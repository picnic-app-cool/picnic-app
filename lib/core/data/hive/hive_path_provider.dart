import 'package:path_provider/path_provider.dart';

class HivePathProvider {
  Future<String> get path async {
    var appDir = await getApplicationDocumentsDirectory();
    return appDir.path;
  }
}
