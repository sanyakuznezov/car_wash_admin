

   import 'package:car_wash_admin/data/api/api_util.dart';
import 'package:car_wash_admin/data/api/model/model_brand_car_api.dart';
import 'package:car_wash_admin/data/local_data_base/app_data_base.dart';
import 'package:car_wash_admin/domain/model/model_brand_car.dart';
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
    // TODO: implement authorizationUser
    final database = await $FloorAppDataBase.databaseBuilder('app_database.db').build();
    final userDao = database.userataDao;
    final userData=await _apiUtil.authorizationUser(email: email, pass: pass);
    await userDao.insertDataUser(userData);
    final data=await userDao.getDataUser();
    return data;
  }

  @override
  Future<Map> validUser({required BuildContext context}) async{
     bool valid= await _apiUtil.validUser(context: context);
     final database = await $FloorAppDataBase.databaseBuilder('app_database.db').build();
     final userDao = database.userataDao;
     final data=await userDao.getDataUser();

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
  Future<bool> uploadNameUser({required String firstname, required String patronymic, required String lastname, required String email})async {
    await _apiUtil.uploadNameUser(firstname: firstname, patronymic: patronymic, lastname: lastname, email: email);
    final database = await $FloorAppDataBase.databaseBuilder('app_database.db').build();
    final userDao = database.userataDao;
    await userDao.updateName(firstname,lastname,patronymic).catchError((error){
      print('Error DB $error');
    });
    return true;
  }

  @override
  Future<bool> updateIdLang({required int id_lang}) async{
     await _apiUtil.updateIdLang(id_lang: id_lang);
     final database = await $FloorAppDataBase.databaseBuilder('app_database.db').build();
     final userDao = database.userataDao;
     await userDao.updateLangId(id_lang).catchError((error){
       print('Error DB $error');
     });
    return true;
  }

  @override
  Future<List<ModelBrandCar>> getListBrandCar({required BuildContext context,required int id}) async{
    return await _apiUtil.getListBrandCar(context: context,id: id);
  }







}