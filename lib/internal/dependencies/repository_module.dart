


 import 'package:car_wash_admin/data/repository/user_data_repository.dart';
import 'package:car_wash_admin/domain/repository/user_repository.dart';

import 'api_module.dart';

class RepositoryModule{

   static  UserRepository? _userRepository;


   static UserRepository userRepository() {
     if (_userRepository == null) {
       _userRepository = UserDataRepository(
         ApiModule.apiUtil(),
       );
     }
     return _userRepository!;
   }

 }