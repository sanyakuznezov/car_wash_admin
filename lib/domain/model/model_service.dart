




  class ModelService{

   int id;
    String type;
   String name;
    bool isDetailing;
   int price;
   int time;
   List<ModelItem> listServices;

   ModelService({required this.listServices,required this.id, required this.type, required this.name, required this.isDetailing, required this.price, required this.time});
}


  class ModelItem{

   int id;
   String name;
   ModelItem({required this.id,required this.name});
  }