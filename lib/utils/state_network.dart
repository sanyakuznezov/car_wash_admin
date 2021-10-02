


 import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';

class StateNetwork{

  static late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  static final Connectivity _connectivity = Connectivity();



   static  state()  {

     // bool res=false;
     // _connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
     //       if(result.index!=0){
     //          res=true;
     //       }
     // });
     // return res;
   }


  static dispose(){
     _connectivitySubscription.cancel();
   }


   static Future<int> initConnectivity() async {
     ConnectivityResult result = ConnectivityResult.none;
     // Platform messages may fail, so we use a try/catch PlatformException.
     try {
       result = await _connectivity.checkConnectivity();
     } on PlatformException catch (e) {
       print('PlatformException ${e.toString()}');
     }

     return result.index;
   }


}