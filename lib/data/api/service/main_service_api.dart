


  import 'package:car_wash_admin/data/api/model/user_data.dart';
import 'package:dio/dio.dart';

class MainServiseApi{

    static const _BASE_URL = 'https://app.crmstep.ru/api/v1/';

    final Dio _dio = Dio(
      BaseOptions(baseUrl: _BASE_URL),
    );


    Future<ApiUserData> authorizationUser({required String email,required String pass}) async{
      final query = {'email': email, 'password': pass};
      final response = await _dio.get(
        '/json',
        queryParameters: query,
      );
      return ApiUserData.fromApi(response.data);
    }


  }