


 class ModelBrandCarApi{

  int id;
  String title;
  ModelBrandCarApi.fromApi(Map<String,dynamic> map):
       id=map['id'],
       title=map['title'];
}