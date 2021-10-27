




import 'dart:io';

import 'package:car_wash_admin/domain/state/bloc_table_order.dart';
import 'package:car_wash_admin/global_data.dart';

class AppModule{
    static BlocTableOrder? _blocTableOrder;

    static BlocTableOrder blocTableInstance(){
      HttpOverrides.global = MyHttpOverrides();
      GlobalData.date=DateTime.now().toString().split(' ')[0];
      _blocTableOrder=BlocTableOrder();
      return _blocTableOrder!;
    }

    static get blocTable =>_blocTableOrder;


}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}