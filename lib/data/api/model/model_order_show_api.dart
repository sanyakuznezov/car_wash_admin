


 class ModelOrderShowApi{


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

   ModelOrderShowApi.fromApi({required Map<String,dynamic> map}):
          id=map['id']??0,
    carwashId=map['carwashId']??0,
    personalId=map['personalId']==null?0:map['personalId'],
    personalFullname=map['personalFullname']==null?'':map['personalFullname'],
    date=map['date']??'',
    post=map['post']??0,
    startTime=map['startTime']??0,
    endTime=map['endTime']??0,
    carType=map['carType']??0,
    carNumber=map['carNumber']??'',
    carRegion=map['carRegion']??0,
    color=map['color']??'',
    carBrandid=map['carBrand']['id']??0,
    carBrandcarwash_id=map['carBrand']['carwash_id']==null?0:map['carBrand']['carwash_id'],
    carBrandtitle=map['carBrand']['title']??'',
    carBrandicon=map['carBrand']['icon']==null?'':map['carBrand']['icon'],
    carBrandsynonyms=map['carBrand']['synonyms']==null?'':map['carBrand']['synonyms'],
     carBrandcreated_at=map['carBrand']['created_at']==null?'':map['carBrand']['created_at'],
    carModelid=map['carModel']['id']??0,
    carModelcar_brand_id=map['carModel']['car_brand_id']??0,
    carModelcarwash_id=map['carModel']['carwash_id']==null?0:map['carModel']['carwash_id'],
    carModeltitle=map['carModel']['title']??'',
    carModelsynonyms=map['carModel']['synonyms']==null?'':map['carModel']['synonyms'],
    carModelcreated_at=map['carModel']['created_at']??'',
    clientFullname=map['clientFullname']??'',
     clientPhone=map['clientPhone']??'',
    totalPrice=map['totalPrice']??0,
    sale=map['sale']??0,
    workTime=map['workTime']??0,
    status=map['status']??0,
    adminComment=map['adminComment']==''||map['adminComment']==null?'....':map['adminComment'],
    clientComment=map['clientComment']==''||map['clientComment']==null?'....':map['clientComment'],
    created_at=map['created_at']??'',
    services=map['services']??[],
    complexes=map['complexes']??[];
}