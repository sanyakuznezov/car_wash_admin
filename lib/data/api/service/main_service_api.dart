


  import 'dart:convert';

import 'package:car_wash_admin/data/api/model/user_data_api.dart';
import 'package:dio/dio.dart';

class MainServiseApi{

    static const _BASE_URL = 'https://app.crmstep.ru/api/v1/';

    final Dio _dio = Dio(
      BaseOptions(baseUrl: _BASE_URL),
    );


    Future<ApiUserData> authorizationUser({required String email,required String pass}) async{
      final value = {'email': email, 'password': pass};
      final response = await _dio.post(
        'auth/login',
        data: value,
        options: Options(
          contentType: 'application/x-www-form-urlencoded',
        )
      ).catchError((error){
        print('Error $error');
      });
      return ApiUserData.fromApi(response.data);
    }


  }