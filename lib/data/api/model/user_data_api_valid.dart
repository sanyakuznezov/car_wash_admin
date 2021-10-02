


  class ApiUserDataValid{
    bool valid;
    String firstname;
    String lastname;
    String patronymic;
    String avatar;
    String phone;
    bool phone_verified;
    String email;
    int lang_id;
    List<dynamic> personals=[];

    ApiUserDataValid.fromApi(Map<String,dynamic> map):
           valid=map['valid'],
          firstname=map['profile']['firstname'],
          lastname=map['profile']['lastname'],
          patronymic=map['profile']['patronymic'],
          avatar=map['profile']['avatar'],
          phone=map['profile']['phone'],
          phone_verified=map['profile']['phone_verified'],
          email=map['profile']['email'],
          lang_id=map['profile']['lang_id'],
          personals=map['personals'];



  }