



 class ModelServiceApi{

   int id;
   String type;
   String name;
   bool isDetailing;
   int price;
   int time;

   ModelServiceApi.fromApi(Map<String,dynamic> map):
        id=map['id'],
        type=map['type'],
        name=map['name'],
        isDetailing=map['isDetailing'],
        price=map['price'],
         time=map['time'];


}