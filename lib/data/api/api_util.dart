


import 'package:car_wash_admin/data/api/service/main_service_api.dart';
import 'package:car_wash_admin/data/mapper/user_data_mapper.dart';
import 'package:car_wash_admin/domain/model/response_upload_avatar.dart';
import 'package:car_wash_admin/domain/model/user_data.dart';
import 'package:image_picker/image_picker.dart';

class ApiUtil{

    MainServiseApi _mainServiseApi;

    ApiUtil(this._mainServiseApi);

    Future<UserData> authorizationUser({required String email,required String pass}) async{
       final result= await _mainServiseApi.authorizationUser(email: email, pass: pass);
       return UserDataMapper.fromApi(result);

    }

    Future<bool> validUser() async{
      final result= await _mainServiseApi.validUser();
      return UserDataMapper.fromValidApi(result);

    }


    Future<ResponseUploadAvatar> uploadImageAvatar({required XFile file}) async{
          final result= await _mainServiseApi.uploadImageAvatar(file);
          return UserDataMapper.fromResponseUploadAvatarApi(result);
    }
}