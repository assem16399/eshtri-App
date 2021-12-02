import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;
  static Future init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static void saveDataInPref(bool isDarkModeOn) {
    sharedPreferences!.setBool('themeMode', isDarkModeOn);
  }

  static bool? getSavedDataInPref() {
    final extractedModeInfo = sharedPreferences!.getBool('themeMode');
    if (extractedModeInfo == null) return null;

    return extractedModeInfo;
  }

  static clear() {
    sharedPreferences!.remove('themeMode');
  }
}
