

 import 'package:car_wash_admin/domain/model/model_calculate_price.dart';

class ModelCalculatePriceApi{

   bool result;
   int totalPrice;
   int sale;
   String? saleName;
   int  workTime;
   int workTimeWithMultiplier;
   List<dynamic> list;

   ModelCalculatePriceApi.fromApi({required Map<String,dynamic> map}):
       result=map['result'],
       totalPrice=map['totalPrice'],
       sale=map['sale'],
       saleName=map['saleName']==null?'':map['saleName'],
        workTime=map['workTime'],
       workTimeWithMultiplier=map['workTimeWithMultiplier'],
       list=map['items'];
}



