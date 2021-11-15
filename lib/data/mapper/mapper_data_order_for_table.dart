




 import 'package:car_wash_admin/domain/model/model_order.dart';

class MapperDataOrderForTable{

   static List<Map> fromApi({required List<ModelOrder> list}){
     List<Map> mapListForTable=[];
     int id=-1;
     list.forEach((element) {
       id++;
          mapListForTable.add(
              {'id':id,
                'enable':1,
                'start_date':element.startDate,
                'expiration_date':element.endDate,
                'orderBody':element,
                 'post':element.postId,
                // 'status':element.status,
                // 'brand_car':element.brandTitle,
                // 'type_car':element.modelTitle,
                // 'number_car':element.carNumber,
                // 'region':element.carRegion

              }
          );
     });
     return mapListForTable;
   }


 }