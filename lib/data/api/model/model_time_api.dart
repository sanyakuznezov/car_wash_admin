



 class ModelTimeApi{

   List<dynamic> hour;
   List<dynamic> minutes;

  ModelTimeApi.fromApi({required Map<String,dynamic> map}):
       hour=map.keys.toList(),
       minutes=map.values.toList();

 }