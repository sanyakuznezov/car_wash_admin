import 'dart:async';

import 'package:car_wash_admin/domain/state/bloc_table_order.dart';
import 'package:car_wash_admin/global_data.dart';
import 'package:car_wash_admin/internal/dependencies/app_module.dart';
import 'package:car_wash_admin/utils/time_parser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import '../body_boxes_order/body_order.dart';
import '../body_boxes_order/box_order.dart';
import '../body_boxes_order/drag_target_table.dart';
import 'box_time.dart';
import 'layer_drag_controller.dart';
import 'package:sizer/sizer.dart';

bool accept=false;
class TableBody extends StatefulWidget {
  final ScrollController scrollController;
  final ScrollController scrollController_top;
  final List<Map> orderList=GlobalData.dataOrdersList;
  TableBody({ required this.scrollController_top,required this.scrollController,
  });

  @override
  _TableBodyState createState() => _TableBodyState();
}

class _TableBodyState extends State<TableBody> {
  late LinkedScrollControllerGroup _controllers;
  late ScrollController _restColumnsController;
  late ScrollController _centerColumnsController;
  late ScrollController _timeColumnsController;
  late ScrollController _timeLineColumnsController;
  bool dragControll=false;
  double? _x;
   double? _y;
  final timeState=GlobalData.stateTime;
  final numBoxes=GlobalData.numBoxes;
  int leave=0;
  Map? _map;
  Map? _mapOld;
  bool read=false;
  late Timer _timer;
  String? _time;
  final double c1=108;
  double? startY;


  @override
  void initState() {
    super.initState();
    getTime();
    _controllers = LinkedScrollControllerGroup();
    _restColumnsController = _controllers.addAndGet();
    _centerColumnsController=_controllers.addAndGet();
    _timeColumnsController=_controllers.addAndGet();
    _timeLineColumnsController=_controllers.addAndGet();
    _centerColumnsController.addListener(() {
      AppModule.blocTable.streamSinkScroll.add(_centerColumnsController.offset);
    });

  }

  void getTime() {
     DateTime now=DateTime.now();
    _time=now.hour.toString() + ":" + now.minute.toString();
     AppModule.blocTable.streamSinkTime.add(_time);
    _timer = new Timer.periodic(new Duration(milliseconds: 60000), (timer) {
      now = DateTime.now();
      _time=now.hour.toString() + ":" + now.minute.toString();
      AppModule.blocTable.streamSinkTime.add(_time);
    });

  }

  @override
  void dispose() {
    _timer.cancel();
    _restColumnsController.dispose();
    _centerColumnsController.dispose();
    _timeColumnsController.dispose();
    _timeLineColumnsController.dispose();
    AppModule.blocTable.disponseDragStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int index=-1;
    return
        StreamBuilder<dynamic>(
          stream: AppModule.blocTable.stateTime,
            builder: (context,snapshot){
            if(snapshot.data==null){
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(color: Colors.indigo),
              );
            }
            return FutureBuilder<List>(
              future: AppModule.blocTable.addOrderInBox(timeState,numBoxes,widget.orderList),
                builder: (context,data) {
                  index=-1;
              if (data.data == null) {
                return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    color: Colors.indigo,
                  ),
                );
              }
              return Stack(
                children: [
                  Row(
                children: [

                  // Сетка талицы с нумераией постов и временной шкалой
                  SizedBox(
                    width: 50,
                    child:
                    ListView(
                      controller: _timeColumnsController,
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      children: List.generate(GlobalData.times[snapshot.data].length, (index) {
                        return BoxTime(time: GlobalData.times[snapshot.data][index]);
                      }),
                    ),
                  ),

                       Expanded(
                         child: Container(
                           margin: EdgeInsets.fromLTRB(0, 9, 0, 0),
                           child: SingleChildScrollView(
                               controller: widget.scrollController,
                               scrollDirection: Axis.horizontal,
                               physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                  ),
                               child: SizedBox(
                                 width: 150 * GlobalData.numBoxes.toDouble(),
                                 child: ListView(
                                   controller: _restColumnsController,
                                   physics: const AlwaysScrollableScrollPhysics(
                                     parent: BouncingScrollPhysics(),
                                   ),
                                   children: List.generate(GlobalData.times[snapshot.data].length - 1, (y) {
                                     return Row(
                                       children: List.generate(GlobalData.numBoxes.toInt(), (x) {
                                         return BoxOrder(
                                             dataOrder: data.data![0],
                                             index: index,
                                             callbackBox: (drag, x, y) {
                                               setState(() {
                                                 _x = x;
                                                 _y = y;
                                                 dragControll = true;
                                               });
                                             });
                                       }

                                       ),

                                    );
                                  }),
                                 )
                                 ,
                               )
                           ),
                         ),
                       ),

                     ],
                ),

                  //линия текущего времени
                  StreamBuilder<String>(
                    stream:  AppModule.blocTable.streamTimer,
                      builder: (context,time){
                    if(time.data!=null){
                      startY=c1+TimeParser.shiftTime(
                          time_start: TimeParser.parseHourForTimeLine(time.data!),
                          timeStep: snapshot.data);
                      return Expanded(
                          child: Container(
                              margin: EdgeInsets.fromLTRB(0, 9, 0, 0),
                              child: SingleChildScrollView(
                                  controller: _timeLineColumnsController,
                                  scrollDirection: Axis.vertical,
                                  physics: const AlwaysScrollableScrollPhysics(
                                      parent: BouncingScrollPhysics()),
                                  child: SizedBox(
                                      width: 150 * GlobalData.numBoxes.toDouble(),
                                      height: 80 * GlobalData.times[snapshot.data].length.toDouble(),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                              top:startY,
                                              child: Container(
                                                margin: EdgeInsets.fromLTRB(55, 0, 0, 0),
                                                color: Colors.indigo,
                                                width: 150 * GlobalData.numBoxes.toDouble(),
                                                height: 2,
                                              ))
                                        ],
                                      )))));
                    }else{
                      return Container();
                    }

                  }),


                //Столбцы таблицы
                  StreamBuilder<Map>(
                    stream:  AppModule.blocTable.dragS,
                      builder: (context,value){
                      if(value.data!=null){
                        if(value.data!['action']==1){
                              int i=getIndex(widget.orderList[value.data!['index']]['id'],widget.orderList);
                             _map={'id':widget.orderList[i]['id'],
                               'enable':1,
                              'start_date':widget.orderList[i]['start_date'],
                              'expiration_date':widget.orderList[i]['expiration_date'],
                              'post':widget.orderList[i]['post'],
                              'status':widget.orderList[i]['status'],
                              'brand_car':widget.orderList[i]['brand_car'],
                              'type_car':widget.orderList[i]['type_car'],
                              'number_car':widget.orderList[i]['number_car'],
                              'region':widget.orderList[i]['region'],};
                              _mapOld={'id':widget.orderList[i]['id'],
                                'enable':1,
                                'start_date':widget.orderList[i]['start_date'],
                                'expiration_date':widget.orderList[i]['expiration_date'],
                                'post':widget.orderList[i]['post'],
                                'status':widget.orderList[i]['status'],
                                'brand_car':widget.orderList[i]['brand_car'],
                                'type_car':widget.orderList[i]['type_car'],
                                'number_car':widget.orderList[i]['number_car'],
                                'region':widget.orderList[i]['region'],};
                              widget.orderList[i].update('enable', (value) =>0);

                        }else if(value.data!['action']==3){
                          int i=getIndex(widget.orderList[value.data!['index']]['id'],widget.orderList);
                          widget.orderList[i].update('start_date', (v) => value.data!['start']);
                          widget.orderList[i].update('expiration_date', (v) => value.data!['end']);
                          widget.orderList[i].update('post', (v) => value.data!['post']);

                        }else if(value.data!['action']==5){
                          int i=getIndex(value.data!['id'],widget.orderList);
                          widget.orderList[i].update('start_date', (v) => value.data!['start']);
                          widget.orderList[i].update('expiration_date', (v) => value.data!['end']);
                          widget.orderList[i].update('post', (v) => value.data!['post']);
                        }else if(value.data!['action']==6){
                          int i=getIndex(widget.orderList[value.data!['index']]['id'],widget.orderList);
                          widget.orderList[i].update('enable', (value) =>0);
                          _mapOld!.update('id', (value) =>widget.orderList.length);
                          widget.orderList.add(_mapOld!);
                          print('Data old 2 ${_mapOld!['start_date']}  -- ${_mapOld!['post']}');
                        }
                      }
                  return Padding(
                    padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                    child: Expanded(
                        child: Container(
                            margin: EdgeInsets.fromLTRB(0, 9, 0, 0),
                            child: SingleChildScrollView(
                              controller: _centerColumnsController,
                              scrollDirection: Axis.vertical,
                              physics: const AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics()),
                              child: SizedBox(
                                width: 150 * GlobalData.numBoxes.toDouble(),
                                height: 80 * GlobalData.times[snapshot.data].length.toDouble(),
                                child: SingleChildScrollView(
                                    controller: widget.scrollController_top,
                                    scrollDirection: Axis.horizontal,
                                    physics: const AlwaysScrollableScrollPhysics(
                                        parent: BouncingScrollPhysics()),
                                    child: Row(
                                      children: List.generate(GlobalData.numBoxes.toInt(), (i) {
                                        return Container(
                                            width: 150,
                                            child: DragTargetTable(80 * GlobalData.times[snapshot.data].length.toDouble(),
                                              post:i,
                                              time: _time!,
                                              orderList: widget.orderList,
                                              timeStep: snapshot.data,
                                             accept: (start,end,postNum){
                                              AppModule.blocTable.streamSinkDrag.add({'action':2});
                                                _map!.update('start_date', (value) => start);
                                                _map!.update('expiration_date', (value) => end);
                                                _map!.update('post', (value) => postNum);
                                                _map!.update('id', (value) =>widget.orderList.length);
                                              widget.orderList.add(_map!);
                                            },));
                                      }),
                                    )
                                ),
                              ),
                            ))),
                  );
                  }),

                 //Датчики для скроллов таблицы
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: DragTarget<int>(
                            onLeave: (value) {
                          leave = 0;
                          _centerColumnsController.animateTo(
                              _centerColumnsController.offset,
                              duration: Duration(seconds: 10),
                              curve: Curves.easeOut);
                        }, onMove: (e) {
                          leave++;
                          if (leave == 1) {
                            _centerColumnsController.animateTo(
                                _centerColumnsController
                                    .position.maxScrollExtent,
                                duration: Duration(seconds: 10),
                                curve: Curves.easeOut);
                          }
                        }, builder: (BuildContext context,
                            List<dynamic> accepted, List<dynamic> rejected) {
                          return Container();
                        })),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: DragTarget<int>(
                            onLeave: (value) {
                          leave = 0;
                          _centerColumnsController.animateTo(
                              _centerColumnsController.offset,
                              duration: Duration(seconds: 10),
                              curve: Curves.easeOut);
                        }, onMove: (e) {
                          leave++;
                          if (leave == 1) {

                            _centerColumnsController.animateTo(
                                _centerColumnsController
                                    .position.minScrollExtent,
                                duration: Duration(seconds: 10),
                                curve: Curves.easeOut);
                          }
                        }, builder: (BuildContext context,
                            List<dynamic> accepted, List<dynamic> rejected) {
                          return Container();
                        })),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                        width: 50,
                        height: MediaQuery.of(context).size.height,
                        child: DragTarget<int>(onLeave: (value) {
                          leave = 0;
                          widget.scrollController_top.animateTo(
                              widget.scrollController_top.offset,
                              duration: Duration(seconds: 5),
                              curve: Curves.easeOut);
                        }, onMove: (e) {
                          leave++;
                          if (leave == 1) {
                            widget.scrollController_top.animateTo(
                                widget.scrollController_top
                                    .position.maxScrollExtent,
                                duration: Duration(seconds: 5),
                                curve: Curves.easeOut);
                          }
                        }, builder: (BuildContext context,
                            List<dynamic> accepted, List<dynamic> rejected) {
                          return Container();
                        })),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        width: 100,
                        height: MediaQuery.of(context).size.height,
                        child: DragTarget<int>(onLeave: (value) {
                          leave = 0;
                          widget.scrollController_top.animateTo(
                              widget.scrollController_top.offset,
                              duration: Duration(seconds: 5),
                              curve: Curves.easeOut);
                        }, onMove: (e) {
                          leave++;
                          if (leave == 1) {
                            widget.scrollController_top.animateTo(
                                widget.scrollController_top
                                    .position.minScrollExtent,
                                duration: Duration(seconds: 5),
                                curve: Curves.easeOut);
                          }
                        }, builder: (BuildContext context,
                            List<dynamic> accepted, List<dynamic> rejected) {
                          return Container();
                        })),
                  )
                ]);
              });
        });



  }
}




  getIndex(int id,List<Map> order){
  for(int i=0;order.length>i;i++){
    if(order[i]['id']==id){
      return i;
    }
  }
  }
