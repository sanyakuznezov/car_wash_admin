



 import 'package:car_wash_admin/data/api/model/model_order_api.dart';
import 'package:car_wash_admin/domain/model/model_order.dart';

class MapperOrder{


  static ModelOrder fromApi({required ModelOrderApi modelOrderApi}){
     return ModelOrder(id: modelOrderApi.id, clientId: modelOrderApi.clientId, carNumber: modelOrderApi.carNumber,
         totalPrice: modelOrderApi.totalPrice, carRegion: modelOrderApi.carRegion, personalId: modelOrderApi.personalId,
         personalFullname: modelOrderApi.personalFullname, adminComment: modelOrderApi.adminComment,
         clientComment: modelOrderApi.clientComment, status: modelOrderApi.status,
         workMin: modelOrderApi.workMin, reputation: modelOrderApi.reputation, postId: modelOrderApi.postId,
         textArray: modelOrderApi.textArray, startDate: modelOrderApi.startDate, endDate: modelOrderApi.endDate,
         color: modelOrderApi.color, carType: modelOrderApi.carType, brandTitle: modelOrderApi.brandTitle,
         modelTitle: modelOrderApi.modelTitle, clientFullname: modelOrderApi.clientFullname, clientPhone: modelOrderApi.clientPhone);

  }


 }