//ignore_for_file: forbidden_import_in_domain
import 'package:shared_preferences/shared_preferences.dart';

/// used to retrieve an instance of SharedPreferences
class SharedPreferencesProvider {
  //ignore: no_date_time_now
  Future<SharedPreferences> get sharedPreferences => SharedPreferences.getInstance();
}
