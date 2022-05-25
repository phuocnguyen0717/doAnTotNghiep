import 'package:shared_preferences/shared_preferences.dart';

class GetLocal{
  static Future<String?> getPassWord() async {
    SharedPreferences sperf = await SharedPreferences.getInstance();
    return sperf.getString('pass') ?? '';
  }
}