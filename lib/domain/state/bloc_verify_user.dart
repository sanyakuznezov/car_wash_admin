


 import 'package:car_wash_admin/data/local_data_base/app_data_base.dart';
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
     prefs.setInt('cwid', cwid);
     prefs.setInt('pid', pid);
     prefs.setBool('is_auth',true);
     prefs.setString('guid', guid);
     prefs.setString('token', token);
     result=true;
     return result;


   }

   Future<bool> singOutUser() async{
     final database = await $FloorAppDataBase.databaseBuilder('app_database.db').build();
     final userDao = database.userataDao;
     await userDao.clear();
     SharedPreferences prefs=await SharedPreferences.getInstance();
     return prefs.setBool('is_auth',false);
   }


   Future<bool> saveTokenFcm(String token) async{
     SharedPreferences prefs=await SharedPreferences.getInstance();
     return prefs.setString('tokenFcm',token);
   }

   Future<String?> getTokenFcm() async{
     SharedPreferences prefs=await SharedPreferences.getInstance();
     return prefs.getString('tokenFcm');
   }

   Future<Map> checkDataValidUser() async {
     SharedPreferences prefs=await SharedPreferences.getInstance();
     return {'guid':prefs.getString('guid'),'token':prefs.getString('token'),'pid':prefs.getInt('pid'),'cwid':prefs.getInt('cwid')};
   }





 }