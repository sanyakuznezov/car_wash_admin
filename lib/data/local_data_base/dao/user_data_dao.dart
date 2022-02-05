

 import 'package:car_wash_admin/domain/model/user_data.dart';
import 'package:floor/floor.dart';

@dao
 abstract class UserDataDao{



  @Query('SELECT * FROM UserData')
  Future<UserData?> getDataUser();

  @Query('UPDATE UserData SET avatar=:ava')
  Future<void> updateAvatar(String ava);

  @Query('UPDATE UserData SET firstname=:p1, lastname=:p2, patronymic=:p3, phone=:p4')
  Future<void> updateName(String p1,String p2,String p3,String p4);

   @Query('UPDATE UserData SET lang_id=:id')
   Future<void> updateLangId(int id);

  @insert
  Future<void> insertDataUser(UserData userData);

  @Query('DELETE FROM UserData')
  Future<void> clear();
}