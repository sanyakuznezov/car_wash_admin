


  class ApiUserData{

    String guid;
    String token;
    String firstname;
    String lastname;
    String patronymic;
    String avatar;
    String phone;
    bool phone_verified;
    String email;
    int lang_id;

    ApiUserData.fromApi(Map<String,dynamic> map):
          guid=map['guid'],
          token=map['auth_token'],
          firstname=map['firstname'],
          lastname=map['lastname'],
          patronymic=map['patronymic'],
          avatar=map['avatar'],
          phone=map['phone'],
          phone_verified=map['phone_verified'],
          email=map['email'],
          lang_id=map['lang_id'];


  }