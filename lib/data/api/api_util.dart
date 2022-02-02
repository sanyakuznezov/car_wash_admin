


import 'package:car_wash_admin/data/api/service/main_service_api.dart';
import 'package:car_wash_admin/data/mapper/mapper_data_table.dart';
import 'package:car_wash_admin/data/mapper/mapper_calculate_price.dart';
import 'package:car_wash_admin/data/mapper/mapper_data_service.dart';
import 'package:car_wash_admin/data/mapper/mapper_data_worker.dart';
import 'package:car_wash_admin/data/mapper/mapper_intervals_free_time.dart';
import 'package:car_wash_admin/data/mapper/mapper_list_brandcar.dart';
import 'package:car_wash_admin/data/mapper/mapper_model_order_show.dart';
import 'package:car_wash_admin/data/mapper/mapper_order.dart';
import 'package:car_wash_admin/data/mapper/mapper_sale.dart';
import 'package:car_wash_admin/data/mapper/mapper_time.dart';
import 'package:car_wash_admin/data/mapper/user_data_mapper.dart';
import 'package:car_wash_admin/domain/model/model_brand_car.dart';
import 'package:car_wash_admin/domain/model/model_calculate_price.dart';
import 'package:car_wash_admin/domain/model/model_data_table.dart';
import 'package:car_wash_admin/domain/model/model_order.dart';
import 'package:car_wash_admin/domain/model/model_order_show.dart';
import 'package:car_wash_admin/domain/model/model_sale.dart';
import 'package:car_wash_admin/domain/model/model_service.dart';
import 'package:car_wash_admin/domain/model/model_time.dart';
import 'package:car_wash_admin/domain/model/model_time_free_intervals.dart';
import 'package:car_wash_admin/domain/model/model_worker.dart';
import 'package:car_wash_admin/domain/model/response_upload_avatar.dart';
import 'package:car_wash_admin/domain/model/user_data.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import 'model/model_data_table_api.dart';
import 'model/model_brand_car_api.dart';
import 'model/model_order_api.dart';
import 'model/model_sale_api.dart';

class ApiUtil{

    MainServiseApi _mainServiseApi;

    ApiUtil(this._mainServiseApi);

    Future<UserData> authorizationUser({required String email,required String pass}) async{
       final result= await _mainServiseApi.authorizationUser(email: email, pass: pass);
       return UserDataMapper.fromApi(result);

    }

    Future<bool> validUser({required BuildContext context}) async{
      final result= await _mainServiseApi.validUser(context: context);
      return UserDataMapper.fromValidApi(result!);

    }

    Future<void> updateFirebaseToken(UserData userdata)async{
      await _mainServiseApi.updateFirebaseToken(userData:userdata );

    }


    Future<ResponseUploadAvatar> uploadImageAvatar({required XFile file}) async{
          final result= await _mainServiseApi.uploadImageAvatar(file);
          return UserDataMapper.fromResponseUploadAvatarApi(result);
    }

    Future<bool>uploadDataUser({required String phone,required String firstname,required String patronymic,required String lastname,required String email}) async{
     await _mainServiseApi.uploadDataUser(phone:phone,firstname: firstname, patronymic: patronymic, lastname: lastname, email: email);
      return true;
    }
    Future<bool>updateIdLang({required int idLang})async{
      await _mainServiseApi.updateIdLang(idLang: idLang);
      return true;
    }

    Future<List<ModelBrandCar>> getListBrandCar({required BuildContext context,required int id}) async{
      List<ModelBrandCar> list=[];
      final result=await _mainServiseApi.getListBrandCar(context: context,id: id);
      result!.forEach((element) {
        list.add(MapperListBrandCar.fromApi(element));
      });
      return list;
    }

    Future<List<ModelService>> getService({required BuildContext context,required int carType,required int serviceType, required bool isDetailing,required String query}) async{
      List<ModelService> list=[];
      final result=await _mainServiseApi.getService(context: context, carType: carType, serviceType: serviceType, isDetailing: isDetailing, query: query);
      result!.forEach((element) {
        list.add(MapperDataService.fromApi(element));
      });
      return list;
    }

    Future<ModelCalculatePrice?> getPrice({required BuildContext context,required int carType,required List<int> servicesIds, required List<int> complexesIds})async{
      final result=await _mainServiseApi.getPrice(context: context, carType: carType, servicesIds: servicesIds, complexesIds: complexesIds);
      return MapperCalculatePrice.fromApi(modelCalculatePriceApi: result!);

    }


    Future<List<ModelWorker>?> getWorkers({required BuildContext context}) async{
      List<ModelWorker> list=[];
      final result= await _mainServiseApi.getWorkers(context: context);
      result!.forEach((element) {
        list.add(MapperDataWorker.fromApi(element));
      });
      return list;
    }

    Future<bool?> addOrder({required Map<String,dynamic> map,required BuildContext context})async{
       return await _mainServiseApi.addOrder(map: map, context: context);

    }
    Future<bool?> intersectionValidate({required BuildContext context,required Map<String,dynamic> map})async{
       return await _mainServiseApi.intersectionValidate(context: context, map: map);
    }

    Future<List<ModelSale>?> getSaleInfo({required BuildContext context,required int carType}) async{
      List<ModelSale> list=[];
      final result= await _mainServiseApi.getSaleInfo(context: context,carType: carType);
      result!.forEach((element) {
        list.add(MapperSale.fromApi(modelSaleApi: element));
      });
      return list;
    }

    Future<bool?> addQuickOrder({required BuildContext context, required Map<String, dynamic> map}) async{
      return await _mainServiseApi.addQuickOrder(context: context, map: map);
    }

    Future<List<ModelOrder>?> getListOrder({required BuildContext context,required String date}) async{
      List<ModelOrder> list=[];
      final result= await _mainServiseApi.getListOrder(context: context,date: date);
      result!.forEach((element) {
        list.add(MapperOrder.fromApi(modelOrderApi: element));
      });
      return list;
    }


    Future<ModelTime> getListTimes({required BuildContext context, required String date,required int workTimeMin,required bool considerLeftTime})async{
      final result= await _mainServiseApi.getListTimes(context: context,date: date,workTimeMin: workTimeMin,considerLeftTime: considerLeftTime);
      return MapperTime.fromAPi(modelTimeApi: result!);
    }

    Future<ModelDataTable?> getDataSetting({required BuildContext context, required String date})async{
      final result=await _mainServiseApi.getDataSetting(context: context, date: date);
      return MapperDataTable.fromApi(modelDataTableApi: result!);
    }

    Future<ModelOrderShow?> getOrderShow({required BuildContext context,required int id}) async{
      final result=await _mainServiseApi.getOrderShow(context: context, id: id);
      return MapperModelOrderShow.fromApi(modelOrderShowApi: result!);

    }

    Future<bool?> deleteOrder({required BuildContext context,required int id}) async{
       final result=await _mainServiseApi.deleteOrder(context: context, id: id);
       return result;
    }

    Future<bool?> editOrder({required Map<String, dynamic> map, required BuildContext context, required int idOrder})async{
      final result=await _mainServiseApi.editOrder(map: map, context: context, idOrder: idOrder);
      return result;
    }

    Future<bool?> editOrderJournal({required String endAt,required String startAt,required BuildContext context,required int idOrder,required int post})async{
      final result=await _mainServiseApi.editOrderJournal(endAt: endAt, startAt: startAt, context: context, idOrder: idOrder, post: post
      );
      return result;
    }

   static  List<ModelOrderApi>? getList({required Response<dynamic> orders,required String selectedDate}){
     List<ModelOrderApi>? list=[];
     (orders.data['orders'] as List).forEach((element) {
       if(element['startDate'].split(' ')[0]==selectedDate||element['endDate'].split(' ')[0]==selectedDate){
         list.add(ModelOrderApi.fromApi(map: element));
       }
   });
     return list;
    }

    Future<ModelTimeFreeIntervals?> getTimeFreeInterval({required String date,required BuildContext context,required int idOrder,required int post}) async {
      final result= await _mainServiseApi.getTimeFreeInterval(date: date, context: context, idOrder: idOrder, post: post);
      return MapperIntervalsFree.fromApi(modelTimeFreeIntervalsApi:result!);
    }
}