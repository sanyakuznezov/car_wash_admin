


 import 'package:car_wash_admin/data/api/model/model_service_api.dart';
import 'package:car_wash_admin/domain/model/model_service.dart';

class MapperDataService{


  static ModelService fromApi(ModelServiceApi modelServiceApi){

    return ModelService(listServices:fromApiList(modelServiceApi.listServices),id: modelServiceApi.id, type: modelServiceApi.type, name: modelServiceApi.name, isDetailing: modelServiceApi.isDetailing, price: modelServiceApi.price, time: modelServiceApi.time);
  }


  static  List<ModelItem> fromApiList(List<dynamic> list){

    return  (list as List)
        .map((x) => ModelItem(id:x['id'],name:x['name']))
        .toList();
  }

 }



