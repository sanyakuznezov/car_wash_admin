


  class ApiUserData{

    String guid;
    String token;

    ApiUserData.fromApi(Map<String,dynamic> map):guid=map['guid'],token=map['token'];


  }