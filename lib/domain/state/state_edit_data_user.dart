



 import 'package:car_wash_admin/data/local_data_base/app_data_base.dart';
import 'package:car_wash_admin/domain/model/user_data.dart';
import 'package:mobx/mobx.dart';
 part 'state_edit_data_user.g.dart';

  class StateEditDataUser=StateEditDataUserBase with _$StateEditDataUser;

abstract class StateEditDataUserBase with Store{

   @observable
   UserData? userData;
   @observable
   bool isLoad = false;
   @observable
   bool isError = false;



 @action
 Future<void> getDataUserLocal() async{
  isLoad=true;
  final database = await $FloorAppDataBase.databaseBuilder('app_database.db').build();
  final userDao = database.userataDao;
  final result=await userDao.getDataUser();
  userData=result!;
  isLoad=false;
 }




 }