


 class TimePosition{


   static getTime(double y){
     if(y>30&&y<110){
       return '00:00-01:00';
     }else if(y>110&&y<190){
       return '01:00-02:00';
     }else if(y>190&&y<270){
       return '02:00-03:00';
     } else if(y>270&&y<350){
       return '03:00-04:00';
     }else if(y>350&&y<430){
       return '04:00-05:00';
     }else if(y>430&&y<510){
       return '05:00-06:00';
     }else if(y>510&&y<590){
       return '06:00-07:00';
     }else if(y>590&&y<670){
       return '07:00-08:00';
     }else if(y>670&&y<750){
       return '08:00-09:00';
     }else if(y>750&&y<830){
       return '09:00-10:00';
     }else if(y>830&&y<910){
       return '10:00-11:00';
     }else if(y>910&&y<990){
       return '11:00-12:00';
     }else if(y>990&&y<1070){
       return '12:00-13:00';
     }else if(y>1070&&y<1150){
       return '13:00-14:00';
     }else if(y>1150&&y<1230){
       return '14:00-15:00';
     }else if(y>1230&&y<1310){
       return '15:00-16:00';
     }else if(y>1310&&y<1390){
       return '16:00-17:00';
     }else if(y>1390&&y<1479){
       return '17:00-18:00';
     }else if(y>1479&&y<1550){
       return '18:00-19:00';
     }else if(y>1550&&y<1630){
       return '19:00-20:00';
     }else if(y>1630&&y<1710){
       return '20:00-21:00';
     }else if(y>1710&&y<1790){
       return '21:00-22:00';
     }else if(y>1790&&y<1870){
       return '22:00-23:00';
     }else if(y>1870&&y<1950){
       return '23:00-24:00';
     }else{
       return '';
     }

   }






 }