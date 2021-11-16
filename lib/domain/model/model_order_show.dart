



 class ModelOrderShow{

  int id;
  int carwashId;
  int personalId;
  String personalFullname;
  String date;
  int post;
  int startTime;
  int endTime;
  int carType;
  String carNumber;
  int carRegion;
  String color;
  int carBrandid;
 int carBrandcarwash_id;
  String carBrandtitle;
 String carBrandicon;
 String carBrandsynonyms;
 String  carBrandcreated_at;
  int carModelid;
 int carModelcar_brand_id;
  int carModelcarwash_id;
 String carModeltitle;
 String carModelsynonyms;
 String carModelcreated_at;
 String clientFullname;
 String  clientPhone;
 int totalPrice;
 int sale;
 int workTime;
 int status;
 String adminComment;
 String clientComment;
 String created_at;
 List<dynamic> services;
 List<dynamic> complexes;

  ModelOrderShow({
    required this.id,
    required this.carwashId,
    required this.personalId,
    required this.personalFullname,
    required this.date,
    required this.post,
    required this.startTime,
    required this.endTime,
    required this.carType,
    required this.carNumber,
    required this.carRegion,
    required this.color,
    required this.carBrandid,
    required this.carBrandcarwash_id,
    required this.carBrandtitle,
    required this.carBrandicon,
    required this.carBrandsynonyms,
    required this.carBrandcreated_at,
    required this.carModelid,
    required this.carModelcar_brand_id,
    required this.carModelcarwash_id,
    required this.carModeltitle,
    required this.carModelsynonyms,
    required this.carModelcreated_at,
    required this.clientFullname,
    required this.clientPhone,
    required this.totalPrice,
    required this.sale,
    required this.workTime,
    required this.status,
    required this.adminComment,
    required this.clientComment,
    required this.created_at,
    required this.services,
    required this.complexes});
}