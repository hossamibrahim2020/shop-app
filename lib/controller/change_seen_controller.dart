import 'package:shared_preferences/shared_preferences.dart';

class ChangeSeenController {
  final String key = 'seen';

  Future<void> makeSeenTrue() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(key, true);
  }

  Future<void> makeSeenFalse() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(key, false);
  }
}
