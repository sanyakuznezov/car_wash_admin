


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
   List services;
   List complexes;

   ModelOrderShowApi.fromApi({required Map<String,dynamic> map}):
          id=from('int',map['id'])??0,
    carwashId=from('int', map['carwashId'])??0,
    personalId=from('int',map['personalId'])==null?0:from('int',map['personalId']),
    personalFullname=from('String', map['personalFullname'])==null||from('String', map['personalFullname'])==''?'....':from('String', map['personalFullname']),
    date=from('String', map['date'])??'',
    post=from('int', map['post'])??0,
    startTime=from('int', map['startTime'])??0,
    endTime=from('int', map['endTime'])??0,
    carType=from('int', map['carType'])??0,
    carNumber=from('String', map['carNumber'])??'',
    carRegion=from('int', map['carRegion'])??0,
    color=from('String', map['color'])??'',
   //Error type 'String' is not a subtype of type 'int' of 'index'
    carBrandid=(map['carBrand']['id']??0),
    carBrandcarwash_id=from('int', map['carBrand']['carwash_id'])==null?0:from('int', map['carBrand']['carwash_id']),
    carBrandtitle=from('String', map['carBrand']['title'])??'',
    carBrandicon=from('String', map['carBrand']['icon'])==null?'':from('String', map['carBrand']['icon']),
   carBrandsynonyms=from('String', map['carBrand']['synonyms'])==null?'':from('String', map['carBrand']['synonyms']),
     carBrandcreated_at=from('String', map['carBrand']['created_at'])==null?'':from('String', map['carBrand']['created_at']),
   carModelid=from('int', map['carModel']['id'])??0,
   carModelcar_brand_id=from('int', map['carModel']['car_brand_id'])??0,
    carModelcarwash_id=from('int', map['carModel']['carwash_id'])==null?0:from('int', map['carModel']['carwash_id']),
    carModeltitle=from('String', map['carModel']['title'])??'',
    carModelsynonyms=from('String', map['carModel']['synonyms'])==null?'':from('String', map['carModel']['synonyms']),
   carModelcreated_at=from('String', map['carModel']['created_at'])??'',
   //Error type 'String' is not a subtype of type 'int' of 'index'
         clientFullname=from('String', map['clientFullname'])??'',
     clientPhone=from('String', map['clientPhone'])==null||from('String', map['clientPhone'])==''?'....':from('String', map['clientPhone']),
    totalPrice=from('int', map['totalPrice'])??0,
    sale=from('int', map['sale'])??0,
    workTime=from('int', map['workTime'])??0,
         status=from('int', map['status'])??0,
    adminComment=from('String', map['adminComment'])==''||from('String', map['adminComment'])==null?'....':from('String', map['adminComment']),
    clientComment=from('String', map['clientComment'])==''||from('String', map['clientComment'])==null?'....':from('String', map['clientComment']),
    created_at=from('String', map['created_at'])??'',
    services=from('List', map['services'])??[],
    complexes=from('List', map['complexes'])??[];
}


 from(String type,dynamic value){
    if(value is int){
      print('$type - int');
    }
    if(value is String){
      print('$type - String');
    }

    if(value is List){
      print('$type - List');
    }

    return value;
 }