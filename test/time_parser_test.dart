


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

    test('getTimeTable', (){
       print('${TimeParser.parseHourForTimeLine('23:00')}');
       TimeParser.getTimeTable(GlobalData.times[0] as List<String>, 120, 1320).forEach((element) {
         print('$element');
       });
    });

  });


  
  
  
  
}