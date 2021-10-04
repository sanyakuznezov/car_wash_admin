
import 'package:floor/floor.dart';

@entity
 class UserData{
  @primaryKey
  final int? id;
   String? guid;
   String? token;
   bool? valid;
   String firstname;
   String lastname;
   String patronymic;
   String avatar;
   String phone;
   bool phone_verified;
   String email;
   int lang_id;
   int personals_id;
   int personals_carwash_id;
   String personals_carwash_name;
   String personals_carwash_avatar;
   String personals_carwash_address;
   int personals_carwash_timezone;
   String personals_post;


   UserData(
      { this.id,
        this.valid,
        this.guid,
       this.token,
      required this.firstname,
      required this.lastname,
      required this.patronymic,
      required this.avatar,
      required this.phone,
      required this.phone_verified,
      required this.email,
      required this.lang_id,
      required this.personals_id,
      required this.personals_carwash_id,
        required this.personals_carwash_name,
        required this.personals_carwash_avatar,
        required this.personals_carwash_address,
        required this.personals_carwash_timezone,
        required this.personals_post
      });
}