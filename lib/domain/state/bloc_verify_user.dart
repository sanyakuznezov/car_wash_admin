


 import 'package:shared_preferences/shared_preferences.dart';

class BlocVerifyUser{


   Future<bool> isAuth() async{
     bool isAuth=false;
     SharedPreferences prefs=await SharedPreferences.getInstance();
     if(prefs.getBool('is_auth')==null){
       isAuth=false;
     }else{
       isAuth=prefs.getBool('is_auth')!;
     }

     return isAuth;
   }

   Future<bool> saveDataTocken(String guid,String token,int cwid,int pid) async{
     bool result=false;
     SharedPreferences prefs=await SharedPreferences.getInstance();
     prefs.setBool('is_auth',true);
     prefs.setString('guid', guid);
     prefs.setString('token', token);
     prefs.setInt('cwid', cwid);
     prefs.setInt('pid', pid);
     result=true;
     return result;


   }

   Future<bool> singOutUser() async{
     SharedPreferences prefs=await SharedPreferences.getInstance();
     return prefs.setBool('is_auth',false);
   }






   Future<Map> checkDataValidUser() async {
     SharedPreferences prefs=await SharedPreferences.getInstance();
     return {'guid':prefs.getString('guid'),'token':prefs.getString('token')};
   }





 }