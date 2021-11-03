


import 'dart:convert';
import 'dart:io';

import 'package:car_wash_admin/data/api/model/model_brand_car_api.dart';
import 'package:car_wash_admin/data/api/model/model_calculate_price_api.dart';
import 'package:car_wash_admin/data/api/model/model_sale_api.dart';
import 'package:car_wash_admin/data/api/model/model_service_api.dart';
import 'package:car_wash_admin/data/api/model/model_worker_api.dart';
import 'package:car_wash_admin/data/api/model/response_upload_avatar_api.dart';
import 'package:car_wash_admin/data/api/model/user_data_api.dart';
import 'package:car_wash_admin/data/api/model/user_data_api_valid.dart';
import 'package:car_wash_admin/domain/state/bloc_verify_user.dart';
import 'package:car_wash_admin/utils/state_network.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

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
          sendTimeout: 5000,
          receiveTimeout: 10000,
          contentType: 'application/x-www-form-urlencoded',
        )
      ).catchError((error){
        print('Error ${error.toString()}');
      });
      return ApiUserData.fromApi(response.data);
    }


    Future<ApiUserDataValid?> validUser({required BuildContext context}) async{
      if(await StateNetwork.initConnectivity()==2){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('Отсутствует подключение к сети...'),));
      }else{
        BlocVerifyUser blocVerifyUser=BlocVerifyUser();
        Map data=await blocVerifyUser.checkDataValidUser();
        final value = {'guid': data['guid'] , 'token': data['token']};
        final response = await _dio.post(
            'auth/check-token',
            data: value,
            options: Options(
              sendTimeout: 5000,
              receiveTimeout: 10000,
              contentType: 'application/x-www-form-urlencoded',
            )
        ).catchError((error){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text('Ошибка получения данных...'),));
        });
        return ApiUserDataValid.fromApi(response.data);
      }

      return null;
    }

    Future<ResponseUploadAvatarApi> uploadImageAvatar(XFile file) async{
      BlocVerifyUser blocVerifyUser=BlocVerifyUser();
      Map data=await blocVerifyUser.checkDataValidUser();
      FormData formData = FormData.fromMap({
        'pId':  data['pid'],
        'token': data['token'],
         'file':await MultipartFile.fromFile(file.path, filename:file.name)
      });
      final response = await _dio.post(
          'personal/upload-image',
          data: formData,
          options: Options(
            sendTimeout: 5000,
            receiveTimeout: 10000,
            contentType: 'multipart/form-data',
          )
      ).catchError((error){
        print('Error ${error.toString()}');
      });

      return ResponseUploadAvatarApi.fromApi(response.data);
    }

    Future<bool> uploadNameUser({required String firstname,required String patronymic,required String lastname,required String email}) async{
      BlocVerifyUser blocVerifyUser=BlocVerifyUser();
      Map data=await blocVerifyUser.checkDataValidUser();
      final value = {'pId': data['pid'] , 'token': data['token'],'firstname':firstname,
        'lastname':lastname,'patronymic':patronymic,'email':email};
      await _dio.post(
          'personal/edit-profile',
          data: value,
          options: Options(
            sendTimeout: 5000,
            receiveTimeout: 10000,
            contentType: 'application/x-www-form-urlencoded',
          )
      ).catchError((error){
        print('Error ${error.toString()}');
      });
      return true;
    }

    Future<bool> updateIdLang({required int id_lang}) async{
      BlocVerifyUser blocVerifyUser=BlocVerifyUser();
      Map data=await blocVerifyUser.checkDataValidUser();
      final value = {'pId': data['pid'] , 'token': data['token'],'lang':id_lang};
      await _dio.post(
          'personal/edit-profile',
          data: value,
          options: Options(
            sendTimeout: 5000,
            receiveTimeout: 10000,
            contentType: 'application/x-www-form-urlencoded',
          )
      ).catchError((error){
        print('Error ${error.toString()}');
      });
      return true;
    }

    Future<List<ModelBrandCarApi>?> getListBrandCar({required BuildContext context,required int id})async{
      if(await StateNetwork.initConnectivity()==2){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('Отсутствует подключение к сети...'),));
      }else {
        var value;
        String? query;
        BlocVerifyUser blocVerifyUser = BlocVerifyUser();
        Map data = await blocVerifyUser.checkDataValidUser();
        if(id==0){
          value = {'cwid': data['cwid']};
          query='common/car-brands';
        }else{
          value = {'cwid': data['cwid'],'carBrandId':id,'query':''};
          query='common/car-models';
        }
        await new Future.delayed(const Duration(milliseconds: 500));
        final result = await _dio.get(
           query,
           queryParameters: value,
        ).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text('Ошибка получения данных...'),));
        });
        return (result.data['items'] as List)
            .map((x) => ModelBrandCarApi.fromApi(x))
            .toList();
      }
      return null;
    }

   Future<List<ModelServiceApi>?> getService({required BuildContext context,required int carType,required int serviceType, required bool isDetailing,required String query})async{
     if(await StateNetwork.initConnectivity()==2){
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
         backgroundColor: Colors.red,
         content: Text('Отсутствует подключение к сети...'),));
     }else {
       BlocVerifyUser blocVerifyUser = BlocVerifyUser();
       Map data = await blocVerifyUser.checkDataValidUser();
       final value = {'cwId': data['cwid'],'pId': data['pid'],'carType':carType,'serviceType':serviceType,'isDetailing':isDetailing,'query':query};
       await new Future.delayed(const Duration(milliseconds: 500));
       final result=await _dio.post(
           'services/list',
           data: value,
           options: Options(
             sendTimeout: 5000,
             receiveTimeout: 10000,
             contentType: 'application/x-www-form-urlencoded',
           )
       ).catchError((error){
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
           backgroundColor: Colors.red,
           content: Text('Ошибка получения данных...'),));
       });

       return (result.data['items'] as List)
           .map((x) => ModelServiceApi.fromApi(x))
           .toList();
     }

    return null;
   }


    Future<List<ModelServiceApi>?> getServiceInfo({required BuildContext context,required int carType,required int serviceType, required bool isDetailing,required String query})async{
      if(await StateNetwork.initConnectivity()==2){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('Отсутствует подключение к сети...'),));
      }else {
        BlocVerifyUser blocVerifyUser = BlocVerifyUser();
        Map data = await blocVerifyUser.checkDataValidUser();
        final value = {'cwId': data['cwid'],'pId': data['pid'],'carType':carType,'serviceType':serviceType,'isDetailing':isDetailing,'query':query};
        await new Future.delayed(const Duration(milliseconds: 500));
        final result=await _dio.post(
            'services/info-services',
            data: value,
            options: Options(
              sendTimeout: 5000,
              receiveTimeout: 10000,
              contentType: 'application/x-www-form-urlencoded',
            )
        ).catchError((error){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text('Ошибка получения данных...'),));
        });

        return (result.data['items'] as List)
            .map((x) => ModelServiceApi.fromApi(x))
            .toList();
      }

      return null;
    }




    Future<ModelCalculatePriceApi?> getPrice({required BuildContext context,required int carType,required List<int> servicesIds, required List<int> complexesIds})async{

     if(await StateNetwork.initConnectivity()==2){
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
         backgroundColor: Colors.red,
         content: Text('Отсутствует подключение к сети...'),));
     }else {
       BlocVerifyUser blocVerifyUser = BlocVerifyUser();
       Map data = await blocVerifyUser.checkDataValidUser();
       final value = {
         'cwId': data['cwid'],
         'pId': data['pid'],
         'carType': carType,
         'servicesIds':servicesIds.join(','),
         'complexesIds': complexesIds.join(',')
       };
       final result=await _dio.post(
           'orders/calculate-price',
           data: value,
           options: Options(
             sendTimeout: 5000,
             receiveTimeout: 10000,
             contentType: 'application/x-www-form-urlencoded',
           )
       ).catchError((error){
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
           backgroundColor: Colors.red,
           content: Text('Ошибка получения данных о стоимости...'),));
       });
       return ModelCalculatePriceApi.fromApi(map:result.data);
     }

      return null;
   }

    Future<List<ModelWorkerApi>?> getWorkers({required BuildContext context}) async{
      if(await StateNetwork.initConnectivity()==2){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('Отсутствует подключение к сети...'),));
      }else {
        BlocVerifyUser blocVerifyUser = BlocVerifyUser();
        Map data = await blocVerifyUser.checkDataValidUser();
        final value = {
          'cwId': data['cwid'],
          'pId': data['pid'],
          'token': data['token']
        };
        final result=await _dio.post(
            'personal/list',
            data: value,
            options: Options(
              sendTimeout: 5000,
              receiveTimeout: 10000,
              contentType: 'application/x-www-form-urlencoded',
            )
        ).catchError((error){
          print('Error $error');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text('Ошибка получения данных о сотрудниках...'),));
        });
        return (result.data['personal'] as List)
            .map((x) => ModelWorkerApi.fromApi(map: x))
            .toList();
      }

      return null;
    }


    Future<bool?> addOrder({required Map<String,dynamic> map,required BuildContext context}) async{
      if(await StateNetwork.initConnectivity()==2){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text('Отсутствует подключение к сети...'),));
      }else {
      BlocVerifyUser blocVerifyUser = BlocVerifyUser();
      Map data = await blocVerifyUser.checkDataValidUser();
      final value = {
      'cwId': data['cwid'],
      'pId': data['pid'],
        'token': data['token'],
        'date':map['date'],
        'post':map['post'],
        'startTime':map['startTime'],
        'endTime':map['endTime'],
        'carType':map['carType'],
        'carNumber':map['carNumber'],
        'carRegion':map['carRegion'],
        'color':map['color'],
        'carBrandId':map['carBrandId'],
        'carModelId':map['carModelId'],
        'clientFullname':map['clientFullname'],
        'clientPhone':map['clientPhone'],
        'totalPrice':map['totalPrice'],
        'sale':map['sale'],
        'workTime':map['workTime'],
        'status':map['status'],
        'adminComment':map['adminComment'],
        'clientComment':map['clientComment'],
        'ComplexesList':map['ComplexesList'].join(','),
        'ServicesList':map['ServicesList'].join(',')
      };

      try {
        final result = await _dio
                    .post('orders/create',
                        data: value,
                        options: Options(
                          sendTimeout: 5000,
                          receiveTimeout: 10000,
                  contentType: 'application/x-www-form-urlencoded',
                ));
        return result.data['result'];
      }on DioError catch (e) {
        if(e.type==DioErrorType.receiveTimeout||e.type==DioErrorType.sendTimeout){
          Fluttertoast.showToast(
              msg: "Сервер не отвечает, повторите попытку",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.red,
              textColor: Colors.black,
              fontSize: 16.0
          );

        }
        if(e.response!=null){
          Fluttertoast.showToast(
              msg: "${e.response!.data['errors']['startTime']==null?e.response!.data['errors']['post']:e.response!.data['errors']['startTime']}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.red,
              textColor: Colors.black,
              fontSize: 16.0
          );

        }
        return false;

      }

    }

    return null;
  }



  Future<bool?> intersectionValidate({required BuildContext context,required Map<String,dynamic> map})async{
    if(await StateNetwork.initConnectivity()==2){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('Отсутствует подключение к сети...'),));
    }else {
      BlocVerifyUser blocVerifyUser = BlocVerifyUser();
      Map data = await blocVerifyUser.checkDataValidUser();
      final value = {
        'cwId': data['cwid'],
        'post':map['post'],
        'pId': data['pid'],
        'orderId': null,
        'date':map['date'],
        'startTime':map['startTime'],
        'endTime':map['endTime']
      };
      try {
        final result=await _dio.post(
                  'common/validate-order-time',
                  data: value,
                  options: Options(
                    sendTimeout: 5000,
                    receiveTimeout: 10000,
                    contentType: 'application/x-www-form-urlencoded',
                  ));
        if(result.data['intersection']!=null){
          if(!result.data['intersection']){
            return true;
          }else{
            Fluttertoast.showToast(
                msg: "Данное время уже занято...",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.red,
                textColor: Colors.black,
                fontSize: 16.0
            );
            return false;
          }
        }

      }on DioError catch (e) {
        if(e.type==DioErrorType.receiveTimeout||e.type==DioErrorType.sendTimeout){
          Fluttertoast.showToast(
              msg: "Сервер не отвечает, повторите попытку",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.red,
              textColor: Colors.black,
              fontSize: 16.0
          );
          return false;
        }
        if(e.response!=null){
          if(e.response!.statusCode==400){
            Fluttertoast.showToast(
                msg: "Время начала и окончания совпадает",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.red,
                textColor: Colors.black,
                fontSize: 16.0
            );
          }
          if(e.response!.statusCode==403){
            Fluttertoast.showToast(
                msg: "Нет доступа",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.red,
                textColor: Colors.black,
                fontSize: 16.0
            );
          }

          if(e.response!.statusCode==404){
            Fluttertoast.showToast(
                msg: "Заказ не найден",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.red,
                textColor: Colors.black,
                fontSize: 16.0
            );
          }

          if(e.response!.statusCode==500){
            Fluttertoast.showToast(
                msg: "Ошибка сервера",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.red,
                textColor: Colors.black,
                fontSize: 16.0
            );
          }

          return false;
        }
      }

    }

    return null;
  }


    Future<List<ModelSaleApi>?> getSaleInfo({required BuildContext context,required int carType})async{
      if(await StateNetwork.initConnectivity()==2){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('Отсутствует подключение к сети...'),));
      }else {
        BlocVerifyUser blocVerifyUser = BlocVerifyUser();
        Map data = await blocVerifyUser.checkDataValidUser();
        final value = {'cwId': data['cwid'],'pId': data['pid'],'carType':carType};
        try {
          final result=await _dio.post(
                      'services/info-sales',
                      data: value,
                      options: Options(
                        sendTimeout: 5000,
                        receiveTimeout: 10000,
                        contentType: 'application/x-www-form-urlencoded',
                      )
                  ).catchError((error){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Ошибка получения данных...'),));
                  });

          return (result.data['sales'] as List)
              .map((x) => ModelSaleApi.fromApi(data: x))
              .toList();
        }on DioError catch (e) {
          if(e.response!=null) {
            if (e.response!.statusCode == 400) {
              Fluttertoast.showToast(
                  msg: "Не все обязательные параметры переданы",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 3,
                  backgroundColor: Colors.red,
                  textColor: Colors.black,
                  fontSize: 16.0
              );
            }
          }
        }

      }

      return null;
    }





}