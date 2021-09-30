


    import 'package:car_wash_admin/domain/model/user_data.dart';
import 'package:car_wash_admin/domain/state/bloc_verify_user.dart';
import 'package:car_wash_admin/internal/dependencies/repository_module.dart';
import 'package:car_wash_admin/ui/screen_auth/page_auth.dart';
import 'package:car_wash_admin/ui/screen_orders_table/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget{

  BlocVerifyUser _blocVerifyUser=BlocVerifyUser();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<bool>(
        future: _blocVerifyUser.isAuth(),
        builder: (context,data){
         if(data.data==null){
           return Center(
               child: CircularProgressIndicator(color: Colors.indigo,strokeWidth: 4,)
           );
        }else{
           if(data.data==true){
             return MyHomePage();
           }else{
             return PageAuth();
           }
        }
      },)
        
    );
  }
  
}