

 import 'package:car_wash_admin/domain/model/user_data.dart';
import 'package:floor/floor.dart';

@dao
 abstract class UserDataDao{



  @Query('SELECT * FROM UserData')
  Future<UserData?> getDataUser();


  @insert
  Future<void> insertDataUser(UserData userData);

}