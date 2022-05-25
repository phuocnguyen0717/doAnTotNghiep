import 'package:shared_preferences/shared_preferences.dart';

class SetLocal{
  static void setPassWord(String pass) async{
    SharedPreferences sperf = await SharedPreferences.getInstance();
    sperf.setString('pass', pass);
  }
}