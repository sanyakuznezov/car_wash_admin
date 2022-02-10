

   import 'package:car_wash_admin/data/api/api_util.dart';
import 'package:car_wash_admin/data/api/model/model_brand_car_api.dart';
import 'package:car_wash_admin/data/local_data_base/app_data_base.dart';
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
import 'package:car_wash_admin/domain/repository/user_repository.dart';
import 'package:flutter/widgets.dart';
   import 'package:image_picker/image_picker.dart';

class UserDataRepository extends UserRepository{

  ApiUtil _apiUtil;
  UserDataRepository(this._apiUtil);


  @override
  Future<UserData?>authorizationUser({required String email, required String pass})  async {
    final database = await $FloorAppDataBase.databaseBuilder('app_database.db').build();
    final userDao = database.userataDao;
    final userData=await _apiUtil.authorizationUser(email: email, pass: pass);
    await userDao.insertDataUser(userData);
    final data=await userDao.getDataUser();
    await _apiUtil.updateFirebaseToken(data!);
    print('Read in database ${data!.email}');
    return data;
  }

  @override
  Future<Map> validUser({required BuildContext context}) async{
     bool valid= await _apiUtil.validUser(context: context);
     final database = await $FloorAppDataBase.databaseBuilder('app_database.db').build();
     final userDao = database.userataDao;
     final data=await userDao.getDataUser();
     await _apiUtil.updateFirebaseToken(data!);
     print('validUser $context data $data');
      return {'valid':valid,'data_user':data};
  }

  @override
  Future<ResponseUploadAvatar> uploadImageAvatar({required XFile file})async {
    final result=await _apiUtil.uploadImageAvatar(file: file);
    final database = await $FloorAppDataBase.databaseBuilder('app_database.db').build();
    final userDao = database.userataDao;
    await userDao.updateAvatar(result.url).catchError((error){
      print('Error DB $error');
    });
     return result;
  }

  @override
  Future<bool> uploadDataUser({required String phone,required String firstname, required String patronymic, required String lastname, required String email})async {
    await _apiUtil.uploadDataUser(phone:phone,firstname: firstname, patronymic: patronymic, lastname: lastname, email: email);
    final database = await $FloorAppDataBase.databaseBuilder('app_database.db').build();
    final userDao = database.userataDao;
    await userDao.updateName(firstname,lastname,patronymic,phone).catchError((error){
      print('Error DB $error');
    });
    return true;
  }

  @override
  Future<bool> updateIdLang({required int idLang}) async{
     await _apiUtil.updateIdLang(idLang: idLang);
     final database = await $FloorAppDataBase.databaseBuilder('app_database.db').build();
     final userDao = database.userataDao;
     await userDao.updateLangId(idLang).catchError((error){
       print('Error DB $error');
     });
    return true;
  }

  @override
  Future<List<ModelBrandCar>> getListBrandCar({required BuildContext context,required int id}) async{
    return await _apiUtil.getListBrandCar(context: context,id: id);
  }

  @override
  Future<List<ModelService>> getService({required BuildContext context, required int carType, required int serviceType, required bool isDetailing, required String query}) async {
    return await _apiUtil.getService(context: context, carType: carType, serviceType: serviceType, isDetailing: isDetailing, query: query);
  }

  @override
  Future<List<ModelService>> getServiceInfo({required BuildContext context, required int carType, required int serviceType, required bool isDetailing, required String query}) async {
    return await _apiUtil.getService(context: context, carType: carType, serviceType: serviceType, isDetailing: isDetailing, query: query);
  }


  @override
  Future<ModelCalculatePrice?> getPrice({required BuildContext context, required int carType, required List<int> servicesIds, required List<int> complexesIds})async {
    return await _apiUtil.getPrice(context: context, carType: carType, servicesIds: servicesIds, complexesIds: complexesIds);
  }

  @override
  Future<List<ModelWorker>?> getWorkers({required BuildContext context}) async{
    return await _apiUtil.getWorkers(context: context);
  }

  @override
  Future<bool?> addOrder({required Map<String, dynamic> map, required BuildContext context}) async{
   return await _apiUtil.addOrder(map: map, context: context);
  }

  @override
  Future<bool?> intersectionValidate({required BuildContext context, required Map<String, dynamic> map}) async{
   return await _apiUtil.intersectionValidate(context: context, map: map);
  }

  @override
  Future<List<ModelSale>?> getSaleInfo({required BuildContext context, required int carType})async {
   return await _apiUtil.getSaleInfo(context: context, carType: carType);
  }

  @override
  Future<bool?> addQuickOrder({required BuildContext context, required Map<String, dynamic> map})async {
     return await _apiUtil.addQuickOrder(context: context, map: map);
  }

  @override
  Future<List<ModelOrder>?> getListOrder({required BuildContext context, required String date})async {
   return await _apiUtil.getListOrder(context: context, date: date);
  }

  @override
  Future<ModelTime> getListTimes({required BuildContext context, required String date, required int workTimeMin, required bool considerLeftTime}) async{
    return await _apiUtil.getListTimes(context: context, date: date, workTimeMin: workTimeMin, considerLeftTime: considerLeftTime);
  }

  @override
  Future<ModelDataTable?> getDataSetting({required BuildContext context, required String date})async {
    return await _apiUtil.getDataSetting(context: context, date: date);
  }

  @override
  Future<ModelOrderShow?> getOrderShow({ required BuildContext context, required int id})async {
    return await _apiUtil.getOrderShow(context: context, id: id);
  }

  @override
  Future<bool?> deleteOrder({required BuildContext context, required int id}) async{
    return await _apiUtil.deleteOrder(context: context, id: id);
  }

  @override
  Future<bool?> editOrder({required Map<String, dynamic> map, required BuildContext context, required int idOrder}) {
   return _apiUtil.editOrder(map: map, context: context, idOrder: idOrder);
  }

  @override
  Future<bool?> editOrderJournal({required String endAt, required String startAt, required BuildContext context, required int idOrder, required int post}) {
   return _apiUtil.editOrderJournal(endAt: endAt, startAt: startAt, context: context, idOrder: idOrder, post: post);
  }

  @override
  Future<ModelTimeFreeIntervals?> getTimeFreeInterval({required String date, required BuildContext context, required int idOrder, required int post}) {
    return _apiUtil.getTimeFreeInterval(date: date, context: context, idOrder: idOrder, post: post);
  }







}