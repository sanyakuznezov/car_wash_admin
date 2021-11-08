


 import 'package:car_wash_admin/data/api/model/model_time_api.dart';
import 'package:car_wash_admin/domain/model/model_time.dart';

class MapperTime{



  static ModelTime fromAPi({required ModelTimeApi modelTimeApi}){

    return ModelTime(hour: modelTimeApi.hour, minutes: modelTimeApi.minutes);

  }

 }