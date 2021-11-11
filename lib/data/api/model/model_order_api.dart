


 class ModelOrderApi{

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

   ModelOrderApi.fromApi({required Map<String,dynamic> map}):
       id=map['id'],
         clientId=map['clientId']==null?0:map['clientId'],
   carNumber=map['carNumber'],
   carRegion=map['carRegion'],
   totalPrice=map['totalPrice'],
   personalId=map['personalId']==null?0:map['personalId'],
   personalFullname=map['personalFullname']==null?'':map['personalFullname'],
   adminComment=map['adminComment']==null?'':map['adminComment'],
   clientComment=map['clientComment']==null?'':map['clientComment'],
   status=map['status'],
   workMin=map['workMin'],
   reputation=map['reputation'],
   postId=map['postId'],
   textArray=map['textArray'],
   startDate=map['startDate'],
   endDate=map['endDate'],
   color=map['color']==null?'':map['color'],
   carType=map['carType'],
   brandTitle=map['brandTitle'],
   modelTitle=map['modelTitle'],
   clientFullname=map['clientFullname'],
   clientPhone=map['clientPhone'];
}