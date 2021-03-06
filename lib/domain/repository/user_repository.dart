


  import 'package:car_wash_admin/data/api/model/model_brand_car_api.dart';
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
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

abstract class UserRepository{

  Future<List<ModelWorker>?> getWorkers({required BuildContext context});
    Future<UserData?>authorizationUser({required String email,required String pass});
    Future<Map>validUser({required BuildContext context});
    Future<ResponseUploadAvatar>uploadImageAvatar({required XFile file});
    Future<bool> updateIdLang({required int idLang});
  Future<bool?> intersectionValidate({required BuildContext context,required Map<String,dynamic> map});
    Future<bool?> addOrder({required Map<String,dynamic> map,required BuildContext context});
    Future<bool>uploadDataUser({required String phone,required String firstname,required String patronymic,required String lastname,required String email});
    Future<List<ModelBrandCar>> getListBrandCar({required BuildContext context,required int id});
    Future<List<ModelService>?> getService({required BuildContext context,required int carType,required int serviceType, required bool isDetailing,required String query});
  Future<List<ModelService>?> getServiceInfo({required BuildContext context,required int carType,required int serviceType, required bool isDetailing,required String query});
    Future<ModelCalculatePrice?> getPrice({required BuildContext context,required int carType,required List<int> servicesIds, required List<int> complexesIds});
  Future<List<ModelSale>?> getSaleInfo({required BuildContext context,required int carType});
  Future<bool?> addQuickOrder({required BuildContext context, required Map<String, dynamic> map});
  Future<List<ModelOrder>?> getListOrder({required BuildContext context, required String date});
  Future<ModelTime> getListTimes({required BuildContext context, required String date,required int workTimeMin,required bool considerLeftTime});
  Future<ModelDataTable?> getDataSetting({required BuildContext context, required String date});
  Future<ModelOrderShow?> getOrderShow({required BuildContext context,required int id});
  Future<bool?> deleteOrder({required BuildContext context,required int id});
  Future<bool?> editOrder({required Map<String, dynamic> map, required BuildContext context,required int idOrder});
  Future<bool?> editOrderJournal({required String endAt,required String startAt,required BuildContext context,required int idOrder,required int post});
  Future<ModelTimeFreeIntervals?> getTimeFreeInterval({required String date,required BuildContext context,required int idOrder,required int post});
  }