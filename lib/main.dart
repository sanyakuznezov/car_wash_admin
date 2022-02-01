


import 'package:car_wash_admin/global_data.dart';
import 'package:car_wash_admin/internal/dependencies/app_module.dart';
import 'package:car_wash_admin/ui/screen_auth/splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


   main() async {
     WidgetsFlutterBinding.ensureInitialized();
     await Firebase.initializeApp(
       // Replace with actual values
       options: FirebaseOptions(
         apiKey: "AIzaSyCyL7B8f3Y3xRabshWH54iWA0o2HpPqx_4",
         appId: "1:237543568636:android:99e5b99d12336f6a2a5379",
         messagingSenderId: "237543568636",
         projectId: "stepcarmobile-25a0a",
       ),
     );
     final token = await FirebaseMessaging.instance.getToken();
     print('Tocken $token');

     AppModule.blocTableInstance();
     runApp(MyApp());
}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
        GlobalData.sizeScreen=constraints.maxHeight;
            return  MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.indigo,
              ),
              home: SplashScreen(),
            );
    });

  }
}


