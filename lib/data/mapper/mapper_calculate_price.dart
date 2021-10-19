



 import 'package:car_wash_admin/data/api/model/model_calculate_price_api.dart';
import 'package:car_wash_admin/domain/model/model_calculate_price.dart';

class MapperCalculatePrice{

  static ModelCalculatePrice? fromApi({required ModelCalculatePriceApi modelCalculatePriceApi}){
    return ModelCalculatePrice(result: modelCalculatePriceApi.result, totalPrice: modelCalculatePriceApi.totalPrice,
        sale: modelCalculatePriceApi.sale, saleName: modelCalculatePriceApi.saleName!,
        workTime: modelCalculatePriceApi.workTime, workTimeWithMultiplier: modelCalculatePriceApi.workTimeWithMultiplier);
  }




 }