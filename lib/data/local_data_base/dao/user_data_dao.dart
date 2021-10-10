

 import 'package:car_wash_admin/domain/model/user_data.dart';
import 'package:floor/floor.dart';

@dao
 abstract class UserDataDao{



  @Query('SELECT * FROM UserData')
  Future<UserData?> getDataUser();

  @Query('UPDATE UserData SET avatar=:ava')
  Future<void> updateAvatar(String ava);

  @insert
  Future<void> insertDataUser(UserData userData);

}