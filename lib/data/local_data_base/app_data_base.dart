



import 'package:car_wash_admin/domain/model/user_data.dart';
import 'package:floor/floor.dart';
// database.dart

// required package imports
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dao/user_data_dao.dart';
part 'app_data_base.g.dart';

@Database(version: 1, entities: [UserData])
 abstract class AppDataBase extends FloorDatabase{
  UserDataDao get userataDao;


}