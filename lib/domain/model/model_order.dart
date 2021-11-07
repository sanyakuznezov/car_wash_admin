


class ModelOrder{

  int id;
  int clientId;
   String  carNumber;
  int carRegion;
  int totalPrice;
  int personalId;
  String personalFullname;
  String adminComment;
  String clientComment;
  int status;
  int workMin;
  int reputation;
  int postId;
  List<dynamic> textArray;
  String startDate;
 String  endDate;
  String color;
  String carType;
  String brandTitle;
  String modelTitle;
  String clientFullname;
  String clientPhone;

  ModelOrder({required this.id, required this.clientId, required this.carNumber,required this.totalPrice, required this.carRegion,
    required this.personalId, required this.personalFullname, required this.adminComment,
    required this.clientComment,required this.status,required this.workMin,required this.reputation,required this.postId,required this.textArray,required this.startDate,
    required this.endDate, required this.color, required this.carType,
    required this.brandTitle, required this.modelTitle, required this.clientFullname, required this.clientPhone});


}