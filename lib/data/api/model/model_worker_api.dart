



 class ModelWorkerApi{

   int id;
   String firstname;
   String lastname;
   String patronymic;
   String avatar;
   String phone;
   String email;
   String post;

   ModelWorkerApi.fromApi({required Map<String,dynamic> map}):
       id=map['id'],
        firstname=map['firstname'],
   lastname=map['lastname'],
   patronymic=map['patronymic'],
   avatar=map['avatar'],
   phone=map['phone'],
   email=map['email'],
   post=map['post'];
}