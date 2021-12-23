


import 'package:car_wash_admin/global_data.dart';
import 'package:car_wash_admin/utils/time_parser.dart';
import 'package:flutter_test/flutter_test.dart';




void main(){
  
  group('тест парсинга времени', (){

    test('method parseIntToStringTime', (){
      expect(TimeParser.parseIntToStringTime(120),'02:00');
    });

    test('method isTimeValidate', (){
      expect(TimeParser.isTimeValidate('21:00-22:00'),true);
    });

    test('parseHourForTimeLine', (){
      expect(TimeParser.parseHourForTimeLine('01:00'),60);
    });

    test('validateCrrentTime', (){
          List<String> t=['00:00 - 05:59','11:31 - 18:59','19:26 - 23:59'];
         print('isFree ${TimeParser.validateCurrentTime(intervalsFree: t,currentTimeStart: '14:35',currentTimeEnd: '19:30')}');
    });

  });


  
  
  
  
}