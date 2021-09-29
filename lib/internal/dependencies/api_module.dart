


 import 'package:car_wash_admin/data/api/api_util.dart';
import 'package:car_wash_admin/data/api/service/main_service_api.dart';

class ApiModule{

  static ApiUtil? _apiUtil;

   static ApiUtil apiUtil() {
     if (_apiUtil == null) {
       _apiUtil = ApiUtil(MainServiseApi());
     }
     return _apiUtil!;
   }
 }