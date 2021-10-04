


  import 'dart:convert';

import 'package:car_wash_admin/data/api/model/user_data_api.dart';
import 'package:car_wash_admin/data/api/model/user_data_api_valid.dart';
import 'package:car_wash_admin/domain/state/bloc_verify_user.dart';
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
        print('Error ${error.toString()}');
      });
      return ApiUserData.fromApi(response.data);
    }


    Future<ApiUserDataValid> validUser() async{
      BlocVerifyUser blocVerifyUser=BlocVerifyUser();
      Map data=await blocVerifyUser.checkDataValidUser();
       final value = {'guid': data['guid'] , 'token': data['token']};
       final response = await _dio.post(
          'auth/check-token',
          data: value,
          options: Options(
            contentType: 'application/x-www-form-urlencoded',
          )
      ).catchError((error){
        print('Error ${error.toString()}');
      });
      return ApiUserDataValid.fromApi(response.data);
    }


  }