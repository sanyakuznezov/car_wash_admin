




import 'dart:io';

import 'package:car_wash_admin/domain/state/strem_controllers.dart';
import 'package:car_wash_admin/global_data.dart';
import 'package:flutter/cupertino.dart';

class AppModule{
    static BlocTableOrder? _blocTableOrder;
    static  ValueNotifier<bool>?_notifierMain;
    static BlocTableOrder blocTableInstance() {
      HttpOverrides.global = MyHttpOverrides();
      GlobalData.date=DateTime.now().toString().split(' ')[0];
      _blocTableOrder=BlocTableOrder();
      _notifierMain=ValueNotifier(false);
      return _blocTableOrder!;
    }

    static get blocTable =>_blocTableOrder;
    static get notifiForReload=>_notifierMain;


}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}