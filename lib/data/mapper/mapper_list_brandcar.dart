


 import 'package:car_wash_admin/data/api/model/model_brand_car_api.dart';
import 'package:car_wash_admin/domain/model/model_brand_car.dart';

class MapperListBrandCar{

    static ModelBrandCar fromApi(ModelBrandCarApi modelBrandCarApi){
      return ModelBrandCar(id: modelBrandCarApi.id, title: modelBrandCarApi.title);
    }


 }