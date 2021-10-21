


 class ModelCalculatePrice{

   bool result;
   int totalPrice;
   int sale;
   String saleName;
   int  workTime;
   int workTimeWithMultiplier;
   List<ModelServiceFromCalculate> list;

   ModelCalculatePrice({required this.result, required this.totalPrice, required this.sale, required this.saleName,
     required this.workTime, required this.workTimeWithMultiplier,required this.list});
 }



 class ModelServiceFromCalculate{

   int id;
   String type;
   String name;
   int price;
   int oldPrice;

   ModelServiceFromCalculate({required this.id, required this.type, required this.name, required this.price, required this.oldPrice});
}