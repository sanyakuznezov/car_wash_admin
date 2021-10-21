



 import 'package:car_wash_admin/data/api/model/model_calculate_price_api.dart';
import 'package:car_wash_admin/domain/model/model_calculate_price.dart';

class MapperCalculatePrice{

  static ModelCalculatePrice? fromApi({required ModelCalculatePriceApi modelCalculatePriceApi}){
    return ModelCalculatePrice(result: modelCalculatePriceApi.result, totalPrice: modelCalculatePriceApi.totalPrice,
        sale: modelCalculatePriceApi.sale, saleName: modelCalculatePriceApi.saleName!,
        workTime: modelCalculatePriceApi.workTime, workTimeWithMultiplier: modelCalculatePriceApi.workTimeWithMultiplier, list:fromApiList(modelCalculatePriceApi.list));
  }


 static  List<ModelServiceFromCalculate> fromApiList(List<dynamic> list){
   return  (list as List)
         .map((x) => ModelServiceFromCalculate(id:x['id'],type:x['type'],name:x['name'],price:x['price'],oldPrice:x['oldPrice']!=null?x['oldPrice']:0))
         .toList();
   }

 }