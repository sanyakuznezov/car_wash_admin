

   import 'package:car_wash_admin/data/api/api_util.dart';
import 'package:car_wash_admin/domain/model/user_data.dart';
import 'package:car_wash_admin/domain/repository/user_repository.dart';

class UserDataRepository extends UserRepository{

  ApiUtil _apiUtil;
  UserDataRepository(this._apiUtil);


  @override
  Future<UserData> authorizationUser({required String email, required String pass})  async {
    // TODO: implement authorizationUser
    return _apiUtil.authorizationUser(email: email, pass: pass);
  }


}