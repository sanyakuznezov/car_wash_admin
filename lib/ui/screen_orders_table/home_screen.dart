

import 'package:car_wash_admin/internal/dependencies/app_module.dart';
import 'package:car_wash_admin/utils/size_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../../global_data.dart';
import 'multiplication_table.dart';

class MyHomePage extends StatefulWidget {
  bool valid;
  MyHomePage({Key? key,required this.valid}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String dropdownValue = '1 час';
  String dateValue= getDate();
  double? top;



  @override
  void initState() {
    super.initState();
    AppModule.blocTable.streamSink.add(0);

  }


  @override
  void dispose() {
    super.dispose();
    AppModule.blocTable.disponse();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child:
              Container(
                  padding: EdgeInsets.fromLTRB(10,SizeUtil.getSize(6,GlobalData.sizeScreen!), 10, 10),
                  color: Colors.indigo,
                  child:
                  Expanded(
                      child:
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    Icons.menu,
                                    color: Colors.white,
                                  ),
                                ),
                                flex: 1,
                              ),
                              Expanded(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                                      child: Icon(
                                        Icons.info_outline,
                                        color: Colors.white,
                                      ),
                                    )),
                                flex: 1,
                              ),
                              Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          Expanded(child:
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child:
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 18),
                                    decoration: BoxDecoration(
                                      border:Border(
                                        top: BorderSide(width: 2.0, color: Colors.white),
                                        bottom: BorderSide(width: 2.0, color: Colors.white),
                                      ),
                                    ),
                                    height: 20,
                                    child: Icon(
                                      Icons.height,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                  )
                              ),
                              Expanded(
                                  flex: 5,
                                  child:
                                  Container(
                                    alignment: Alignment.center,
                                    height: 35,
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white
                                    ),

                                    child: DropdownButton<String>(
                                      value: dropdownValue,
                                      icon: const Icon(Icons.arrow_drop_down,
                                        color: Colors.black,),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: TextStyle(color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)),
                                      underline: Container(
                                        height: 2,
                                        color: Colors.transparent,
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownValue = newValue!;
                                          AppModule.blocTable.streamSink.add(state(newValue));
                                        });
                                      },
                                      items: <String>['1 час', '30 минут', '15 минут', '5 минут']
                                          .map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),

                                  )),
                              Expanded(
                                  flex: 1,
                                  child:
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                    height: 20,
                                    child: Icon(
                                      Icons.calendar_today_outlined,
                                      color: Colors.white,
                                    ),
                                  )
                              ),
                              Expanded(
                                  flex: 5,
                                  child:
                                  Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.all(10),
                                      height: 35,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.white
                                      ),
                                      child: TextButton(
                                          onPressed: () {
                                            DatePicker.showDatePicker(context,
                                                showTitleActions: true,
                                                minTime: DateTime(2018, 3, 5),
                                                maxTime: DateTime(2025, 6, 7), onChanged: (date) {
                                                  print('change $date');
                                                }, onConfirm: (date) {
                                                  setState(() {
                                                    dateValue=  dateFormat(date.weekday, date.month, date.day);
                                                  });

                                                },
                                                currentTime:
                                                DateTime.now(), locale: LocaleType.ru);
                                          },
                                          child: Text(
                                            dateValue,
                                            style: TextStyle(color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                                            ),
                                          ))
                                  )),
                            ],
                          ))
                        ],
                      ))),
            ),
            Expanded(flex: 4, child: MultiplicationTable()),
          ],
        ));
  }
}

String dateFormat(int dayweek,int int_month,int day_int){
  String day='';
  String month='';
  if(dayweek==1){
    day='Пн';
  }else if(dayweek==2){
    day='Вт';
  }else if(dayweek==3){
    day='Ср';
  }else if(dayweek==4){
    day='Чт';
  }else if(dayweek==5){
    day='Пт';
  }else if(dayweek==6){
    day='Сб';
  }else if(dayweek==7){
    day='Вс';
  }
  if(int_month==1){
    month='Января';
  }else if(int_month==2){
    month='Февраля';
  }else if(int_month==3){
    month='Марта';
  }else if(int_month==4){
    month='Апреля';
  }else if(int_month==5){
    month='Мая';
  }else if(int_month==6){
    month='Июня';
  }else if(int_month==7){
    month='Июля';
  }else if(int_month==8){
    month='Августа';
  }else if(int_month==9){
    month='Сентября';
  }else if(int_month==10){
    month='Октября';
  }else if(int_month==11){
    month='Ноября';
  }else if(int_month==12){
    month='Декабря';
  }
  return '$day, $day_int $month';
}


getDate(){
  final date=DateTime.now();
  return dateFormat(date.weekday, date.month, date.day);
}

int state(String step){
  int i=0;
  if(step=='1 час'){
    i=0;
    GlobalData.stateTime=0;
  }else if(step=='30 минут'){
    i=1;
    GlobalData.stateTime=1;
  }else if(step=='15 минут'){
    i=2;
    GlobalData.stateTime=2;
  }
  else if(step=='5 минут'){
    i=3;
    GlobalData.stateTime=3;
  }

  return i;
}

