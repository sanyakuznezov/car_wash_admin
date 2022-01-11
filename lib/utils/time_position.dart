


 import 'package:car_wash_admin/global_data.dart';

class TimePosition{

  static getTime(double y){
    if(GlobalData.stateTime==0){
        return getTimeStep_1(y);
      }else if(GlobalData.stateTime==1){
        return getTimeStep_2(y);
      }else if(GlobalData.stateTime==2){
        return getTimeStep_3(y);
      }else if(GlobalData.stateTime==3){
        return getTimeStep_4(y);
      }
  }

 //шаг час
   static getTimeStep_1(double y){
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

   //шаг пол часа
   static getTimeStep_2(double y){
     if(y>30&&y<110){
       return '00:00-00:30';
     }else if(y>110&&y<190){
       return '00:30-01:00';
     }else if(y>190&&y<270){
       return '01:00-01:30';
     } else if(y>270&&y<350){
       return '01:30-02:00';
     }else if(y>350&&y<430){
       return '02:00-02:30';
     }else if(y>430&&y<510){
       return '02:30-03:00';
     }else if(y>510&&y<590){
       return '03:00-03:30';
     }else if(y>590&&y<670){
       return '03:30-04:00';
     }else if(y>670&&y<750){
       return '04:00-04:30';
     }else if(y>750&&y<830){
       return '04:30-05:00';
     }else if(y>830&&y<910){
       return '05:00-05:30';
     }else if(y>910&&y<990){
       return '05:30-06:00';
     }else if(y>990&&y<1070){
       return '06:00-06:30';
     }else if(y>1070&&y<1150){
       return '06:30-07:00';
     }else if(y>1150&&y<1230){
       return '07:00-07:30';
     }else if(y>1230&&y<1310){
       return '07:30-08:00';
     }else if(y>1310&&y<1390){
       return '08:00-08:30';
     }else if(y>1390&&y<1479){
       return '08:30-09:00';
     }else if(y>1479&&y<1550){
       return '09:00-09:30';
     }else if(y>1550&&y<1630){
       return '09:30-10:00';
     }else if(y>1630&&y<1710){
       return '10:00-10:30';
     }else if(y>1710&&y<1790){
       return '10:30-11:00';
     }else if(y>1790&&y<1870){
       return '11:00-11:30';
     }else if(y>1870&&y<1950){
       return '11:30-12:00';
     }else if(y>1950&&y<2030){
       return '12:00-12:30';
     }else if(y>2030&&y<2110){
       return '12:30-13:00';
     }else if(y>2110&&y<2190){
       return '13:00-13:30';
     }else if(y>2190&&y<2270){
       return '13:30-14:00';
     }else if(y>2270&&y<2350){
       return '14:00-14:30';
     }else if(y>2350&&y<2430){
       return '14:30-15:00';
     }else if(y>2430&&y<2510){
       return '15:00-15:30';
     }else if(y>2510&&y<2590){
       return '15:30-16:00';
     }else if(y>2590&&y<2670){
       return '16:00-16:30';
     }else if(y>2670&&y<2750){
       return '16:30-17:00';
     }else if(y>2750&&y<2830){
       return '17:00-17:30';
     }else if(y>2830&&y<2910){
       return '17:30-18:00';
     }else if(y>2910&&y<2990){
       return '18:00-18:30';
     }else if(y>2990&&y<3070){
       return '18:30-19:00';
     }else if(y>3070&&y<3150){
       return '19:00-19:30';
     }else if(y>3150&&y<3230){
       return '19:30-20:00';
     }else if(y>3230&&y<3310){
       return '20:00-20:30';
     }else if(y>3310&&y<3390){
       return '20:30-21:00';
     }else if(y>3390&&y<3470){
       return '21:00-21:30';
     }else if(y>3470&&y<3550){
       return '21:30-22:00';
     }else if(y>3550&&y<3630){
       return '22:00-22:30';
     }else if(y>3630&&y<3710){
       return '22:30-23:00';
     }else if(y>3710&&y<3790){
       return '23:00-23:30';
     }else if(y>3790&&y<3870){
       return '23:30-24:00';
     }else{
       return '';
     }

   }

  //шаг 15 min
  static getTimeStep_3(double y){
    if(y>30&&y<110){
      return '00:00-00:15';
    }else if(y>110&&y<190){
      return '00:15-00:30';
    }else if(y>190&&y<270){
      return '00:30-00:45';
    } else if(y>270&&y<350){
      return '00:45-01:00';
    }else if(y>350&&y<430){
      return '01:00-01:15';
    }else if(y>430&&y<510){
      return '01:15-01:30';
    }else if(y>510&&y<590){
      return '01:30-01:45';
    }else if(y>590&&y<670){
      return '01:45-02:00';
    }else if(y>670&&y<750){
      return '02:00-02:15';
    }else if(y>750&&y<830){
      return '02:15-02:30';
    }else if(y>830&&y<910){
      return '02:30-02:45';
    }else if(y>910&&y<990){
      return '02:45-03:00';
    }else if(y>990&&y<1070){
      return '03:00-03:15';
    }else if(y>1070&&y<1150){
      return '03:15-03:30';
    }else if(y>1150&&y<1230){
      return '03:30-03:45';
    }else if(y>1230&&y<1310){
      return '03:45-04:00';
    }else if(y>1310&&y<1390){
      return '04:00-04:15';
    }else if(y>1390&&y<1479){
      return '04:15-04:30';
    }else if(y>1479&&y<1550){
      return '04:30-04:45';
    }else if(y>1550&&y<1630){
      return '04:45-05:00';
    }else if(y>1630&&y<1710){
      return '05:00-05:15';
    }else if(y>1710&&y<1790){
      return '05:15-05:30';
    }else if(y>1790&&y<1870){
      return '05:30-05:45';
    }else if(y>1870&&y<1950){
      return '05:45-06:00';
    }else if(y>1950&&y<2030){
      return '06:00-06:15';
    }else if(y>2030&&y<2110){
      return '06:15-06:30';
    }else if(y>2110&&y<2190){
      return '06:30-06:45';
    }else if(y>2190&&y<2270){
      return '06:45-07:00';
    }else if(y>2270&&y<2350){
      return '07:00-14:30';
    }else if(y>2350&&y<2430){
      return '07:15-07:30';
    }else if(y>2430&&y<2510){
      return '07:30-07:45';
    }else if(y>2510&&y<2590){
      return '07:45-08:00';
    }else if(y>2590&&y<2670){
      return '08:00-08:15';
    }else if(y>2670&&y<2750){
      return '08:15-08:30';
    }else if(y>2750&&y<2830){
      return '08:30-08:45';
    }else if(y>2830&&y<2910){
      return '08:45-09:00';
    }else if(y>2910&&y<2990){
      return '09:00-09:15';
    }else if(y>2990&&y<3070){
      return '09:15-09:30';
    }else if(y>3070&&y<3150){
      return '09:30-09:45';
    }else if(y>3150&&y<3230){
      return '09:45-10:00';
    }else if(y>3230&&y<3310){
      return '10:00-10:15';
    }else if(y>3310&&y<3390){
      return '10:15-10:30';
    }else if(y>3390&&y<3470){
      return '10:30-10:45';
    }else if(y>3470&&y<3550){
      return '10:45-11:00';
    }else if(y>3550&&y<3630){
      return '11:00-22:30';
    }else if(y>3630&&y<3710){
      return '11:15-11:30';
    }else if(y>3710&&y<3790){
      return '11:30-11:45';
    }else if(y>3790&&y<3870){
      return '11:45-12:00';
    }else if(y>3870&&y<3950){
      return '12:00-12:15';
    }else if(y>3950&&y<4030){
      return '12:15-12:30';
    }else if(y>4030&&y<4110){
      return '12:30-12:45';
    }else if(y>4110&&y<4190){
      return '12:45-13:00';
    }else if(y>4190&&y<4270){
      return '13:00-13:15';
    }else if(y>4270&&y<4350){
      return '13:15-13:30';
    }else if(y>4350&&y<4430){
      return '13:30-13:45';
    }else if(y>4430&&y<4510){
      return '13:45-14:00';
    }else if(y>4510&&y<4590){
      return '14:00-14:15';
    }else if(y>4590&&y<4670){
      return '14:15-14:30';
    }else if(y>4670&&y<4750){
      return '14:30-14:45';
    }else if(y>4750&&y<4830){
      return '14:45-15:00';
    }else if(y>4830&&y<4910){
      return '15:00-15:15';
    }else if(y>4910&&y<4990){
      return '15:15-15:30';
    }else if(y>4990&&y<5070){
      return '15:30-15:45';
    }else if(y>5070&&y<5150){
      return '15:45-16:00';
    }else if(y>5150&&y<5230){
      return '16:00-16:15';
    }else if(y>5230&&y<5310){
      return '16:15-16:30';
    }else if(y>5310&&y<5390){
      return '16:30-16:45';
    }else if(y>5390&&y<5470){
      return '16:45-17:00';
    }else if(y>5470&&y<5550){
      return '17:00-17:15';
    }else if(y>5550&&y<5630){
      return '17:15-17:30';
    }else if(y>5630&&y<5710){
      return '17:30-17:45';
    }else if(y>5710&&y<5790){
      return '17:45-18:00';
    }else if(y>5790&&y<5870){
      return '18:00-18:15';
    }else if(y>5870&&y<5950){
      return '18:15-18:30';
    }else if(y>5950&&y<6030){
      return '18:30-18:45';
    }else if(y>6030&&y<6110){
      return '18:45-19:00';
    }else if(y>6110&&y<6190){
      return '19:00-19:15';
    }else if(y>6190&&y<6270){
      return '19:15-19:30';
    }else if(y>6270&&y<6350){
      return '19:30-19:45';
    }else if(y>6350&&y<6430){
      return '19:45-20:00';
    }else if(y>6430&&y<6510){
      return '20:00-20:15';
    }else if(y>6510&&y<6590){
      return '20:15-20:30';
    }else if(y>6590&&y<6670){
      return '20:30-20:45';
    }else if(y>6670&&y<6750){
      return '20:45-21:00';
    }else if(y>6750&&y<6830){
      return '21:00-21:15';
    }else if(y>6830&&y<6910){
      return '21:15-21:30';
    }else if(y>6910&&y<6990){
      return '21:30-21:45';
    }else if(y>6990&&y<7070){
      return '21:45-22:00';
    }else if(y>7070&&y<7150){
      return '22:00-22:15';
    }else if(y>7150&&y<7230){
      return '22:15-22:30';
    }else if(y>7230&&y<7310){
      return '22:30-22:45';
    }else if(y>7310&&y<7390){
      return '22:45-23:00';
    }else if(y>7390&&y<7470){
      return '23:00-23:15';
    }else if(y>7470&&y<7550){
      return '23:15-23:30';
    }else if(y>7550&&y<7630){
      return '23:30-23:45';
    }else if(y>7630&&y<7710){
      return '23:45-24:00';
    }else{
      return '';
    }


  }


//шаг 5 min
  static getTimeStep_4(double y){
    if(y>30&&y<110){
      return '00:00-00:05';
    }else if(y>110&&y<190){
      return '00:05-00:10';
    }else if(y>190&&y<270){
      return '00:10-00:15';
    } else if(y>270&&y<350){
      return '00:15-00:20';
    }else if(y>350&&y<430){
      return '00:20-00:25';
    }else if(y>430&&y<510){
      return '00:25-00:30';
    }else if(y>510&&y<590){
      return '00:30-00:35';
    }else if(y>590&&y<670){
      return '00:35-00:40';
    }else if(y>670&&y<750){
      return '00:40-00:45';
    }else if(y>750&&y<830){
      return '00:45-00:50';
    }else if(y>830&&y<910){
      return '00:50-00:55';
    }else if(y>910&&y<990){
      return '00:55-01:00';
    }else if(y>990&&y<1070){
      return '01:00-01:05';
    }else if(y>1070&&y<1150){
      return '01:05-01:10';
    }else if(y>1150&&y<1230){
      return '01:10-01:15';
    }else if(y>1230&&y<1310){
      return '01:15-01:20';
    }else if(y>1310&&y<1390){
      return '01:20-01:25';
    }else if(y>1390&&y<1470){
      return '01:25-01:30';
    }else if(y>1470&&y<1550){
      return '01:30-01:35';
    }else if(y>1550&&y<1630){
      return '01:35-01:40';
    }else if(y>1630&&y<1710){
      return '01:40-01:45';
    }else if(y>1710&&y<1790){
      return '01:45-01:50';
    }else if(y>1790&&y<1870){
      return '01:50-01:55';
    }else if(y>1870&&y<1950){
      return '01:55-02:00';
    }else if(y>1950&&y<2030){
      return '02:00-02:05';
    }else if(y>2030&&y<2110){
      return '02:05-02:10';
    }else if(y>2110&&y<2190){
      return '02:10-02:15';
    }else if(y>2190&&y<2270){
      return '02:15-02:20';
    }else if(y>2270&&y<2350){
      return '02:20-02:25';
    }else if(y>2350&&y<2430){
      return '02:25-02:30';
    }else if(y>2430&&y<2510){
      return '02:30-02:35';
    }else if(y>2510&&y<2590){
      return '02:35-02:40';
    }else if(y>2590&&y<2670){
      return '02:40-02:45';
    }else if(y>2670&&y<2750){
      return '02:45-02:50';
    }else if(y>2750&&y<2830){
      return '02:50-02:55';
    }else if(y>2830&&y<2910){
      return '02:55-03:00';
    }else if(y>2910&&y<2990){
      return '03:00-03:05';
    }else if(y>2990&&y<3070){
      return '03:05-03:10';
    }else if(y>3070&&y<3150){
      return '03:10-03:15';
    }else if(y>3150&&y<3230){
      return '03:15-03:20';
    }else if(y>3230&&y<3310){
      return '03:20-03:25';
    }else if(y>3310&&y<3390){
      return '03:25-03:30';
    }else if(y>3390&&y<3470){
      return '03:30-03:35';
    }else if(y>3470&&y<3550){
      return '03:35-03:40';
    }else if(y>3550&&y<3630){
      return '03:40-03:45';
    }else if(y>3630&&y<3710){
      return '03:45-03:50';
    }else if(y>3710&&y<3790){
      return '03:50-03:55';
    }else if(y>3790&&y<3870){
      return '03:55-04:00';
    }else if(y>3870&&y<3950){
      return '04:00-04:05';
    }else if(y>3950&&y<4030){
      return '04:05-04:10';
    }else if(y>4030&&y<4110){
      return '04:10-04:15';
    }else if(y>4110&&y<4190){
      return '04:15-04:20';
    }else if(y>4190&&y<4270){
      return '04:20-04:25';
    }else if(y>4270&&y<4350){
      return '04:25-04:30';
    }else if(y>4350&&y<4430){
      return '04:30-04:35';
    }else if(y>4430&&y<4510){
      return '04:35-04:40';
    }else if(y>4510&&y<4590){
      return '04:40-04:45';
    }else if(y>4590&&y<4670){
      return '04:45-04:50';
    }else if(y>4670&&y<4750){
      return '04:50-04:55';
    }else if(y>4750&&y<4830){
      return '04:55-05:00';
    }else if(y>4830&&y<4910){
      return '05:00-05:05';
    }else if(y>4910&&y<4990){
      return '05:05-05:10';
    }else if(y>4990&&y<5070){
      return '05:10-05:15';
    }else if(y>5070&&y<5150){
      return '05:15-05:20';
    }else if(y>5150&&y<5230){
      return '05:20-05:25';
    }else if(y>5230&&y<5310){
      return '05:25-05:30';
    }else if(y>5310&&y<5390){
      return '05:30-05:35';
    }else if(y>5390&&y<5470){
      return '05:35-05:40';
    }else if(y>5470&&y<5550){
      return '05:40-05:45';
    }else if(y>5550&&y<5630){
      return '05:45-05:50';
    }else if(y>5630&&y<5710){
      return '05:50-05:55';
    }else if(y>5710&&y<5790){
      return '05:55-06:00';
    }else if(y>5790&&y<5870){
      return '06:00-06:05';
    }else if(y>5870&&y<5950){
      return '06:05-06:10';
    }else if(y>5950&&y<6030){
      return '06:10-06:15';
    }else if(y>6030&&y<6110){
      return '06:15-06:20';
    }else if(y>6110&&y<6190){
      return '06:20-06:25';
    }else if(y>6190&&y<6270){
      return '06:25-06:30';
    }else if(y>6270&&y<6350){
      return '06:30-06:35';
    }else if(y>6350&&y<6430){
      return '06:35-06:40';
    }else if(y>6430&&y<6510){
      return '06:40-06:45';
    }else if(y>6510&&y<6590){
      return '06:45-06:50';
    }else if(y>6590&&y<6670){
      return '06:50-06:55';
    }else if(y>6670&&y<6750){
      return '06:55-07:00';
    }else if(y>6750&&y<6830){
      return '07:00-07:05';
    }else if(y>6830&&y<6910){
      return '07:05-07:10';
    }else if(y>6910&&y<6990){
      return '07:10-07:15';
    }else if(y>6990&&y<7070){
      return '07:15-07:20';
    }else if(y>7070&&y<7150){
      return '07:20-07:25';
    }else if(y>7150&&y<7230){
      return '07:25-07:30';
    }else if(y>7230&&y<7310){
      return '07:30-07:35';
    }else if(y>7310&&y<7390){
      return '07:35-07:40';
    }else if(y>7390&&y<7470){
      return '07:40-07:45';
    }else if(y>7470&&y<7550){
      return '07:45-07:50';
    }else if(y>7550&&y<7630){
      return '07:50-07:55';
    }else if(y>7630&&y<7710){
      return '07:55-08:00';
    }else if(y>7710&&y<7790){
      return '08:00-08:05';
    }else if(y>7790&&y<7870){
      return '08:05-08:10';
    }else if(y>7870&&y<7950){
      return '08:10-08:15';
    }else if(y>7950&&y<8030){
      return '08:15-08:20';
    }else if(y>8030&&y<8110){
      return '08:20-08:25';
    }else if(y>8110&&y<8190){
      return '08:25-08:30';
    }else if(y>8190&&y<8270){
      return '08:30-08:35';
    }else if(y>8270&&y<8350){
      return '08:35-08:40';
    }else if(y>8350&&y<8430){
      return '08:40-08:45';
    }else if(y>8430&&y<8510){
      return '08:45-08:50';
    }else if(y>8510&&y<8590){
      return '08:50-08:55';
    }else if(y>8590&&y<8670){
      return '08:55-09:00';
    }else if(y>8670&&y<8750){
      return '09:00-09:05';
    }else if(y>8750&&y<8830){
      return '09:05-09:10';
    }else if(y>8830&&y<8910){
      return '09:10-09:15';
    }else if(y>8910&&y<8990){
      return '09:15-09:20';
    }else if(y>8990&&y<9070){
      return '09:20-09:25';
    }else if(y>9070&&y<9150){
      return '09:25-09:30';
    }else if(y>9150&&y<9230){
      return '09:30-09:35';
    }else if(y>9230&&y<9310){
      return '09:35-09:40';
    }else if(y>9310&&y<9390){
      return '09:40-09:45';
    }else if(y>9390&&y<9470){
      return '09:45-09:50';
    }else if(y>9470&&y<9550){
      return '09:50-09:55';
    }else if(y>9550&&y<9630){
      return '09:55-10:00';
    }else if(y>9630&&y<9710){
      return '10:00-10:05';
    }else if(y>9710&&y<9790){
      return '10:05-10:10';
    }else if(y>9790&&y<9870){
      return '10:10-10:15';
    }else if(y>9870&&y<9950){
      return '10:15-10:20';
    }else if(y>9950&&y<10030){
      return '10:20-10:25';
    }else if(y>10030&&y<10110){
      return '10:25-10:30';
    }else if(y>10110&&y<10190){
      return '10:30-10:35';
    }else if(y>10190&&y<10270){
      return '10:35-10:40';
    }else if(y>10270&&y<10350){
      return '10:40-10:45';
    }else if(y>10350&&y<10430){
      return '10:45-10:50';
    }else if(y>10430&&y<10510){
      return '10:50-10:55';
    }else if(y>10510&&y<10590){
      return '10:55-11:00';
    }else if(y>10590&&y<10670){
      return '11:00-11:05';
    }else if(y>10670&&y<10750){
      return '11:05-11:10';
    }else if(y>10750&&y<10830){
      return '11:10-11:15';
    }else if(y>10830&&y<10910){
      return '11:15-11:20';
    }else if(y>10910&&y<10990){
      return '11:20-11:25';
    }else if(y>10990&&y<11070){
      return '11:25-11:30';
    }else if(y>11070&&y<11150){
      return '11:30-11:35';
    }else if(y>11150&&y<11230){
      return '11:35-11:40';
    }else if(y>11230&&y<11310){
      return '11:40-11:45';
    }else if(y>11310&&y<11390){
      return '11:45-11:50';
    }else if(y>11390&&y<11470){
      return '11:50-11:55';
    }else if(y>11470&&y<11550){
      return '11:55-12:00';
    }else if(y>11550&&y<11630){
      return '12:00-12:05';
    }else if(y>11630&&y<11710){
      return '12:05-12:10';
    }else if(y>11710&&y<11790){
      return '12:10-12:15';
    }else if(y>11790&&y<11870){
      return '12:15-12:20';
    }else if(y>11870&&y<11950){
      return '12:20-12:25';
    }else if(y>11950&&y<12030){
      return '12:25-12:30';
    }else if(y>12030&&y<12110){
      return '12:30-12:35';
    }else if(y>12110&&y<12190){
      return '12:35-12:40';
    }else if(y>12190&&y<12270){
      return '12:40-12:45';
    }else if(y>12270&&y<12350){
      return '12:45-12:50';
    }else if(y>12350&&y<12430){
      return '12:50-12:55';
    }else if(y>12430&&y<12510){
      return '12:55-13:00';
    }else if(y>12510&&y<12590){
      return '13:00-13:05';
    }else if(y>12590&&y<12670){
      return '13:05-13:10';
    }else if(y>12670&&y<12750){
      return '13:10-13:15';
    }else if(y>12750&&y<12830){
      return '13:15-13:20';
    }else if(y>12830&&y<12910){
      return '13:20-13:25';
    }else if(y>12910&&y<12990){
      return '13:25-13:30';
    }else if(y>12990&&y<13070){
      return '13:30-13:35';
    }else if(y>13070&&y<13150){
      return '13:35-13:40';
    }else if(y>13150&&y<13230){
      return '13:40-13:45';
    }else if(y>13230&&y<13310){
      return '13:45-13:50';
    }else if(y>13310&&y<13390){
      return '13:50-13:55';
    }else if(y>13390&&y<13470){
      return '13:55-14:00';
    }else if(y>13470&&y<13550){
      return '14:00-14:05';
    }else if(y>13550&&y<13630){
      return '14:05-14:10';
    }else if(y>13630&&y<13710){
      return '14:10-14:15';
    }else if(y>13710&&y<13790){
      return '14:15-14:20';
    }else if(y>13790&&y<13870){
      return '14:20-14:25';
    }else if(y>13870&&y<13950){
      return '14:25-14:30';
    }else if(y>13950&&y<14030){
      return '14:30-14:35';
    }else if(y>14030&&y<14110){
      return '14:35-14:40';
    }else if(y>14110&&y<14190){
      return '14:40-14:45';
    }else if(y>14190&&y<14270){
      return '14:45-14:50';
    }else if(y>14270&&y<14350){
      return '14:50-14:55';
    }else if(y>14350&&y<14430){
      return '14:55-15:00';
    }else if(y>14430&&y<14510){
      return '15:00-15:05';
    }else if(y>14510&&y<14590){
      return '15:05-15:10';
    }else if(y>14590&&y<14670){
      return '15:10-15:15';
    }else if(y>14670&&y<14750){
      return '15:15-15:20';
    }else if(y>14750&&y<14830){
      return '15:20-15:25';
    }else if(y>14830&&y<14910){
      return '15:25-15:30';
    }else if(y>14910&&y<14990){
      return '15:30-15:35';
    }else if(y>14990&&y<15070){
      return '15:35-15:40';
    }else if(y>15070&&y<15150){
      return '15:40-15:45';
    }else if(y>15150&&y<15230){
      return '15:45-15:50';
    }else if(y>15230&&y<15310){
      return '15:50-15:55';
    }else if(y>15310&&y<15390){
      return '15:55-16:00';
    }else if(y>15390&&y<15470){
      return '16:00-16:05';
    }else if(y>15470&&y<15550){
      return '16:05-16:10';
    }else if(y>15550&&y<15630){
      return '16:10-16:15';
    }else if(y>15630&&y<15710){
    return '16:15-16:20';
    }else if(y>15710&&y<15790){
    return '16:20-16:25';
    }else if(y>15790&&y<15870){
    return '16:25-16:30';
    }else if(y>15870&&y<15950){
    return '16:30-16:35';
    }else if(y>15950&&y<16030){
    return '16:35-16:40';
    }else if(y>16030&&y<16110){
    return '16:40-16:45';
    }else if(y>16110&&y<16190){
    return '16:45-16:50';
    }else if(y>16190&&y<16270){
    return '16:50-16:55';
    }else if(y>16270&&y<16350){
    return '16:55-17:00';

    //TODO time edit
    }else if(y>16350&&y<16430){
    return '17:00-17:05';
    }else if(y>16430&&y<16510){
    return '17:05-17:10';
    }else if(y>16510&&y<16590){
    return '17:10-17:15';
    }else if(y>16590&&y<16670){
    return '17:15-17:20';
    }else if(y>16670&&y<16750){
    return '17:20-17:25';
    }else if(y>16750&&y<16830){
    return '17:25-17:30';
    }else if(y>16830&&y<16910){
    return '17:30-17:35';
    }else if(y>16910&&y<16990){
    return '17:35-17:40';
    }else if(y>16990&&y<17070){
    return '17:40-17:45';
    }else if(y>17070&&y<17150){
    return '17:45-17:50';
    }else if(y>17150&&y<17230){
    return '17:50-17:55';
    }else if(y>17230&&y<17310){
    return '17:55-18:00';
    }else if(y>17310&&y<17390){
    return '18:00-18:05';
    }else if(y>17390&&y<17470){
    return '18:05-18:10';
    }else if(y>17470&&y<17550){
    return '18:10-18:15';
    }else if(y>17550&&y<17630){
    return '18:15-18:20';
    }else if(y>17630&&y<17710){
    return '18:20-18:25';
    }else if(y>17710&&y<17790){
    return '18:25-18:30';
    }else if(y>17790&&y<17870){
    return '18:30-18:35';
    }else if(y>17870&&y<17950){
    return '18:35-18:40';
    }else if(y>17950&&y<18030){
    return '18:40-18:45';
    }else if(y>18030&&y<18110){
    return '18:45-18:50';
    }else if(y>18110&&y<18190){
    return '18:50-18:55';
    }else if(y>18190&&y<18270){
    return '18:55-19:00';
    }else if(y>18270&&y<18350){
    return '19:00-19:05';
    }else if(y>18350&&y<18430){
    return '19:05-19:10';
    }else if(y>18430&&y<18510){
    return '19:10-19:15';
    }else if(y>18510&&y<18590){
    return '19:15-19:20';
    }else if(y>18590&&y<18670){
    return '19:20-19:25';
    }else if(y>18670&&y<18750){
    return '19:25-19:30';
    }else if(y>18750&&y<18830){
    return '19:30-19:35';
    }else if(y>18830&&y<18910){
    return '19:35-19:40';
    }else if(y>18910&&y<18990){
    return '19:40-19:45';
    }else if(y>18990&&y<19070){
    return '19:45-19:50';
    }else if(y>19070&&y<19150){
    return '19:50-19:55';
    }else if(y>19150&&y<19230){
    return '19:55-20:00';
    }else if(y>19230&&y<19310){
    return '20:00-20:05';
    }else if(y>19310&&y<19390){
    return '20:05-20:10';
    }else if(y>19390&&y<19470){
    return '20:10-20:15';
    }else if(y>19470&&y<19550){
    return '20:15-20:20';
    }else if(y>19550&&y<19630){
    return '20:20-20:25';
    }else if(y>19630&&y<19710){
    return '20:25-20:30';
    }else if(y>19710&&y<19790){
    return '20:30-20:35';
    }else if(y>19790&&y<19870){
    return '20:35-20:40';
    }else if(y>19870&&y<19950){
    return '20:40-20:45';
    }else if(y>19950&&y<20030){
    return '20:45-20:50';
    }else if(y>20030&&y<20110){
    return '20:50-20:55';
    }else if(y>20110&&y<20190){
    return '20:55-21:00';
    }else if(y>20190&&y<20270){
    return '21:00-21:05';
    }else if(y>20270&&y<20350){
    return '21:05-21:10';
    }else if(y>20350&&y<20430){
    return '21:10-21:15';
    }else if(y>20430&&y<20510){
    return '21:15-21:20';
    }else if(y>20510&&y<20590){
    return '21:20-21:25';
    }else if(y>20590&&y<20670){
    return '21:25-21:30';
    }else if(y>20670&&y<20750){
    return '21:30-21:35';
    }else if(y>20750&&y<20830){
    return '21:35-21:40';
    }else if(y>20830&&y<20910){
    return '21:40-21:45';
    }else if(y>20910&&y<20990){
    return '21:45-21:50';
    }else if(y>20990&&y<21070){
    return '21:50-21:55';
    }else if(y>21070&&y<21150){
    return '21:55-22:00';
    }else if(y>21150&&y<21230){
    return '22:00-22:05';
    }else if(y>21230&&y<21310){
    return '22:05-22:10';
    }else if(y>21310&&y<21390){
    return '22:10-22:15';
    }else if(y>21390&&y<21470){
    return '22:15-22:20';
    }else if(y>21470&&y<21550){
    return '22:20-22:25';
    }else if(y>21550&&y<21630){
    return '22:25-22:30';
    }else if(y>21630&&y<21710){
    return '22:30-22:35';
    }else if(y>21710&&y<21790){
    return '22:35-22:40';
    }else if(y>21790&&y<21870){
    return '22:40-22:45';
    }else if(y>21870&&y<21950){
    return '22:45-22:50';
    }else if(y>21950&&y<22030){
    return '22:50-22:55';
    }else if(y>22030&&y<22110){
    return '22:55-23:00';
    }else if(y>22110&&y<22190){
    return '23:00-23:05';
    }else if(y>22190&&y<22270){
    return '23:05-23:10';
    }else if(y>22270&&y<22350){
    return '23:10-23:15';
    }else if(y>22350&&y<22430){
    return '23:15-23:20';
    }else if(y>22430&&y<22510){
    return '23:20-23:25';
    }else if(y>22510&&y<22590){
    return '23:25-23:30';
    }else if(y>22590&&y<22670){
    return '23:30-23:35';
    }else if(y>22670&&y<22750){
    return '23:35-23:40';
    }else if(y>22750&&y<22830){
    return '23:40-23:45';
    }else if(y>22830&&y<22910){
    return '23:45-23:50';
    }else if(y>22910&&y<22990){
    return '23:50-23:55';
    }else if(y>22990&&y<23070){
    return '23:55-24:00';
    }else
      return '';
    }

  }

