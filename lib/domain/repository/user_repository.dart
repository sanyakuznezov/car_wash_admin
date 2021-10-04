


  import 'package:car_wash_admin/domain/model/user_data.dart';

abstract class UserRepository{

    Future<UserData?>authorizationUser({required String email,required String pass});
    Future<bool>validUser();
  }