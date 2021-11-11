import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  // shared pref instance
  late SharedPreferences  _sharedPreference;

  final String _bookmarks = "bookmark";

  // constructor
  SharedPreferenceHelper() {
    init();
  }

  Future init() async {
    _sharedPreference = await SharedPreferences.getInstance();
  }
}