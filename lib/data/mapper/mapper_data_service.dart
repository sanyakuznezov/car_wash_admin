


 import 'package:car_wash_admin/data/api/model/model_service_api.dart';
import 'package:car_wash_admin/domain/model/model_service.dart';

class MapperDataService{


  static ModelService fromApi(ModelServiceApi modelServiceApi){

    return ModelService(id: modelServiceApi.id, type: modelServiceApi.type, name: modelServiceApi.name, isDetailing: modelServiceApi.isDetailing, price: modelServiceApi.price, time: modelServiceApi.time);
  }



 }