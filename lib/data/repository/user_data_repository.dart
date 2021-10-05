

   import 'package:car_wash_admin/data/api/api_util.dart';
import 'package:car_wash_admin/data/local_data_base/app_data_base.dart';
import 'package:car_wash_admin/domain/model/user_data.dart';
import 'package:car_wash_admin/domain/repository/user_repository.dart';

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
  Future<Map> validUser() async{
     bool valid= await _apiUtil.validUser();
     final database = await $FloorAppDataBase.databaseBuilder('app_database.db').build();
     final userDao = database.userataDao;
     final data=await userDao.getDataUser();
   return {'valid':valid,'data_user':data};
  }





}