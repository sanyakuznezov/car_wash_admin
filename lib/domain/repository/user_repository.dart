


  import 'package:car_wash_admin/data/api/model/model_brand_car_api.dart';
import 'package:car_wash_admin/domain/model/model_brand_car.dart';
import 'package:car_wash_admin/domain/model/model_service.dart';
import 'package:car_wash_admin/domain/model/response_upload_avatar.dart';
import 'package:car_wash_admin/domain/model/user_data.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

abstract class UserRepository{

    Future<UserData?>authorizationUser({required String email,required String pass});
    Future<Map>validUser({required BuildContext context});
    Future<ResponseUploadAvatar>uploadImageAvatar({required XFile file});
    Future<bool> updateIdLang({required int id_lang});
    Future<bool>uploadNameUser({required String firstname,required String patronymic,required String lastname,required String email});
    Future<List<ModelBrandCar>> getListBrandCar({required BuildContext context,required int id});
    Future<List<ModelService>?> getService({required BuildContext context,required int carType,required int serviceType, required bool isDetailing,required String query});
  }