import 'package:shared_preferences/shared_preferences.dart';

class SharedServices {
  void cacheUserInfo(int userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', userId);
  }

  void deleteCacheUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("userId");
  }
}
