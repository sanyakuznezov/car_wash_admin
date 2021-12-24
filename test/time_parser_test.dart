


import 'package:car_wash_admin/global_data.dart';
import 'package:car_wash_admin/utils/time_parser.dart';
import 'package:car_wash_admin/utils/time_position.dart';
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
      expect(TimeParser.parseStringTimeToInt('01:00'),60);
    });

    test('validateCrrentTime', (){
      String d='2021-12-24';
      int year=int.parse(d.split('-')[0]);
      int mount=int.parse(d.split('-')[1]);
      int dey=int.parse(d.split('-')[2]);
      String time=DateTime(year,mount,dey).add(Duration(days:1)).toString().split(' ')[0];
      print('Date $time');

          List<String> t=['00:00 - 05:59','11:31 - 18:59','19:26 - 23:59'];
          List<String> t1=['00:00 - 05:59','11:31 - 18:59','19:26 - 23:59'];
         print('isFree ${TimeParser.validateCurrentTime(intervalsFree: t,currentTimeStart: '18:35',currentTimeEnd: '02:30')}');
    });

    test('parseHourForTimeLineTest', (){
      print('time  ${TimePosition.getTime(100+TimeParser.shiftTime(
          time: 600+60,
          timeStep: 0))}');
    });
  });


  
  
  
  
}