


 import 'package:car_wash_admin/data/api/model/response_upload_avatar_api.dart';
import 'package:car_wash_admin/data/api/model/user_data_api.dart';
import 'package:car_wash_admin/data/api/model/user_data_api_valid.dart';
import 'package:car_wash_admin/domain/model/response_upload_avatar.dart';
import 'package:car_wash_admin/domain/model/user_data.dart';

class UserDataMapper{

   static UserData fromApi(ApiUserData value){
     return UserData(
        guid: value.guid,
        token: value.token,
        firstname: value.firstname,
        lastname: value.lastname,
        avatar: value.avatar,
        phone: value.phone,
        phone_verified: value.phone_verified,
        email: value.email,
        lang_id: value.lang_id,
        patronymic: value.patronymic,
        personals_id: value.personals[0]['id'],
        personals_carwash_id: value.personals[0]['carwash']['id'],
        personals_carwash_name:value.personals[0]['carwash']['name'],
        personals_carwash_avatar: value.personals[0]['carwash']['avatar'],
       personals_carwash_address:value.personals[0]['carwash']['address'],
       personals_carwash_timezone:value.personals[0]['carwash']['timezone'],
       personals_post: value.personals[0]['post']
        );
  }

   static bool fromValidApi(ApiUserDataValid value){
     return value.valid;
   }


   static ResponseUploadAvatar fromResponseUploadAvatarApi(ResponseUploadAvatarApi responseUploadAvatarApi){

     return ResponseUploadAvatar(result: responseUploadAvatarApi.result,url: responseUploadAvatarApi.url);
   }

}