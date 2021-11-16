


 import 'package:car_wash_admin/data/api/model/model_order_show_api.dart';
import 'package:car_wash_admin/domain/model/model_order_show.dart';

class MapperModelOrderShow{


  static ModelOrderShow fromApi({required ModelOrderShowApi modelOrderShowApi}){
    return ModelOrderShow(id: modelOrderShowApi.id, carwashId: modelOrderShowApi.carwashId,
        personalId: modelOrderShowApi.personalId, personalFullname: modelOrderShowApi.personalFullname,
        date: modelOrderShowApi.date, post: modelOrderShowApi.post, startTime: modelOrderShowApi.startTime,
        endTime: modelOrderShowApi.endTime, carType: modelOrderShowApi.carType,
        carNumber: modelOrderShowApi.carNumber, carRegion: modelOrderShowApi.carRegion,
        color: modelOrderShowApi.color, carBrandid: modelOrderShowApi.carBrandid,
        carBrandcarwash_id: modelOrderShowApi.carBrandcarwash_id,
        carBrandtitle: modelOrderShowApi.carBrandtitle, carBrandicon: modelOrderShowApi.carBrandicon,
        carBrandsynonyms: modelOrderShowApi.carBrandsynonyms, carBrandcreated_at: modelOrderShowApi.carBrandcreated_at,
        carModelid: modelOrderShowApi.carModelid, carModelcar_brand_id: modelOrderShowApi.carModelcar_brand_id,
        carModelcarwash_id: modelOrderShowApi.carModelcarwash_id, carModeltitle: modelOrderShowApi.carModeltitle,
        carModelsynonyms: modelOrderShowApi.carModelsynonyms, carModelcreated_at: modelOrderShowApi.carModelcreated_at,
        clientFullname: modelOrderShowApi.clientFullname, clientPhone: modelOrderShowApi.clientPhone,
        totalPrice: modelOrderShowApi.totalPrice, sale: modelOrderShowApi.sale, workTime: modelOrderShowApi.workTime,
        status: modelOrderShowApi.status, adminComment: modelOrderShowApi.adminComment, clientComment: modelOrderShowApi.clientComment,
        created_at: modelOrderShowApi.created_at, services: modelOrderShowApi.services, complexes: modelOrderShowApi.complexes);


  }


 }