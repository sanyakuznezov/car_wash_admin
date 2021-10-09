


  import 'package:car_wash_admin/domain/model/response_upload_avatar.dart';
import 'package:car_wash_admin/domain/model/user_data.dart';
import 'package:image_picker/image_picker.dart';

abstract class UserRepository{

    Future<UserData?>authorizationUser({required String email,required String pass});
    Future<Map>validUser();
    Future<ResponseUploadAvatar>uploadImageAvatar({required XFile file});
  }