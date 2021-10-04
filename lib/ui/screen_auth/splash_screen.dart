


    import 'package:car_wash_admin/domain/model/user_data.dart';
import 'package:car_wash_admin/domain/state/bloc_verify_user.dart';
import 'package:car_wash_admin/internal/dependencies/repository_module.dart';
import 'package:car_wash_admin/ui/global_widgets/dialogs.dart';
import 'package:car_wash_admin/ui/screen_auth/page_auth.dart';
import 'package:car_wash_admin/ui/screen_orders_table/home_screen.dart';
import 'package:car_wash_admin/utils/size_util.dart';
import 'package:flutter/material.dart';

import '../../global_data.dart';

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
            return Container();
          }else{
            if(data.data==true){
              return FutureBuilder<bool>(
                  future: RepositoryModule.userRepository().validUser(),
                  builder: (context,value){
                    if (value.data==null) {
                      return Center(
                          child: Image.asset(
                            "assets/car_wash.gif",
                            height: SizeUtil.getSize(10, GlobalData.sizeScreen!),
                            width: SizeUtil.getSize(10, GlobalData.sizeScreen!),
                          ));
                    }else{
                      return MyHomePage(valid: value.data!);
                    }
                  });
            }else{

              return PageAuth();
            }
          }

        })
        
    );
  }
  
}


