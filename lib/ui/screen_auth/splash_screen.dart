


    import 'package:car_wash_admin/domain/model/user_data.dart';
import 'package:car_wash_admin/domain/state/bloc_verify_user.dart';
import 'package:car_wash_admin/internal/dependencies/repository_module.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget{

  BlocVerifyUser _blocVerifyUser=BlocVerifyUser();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: FutureBuilder<bool>(
        future: _blocVerifyUser.isAuth(),
        builder: (context,data){
        if(data.data==null||data.data==false){
          return Center(
              child: CircularProgressIndicator(color: Colors.indigo,strokeWidth: 4,)
          );
          
        }else{

          return Text('');
          
          
        }
      },)
        
    );
  }
  
}