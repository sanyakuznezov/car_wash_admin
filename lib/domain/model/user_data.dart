

 class UserData{

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


   UserData({required this.guid,required this.token,required this.firstname,required this.lastname,required this.patronymic
   ,required this.avatar,required this.phone,required this.phone_verified,required this.email,required this.lang_id});
}