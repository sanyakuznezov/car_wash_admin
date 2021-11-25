


import 'package:car_wash_admin/domain/state/bloc_verify_user.dart';
import 'package:car_wash_admin/global_data.dart';
import 'package:car_wash_admin/internal/dependencies/app_module.dart';
import 'package:car_wash_admin/ui/screen_auth/page_auth.dart';
import 'package:car_wash_admin/ui/screen_auth/splash_screen.dart';
import 'package:car_wash_admin/ui/screen_orders_table/home_screen.dart';
import 'package:car_wash_admin/utils/size_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'internal/dependencies/repository_module.dart';
import 'ui/screen_orders_table/table/multiplication_table.dart';
import 'package:sizer/sizer.dart';


   main()  {
  AppModule.blocTableInstance();
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
        GlobalData.sizeScreen=constraints.maxHeight;
        print('GlobalData.sizeScreen ${GlobalData.sizeScreen}');
            return  MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.indigo,
              ),
              home: SplashScreen(),
            );
    });

  }
}


