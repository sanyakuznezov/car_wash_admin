import 'package:car_wash_admin/app_colors.dart';
import 'package:car_wash_admin/data/mapper/mapper_data_order_for_table.dart';
import 'package:car_wash_admin/domain/model/model_data_table.dart';
import 'package:car_wash_admin/domain/model/model_order.dart';
import 'package:car_wash_admin/domain/state/bloc_page_route.dart';
import 'package:car_wash_admin/domain/state/table_state.dart';
import 'package:car_wash_admin/internal/dependencies/app_module.dart';
import 'package:car_wash_admin/internal/dependencies/repository_module.dart';
import 'package:car_wash_admin/ui/screen_profile/page_profile.dart';
import 'package:car_wash_admin/utils/size_util.dart';
import 'package:car_wash_admin/utils/time_parser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import '../../../global_data.dart';
import 'table_head.dart';
import 'table_body.dart';

class MultiplicationTable extends StatefulWidget {
  @override
  _MultiplicationTableState createState() => _MultiplicationTableState();
}

class _MultiplicationTableState extends State<MultiplicationTable>  with SingleTickerProviderStateMixin{
  late LinkedScrollControllerGroup _controllers;
  late ScrollController _headController;
  late ScrollController _bodyController;
  late ScrollController _bodyControllertop;
  late String dateValue;
  late ValueNotifier<String> _notifierDropdownButton;
  late AnimationController _controller;
  TableState? _tableState;
  String _timeValue='1 час';
  int _initValueTime=0;
  List<String> _listTime=[
  '1 час',
  '30 минут',
  '15 минут',
  '5 минут'
  ];

  @override
  void initState() {
    super.initState();
    _tableState=TableState();
    _tableState!.settingsRequest(context: context,date:GlobalData.date!);
    _controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    _notifierDropdownButton=ValueNotifier('1 час');
    _controllers = LinkedScrollControllerGroup();
    _headController = _controllers.addAndGet();
    _bodyController = _controllers.addAndGet();
    _bodyControllertop=_controllers.addAndGet();
    dateValue= getDate();
  }

  @override
  void dispose() {
    super.dispose();
    _tableState!.dispose();
    _headController.dispose();
    _bodyController.dispose();
    _controller.dispose();
    _bodyControllertop.dispose();

  }

  getDate(){
    final date=DateTime.now();
    return dateFormat(date.weekday, date.month, date.day);
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


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Observer(builder: (_){
                if (_tableState!.isLoading) {
                  return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      color: Colors.indigo,
                    ),
                  );
                }
                if (_tableState!.isError) {
                  return Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error,color: Colors.redAccent,size: SizeUtil.getSize(6.0,GlobalData.sizeScreen!),),
                          Text('${_tableState!.msgError}',
                            style:
                          TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent
                          ),),
                        ],
                      )
                  );
                }

                if(!_tableState!.modelDataTable!.isWorkDay){
                  return Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                        Icons.weekend_outlined,color: AppColors.textColorHint,size: SizeUtil.getSize(6.0,GlobalData.sizeScreen!),),
                          Text('Выходной день',style:
                          TextStyle(
                              fontSize: SizeUtil.getSize(4.0,GlobalData.sizeScreen!),
                              fontWeight: FontWeight.bold,
                              color: AppColors.textColorHint
                          ),),
                        ],
                      )
                  );
                }
                return FutureBuilder<List<ModelOrder>?>(
                    future: RepositoryModule.userRepository().getListOrder(context: context, date:GlobalData.date!),
                    builder: (context,orders){
                      if (orders.connectionState.index!=3) {
                        return Container(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            color: Colors.indigo,
                          ),
                        );
                      }
                      if (orders.data == null||orders.hasError) {
                        return Container(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.error,color: Colors.redAccent,size: SizeUtil.getSize(6.0,GlobalData.sizeScreen!),),
                                Text('Ошибка получения данных',style:
                                TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent
                                ),),
                              ],
                            )
                        );
                      }
                      //тело таблицы
                      return Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0,90, 0, 0),
                            height: MediaQuery.of(context).size.height,
                            color: Colors.white,
                            child: TableBody(
                              tableState:_tableState!,
                              orderList: MapperDataOrderForTable.fromApi(list: orders.requireData!),
                              modelDataTable: _tableState!.modelDataTable!,
                              scrollController: _bodyController,
                              scrollControllertop: _bodyControllertop,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                0,
                                SizeUtil.getSize(
                                    10.0, GlobalData.sizeScreen!),
                                0,
                                0),
                            width: MediaQuery.of(context).size.width,
                            height: SizeUtil.getSize(
                                17.0, GlobalData.sizeScreen!),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0.4, 1.0],
                                  colors: [Colors.black26, Colors.white10],
                                )),
                            child: StreamBuilder<dynamic>(
                              stream: AppModule.blocTable.editState,
                              builder: (context, snapshot) {
                                if(!snapshot.hasData||snapshot.data==1){
                                  _controller.animateTo(0.0);
                                }else{
                                  _controller.animateBack(1.0);
                                }

                                return FadeTransition(
                                  opacity: Tween(
                                    begin: 1.0,
                                    end: 0.0,
                                  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn)),
                                  child: TableHead(
                                    posts:  GlobalData.numBoxes!,
                                    scrollController: _headController,
                                  ),
                                );
                              }
                            ),
                          ),
                        ],
                      );

                    });

              }),


          //Верхняя панель упрaвления
          StreamBuilder<dynamic>(
            stream: AppModule.blocTable.editState,
            builder: (context, snapshot) {
              if(!snapshot.hasData||snapshot.data==1){
                _controller.animateTo(0.0);
              }else{
                _controller.animateBack(1.0);
              }
              return FadeTransition(
                opacity: Tween(
                  begin: 1.0,
                  end: 0.0,
                ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn)),
                child: Padding(
                  padding:EdgeInsets.fromLTRB(0, SizeUtil.getSize(6.0,GlobalData.sizeScreen!), 0, 0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context,SlideTransitionRight(PageProfile()));
                          },
                          child: Container(
                            height: SizeUtil.getSize(4.0,GlobalData.sizeScreen!),
                            width: SizeUtil.getSize(4.0,GlobalData.sizeScreen!),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                boxShadow:[
                                  BoxShadow(
                                    color: Colors.black.withOpacity(.15),
                                    blurRadius: 10,
                                    offset: Offset(0,10),
                                  )],
                                color: Colors.white,
                                shape: BoxShape.circle
                            ),
                            child: Icon(Icons.person_rounded,color:AppColors.colorIndigo,size:SizeUtil.getSize(3.0,GlobalData.sizeScreen!),),
                          ),
                        ),

                        Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                                boxShadow:[
                                  BoxShadow(
                                    color: Colors.black.withOpacity(.15),
                                    blurRadius: 10,
                                    offset: Offset(0,10),
                                  )]
                            ),
                            height: SizeUtil.getSize(3.9,GlobalData.sizeScreen!),
                            padding: EdgeInsets.fromLTRB(7, 0, 4, 0),
                            child:ValueListenableBuilder<String>(
                              valueListenable: _notifierDropdownButton,
                              builder: (context,item,widget) {
                                return TextButton(
                                    onPressed: () {
                                      showCupertinoModalPopup(
                                          context: context,
                                          builder: (_) => Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: SizeUtil.getSize(15,GlobalData.sizeScreen!),
                                            child: CupertinoPicker(
                                              backgroundColor: Colors.white,
                                              itemExtent: 30,
                                              scrollController: FixedExtentScrollController(initialItem: _initValueTime),
                                              children: [
                                                Text('1 час'),
                                                Text('30 минут'),
                                                Text('15 минут'),
                                                Text('5 минут')
                                              ],
                                              onSelectedItemChanged: (value) {
                                                _initValueTime=value;
                                                _timeValue=_listTime[value];
                                                _notifierDropdownButton.value = _listTime[value];
                                                      AppModule.blocTable.streamSink
                                                          .add(state(_listTime[value]));
                                              },
                                            ),
                                          ));

                                    },
                                    child: Text(
                                      _timeValue,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                          SizeUtil.getSize(1.5, GlobalData.sizeScreen!)),
                                    ));

                              }
                            ) ),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                                boxShadow:[
                                  BoxShadow(
                                    color: Colors.black.withOpacity(.15),
                                    blurRadius: 10,
                                    offset: Offset(0,10),
                                  )]
                            ),
                            height: SizeUtil.getSize(3.9,GlobalData.sizeScreen!),

                            child: TextButton(
                                  onPressed: () {
                                    DatePicker.showDatePicker(context,
                                        showTitleActions: true,
                                        minTime: DateTime(TimeParser.parseMinRecordTime()[0],TimeParser.parseMinRecordTime()[1],TimeParser.parseMinRecordTime()[2]),
                                        maxTime: DateTime(TimeParser.parseMaxRecordTime()[0],TimeParser.parseMaxRecordTime()[1],TimeParser.parseMaxRecordTime()[2]),
                                        onConfirm: (date) {
                                      setState(() {
                                        GlobalData.date = date.toString().split(' ')[0];
                                        dateValue =dateFormat(date.weekday, date.month, date.day);
                                        _tableState!.getSettings(context: context, date: GlobalData.date!);
                                      });
                                    },
                                        currentTime: DateTime(int.parse(GlobalData.date!.split('-')[0]),int.parse(GlobalData.date!.split('-')[1]),int.parse(GlobalData.date!.split('-')[2])), locale: LocaleType.ru);
                                  },
                                  child: Text(
                                    dateValue,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            SizeUtil.getSize(1.5, GlobalData.sizeScreen!)),
                                  ))),

                      ],
                    )),
                ),
              );
            }
          ),

        ],
      ),
    );



  }




}
