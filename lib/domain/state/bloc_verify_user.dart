


 import 'package:shared_preferences/shared_preferences.dart';

class BlocVerifyUser{


   Future<bool> isAuth() async{
     bool isAuth=false;
     SharedPreferences prefs=await SharedPreferences.getInstance();
     isAuth=prefs.getBool('is_auth')!;
     return isAuth;
   }





 }