



 import 'package:car_wash_admin/data/api/model/model_sale_api.dart';
import 'package:car_wash_admin/domain/model/model_sale.dart';

class MapperSale{


 static ModelSale fromApi({required ModelSaleApi modelSaleApi}){
    return ModelSale(id: modelSaleApi.id,name: modelSaleApi.name,description:modelSaleApi.description,forServiceTypeText: modelSaleApi.forServiceTypeText,
        onlySubscribers:modelSaleApi.onlySubscribers,saleText:modelSaleApi.saleText,startAt: modelSaleApi.startAt,endAt: modelSaleApi.endAt,itemsText: modelSaleApi.itemsText);
  }


 }