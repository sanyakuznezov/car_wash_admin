import 'dart:async';

import 'package:car_wash_admin/domain/model/model_data_table.dart';
import 'package:car_wash_admin/domain/state/table_state.dart';
import 'package:car_wash_admin/global_data.dart';
import 'package:car_wash_admin/internal/dependencies/app_module.dart';
import 'package:car_wash_admin/utils/size_util.dart';
import 'package:car_wash_admin/utils/time_parser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import '../body_boxes_order/box_order.dart';
import '../body_boxes_order/drag_target_table.dart';
import 'box_time.dart';

bool accept=false;
class TableBody extends StatefulWidget {
  final ScrollController scrollController;
 final ScrollController scrollControllertop;
  final List<Map> orderList;
  final ModelDataTable modelDataTable;
  final TableState tableState;


  TableBody({required this.tableState,required this.scrollController,required this.orderList,required this.modelDataTable, required this.scrollControllertop});

  @override
  _TableBodyState createState() => _TableBodyState();
}

class _TableBodyState extends State<TableBody>  with SingleTickerProviderStateMixin{
  late LinkedScrollControllerGroup _controllers;
  late ScrollController _restColumnsController;
  late ScrollController _centerColumnsController;
  late ScrollController _timeColumnsController;
  late ScrollController _timeLineColumnsController;
  late ScrollController _timeLineEndTimeDayColumnsController;
  final timeState=GlobalData.stateTime;
  int leave=0;
  Map? _map;
  Map? _mapOld;
  bool read=false;
  late Timer _timer;
  String? _time;
  final double c1=108;
  double? startY;
  double paddingLeft=50.0;
  late AnimationController _controller;
  bool _isToPull=false;
   List<String> timeLine=[];
  final _keyLineChekShift=GlobalKey();
  late ValueNotifier<double> _notifierCheckY;
  late ValueNotifier<Map> _notifierMapOffset;
  bool _isRebuild=false;
  int indexForBox=-1;
  Map<String,double> offsetsY=Map();






  @override
  void initState() {
    super.initState();
    getTime();
    _notifierCheckY=ValueNotifier<double>(0);
    _notifierMapOffset=ValueNotifier<Map>({});
    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _controllers = LinkedScrollControllerGroup();
    _restColumnsController = _controllers.addAndGet();
    _centerColumnsController=_controllers.addAndGet();
    _timeColumnsController=_controllers.addAndGet();
    _timeLineColumnsController=_controllers.addAndGet();
    _timeLineEndTimeDayColumnsController=_controllers.addAndGet();
    _centerColumnsController.addListener(() {
      AppModule.blocTable.streamSinkScroll.add(_centerColumnsController.offset);
    });

  }

  //определяет коордынату контрольной полосы для определения сдвига
  Future<void> _offset(GlobalKey key)async {
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      if(key.currentContext!.findRenderObject()!=null){
        RenderBox? box = key.currentContext!.findRenderObject() as RenderBox;
        Offset position = box.localToGlobal(Offset.zero);
        _notifierCheckY.value=position.dy;
      }
      timer.cancel();
    });
  }



  //текущее время для управления линией времени на таблице
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

  //ширина столбцов в зависимости от количества постов
  double _getWight(int posts){
    double w=150;
    if(posts==1){
      w=SizeUtil.getSize(40.0,GlobalData.sizeScreen!);
    }
    return w;
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _controller.dispose();
    _restColumnsController.dispose();
    _centerColumnsController.dispose();
    _timeColumnsController.dispose();
    _timeLineColumnsController.dispose();
    _timeLineEndTimeDayColumnsController.dispose();
   // AppModule.blocTable.disponseDragStream();
  }

  @override
  Widget build(BuildContext context) {
    _isRebuild=false;
    return StreamBuilder<dynamic>(
          stream: AppModule.blocTable.stateTime,
            builder: (context,snapshot){
            if(snapshot.data==null){
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(color: Colors.indigo),
              );
            }
            indexForBox=-1;
            timeLine=TimeParser.getTimeTable(GlobalData.times[snapshot.data] as List<String>,widget.modelDataTable.startDayMin,widget.modelDataTable.endDayMin);
            return Stack(
                children: [
                  // Опредеяем позицию конрольной линии для определения смещения по оси Y
                  Positioned(
                    top:116,
                    child: Container(
                      key: _keyLineChekShift,
                      width: _getWight(GlobalData.numBoxes!) *GlobalData.numBoxes!.toDouble(),
                      height: 0.5,
                      child: FutureBuilder(
                        future: _offset(_keyLineChekShift),
                        builder: (context,data){
                          return Container();
                        },
                      ),
                    ),
                  ),
                  ValueListenableBuilder<double>(
                    valueListenable: _notifierCheckY,
                    builder: (context,offsetYLine,child){
                      if(offsetYLine!=0){
                        return Row(
                          children: [
                            // Сетка талицы с нумерацией постов и временной шкалой
                            SizedBox(
                              width: 50,
                              child:
                              ListView(
                                controller: _timeColumnsController,
                                physics: const AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics(),
                                ),
                                children: List.generate(timeLine.length, (index) {
                                  return BoxTime(time: timeLine[index]);
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
                                      width: _getWight(GlobalData.numBoxes!)*GlobalData.numBoxes!,
                                      child: ListView(
                                        controller: _restColumnsController,
                                        physics: const AlwaysScrollableScrollPhysics(
                                          parent: BouncingScrollPhysics(),
                                        ),
                                        children: List.generate(timeLine.length - 1, (y) {
                                          indexForBox++;
                                          return Row(
                                            children: List.generate(GlobalData.numBoxes!, (x) {
                                              return BoxOrder(
                                                  posts: GlobalData.numBoxes!,
                                                  index: indexForBox,
                                                  callbackBox: (yBox) {
                                                    if(!_isRebuild){
                                                      _notifierMapOffset.value={'yLine':offsetYLine,'yBox':yBox};
                                                      _isRebuild=true;
                                                    }
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
                        );
                      }else{
                        return Container();
                      }
                    },

                  ),



            //линия текущего времени
                  GlobalData.date==DateTime.now().toString().split(' ')[0]?
                  StreamBuilder<String>(
                      stream:  AppModule.blocTable.streamTimer,
                      builder: (context,time){
                        if(time.data!=null){
                          startY=c1+TimeParser.shiftTime(
                              time: TimeParser.parseHourForTimeLine(time.data!,widget.modelDataTable.startDayMin),
                              timeStep: snapshot.data);
                          return Container(
                              margin: EdgeInsets.fromLTRB(0, 9, 0, 0),
                              child: SingleChildScrollView(
                                  controller: _timeLineColumnsController,
                                  scrollDirection: Axis.vertical,
                                  physics: const AlwaysScrollableScrollPhysics(
                                      parent: BouncingScrollPhysics()),
                                  child: SizedBox(
                                      width: GlobalData.numBoxes!>1?_getWight(GlobalData.numBoxes!) *GlobalData.numBoxes!.toDouble():390,
                                      height: 80 * timeLine.length.toDouble(),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                              top:startY,
                                              child: Container(
                                                margin: EdgeInsets.fromLTRB(55, 0, 0, 0),
                                                color: Colors.indigo,
                                                //widget.modelDataTable.posts.toDouble()
                                                width: _getWight(GlobalData.numBoxes!) * GlobalData.numBoxes!.toDouble(),
                                                height: 2,
                                              ))
                                        ],
                                      ))));
                        }else{
                          return Container();
                        }

                      }):Container(),


                //линия- конец рабочего дня
                  //ToDo показывем линию окончания рабочеuuо дня только если время заканчивается не на ноль
                  !TimeParser.isTimeNotEven(TimeParser.parseIntToStringTime(widget.modelDataTable.endDayMin))?Container(
                      child: SingleChildScrollView(
                          controller: _timeLineEndTimeDayColumnsController,
                          scrollDirection: Axis.vertical,
                          physics: const AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          child: SizedBox(
                              width: GlobalData.numBoxes! > 1
                                  ? _getWight(GlobalData.numBoxes!) *
                                  GlobalData.numBoxes!.toDouble()
                                  : 390,
                              height: 80 * timeLine.length.toDouble(),
                              child: Stack(
                                children: [
                                  Positioned(
                                      top: c1+TimeParser.shiftTime(
                                          time: TimeParser.parseHourForTimeLineEndDay(widget.modelDataTable.endDayMin,widget.modelDataTable.startDayMin),
                                          timeStep: snapshot.data),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:  EdgeInsets.fromLTRB(13.0,0,0,0),
                                            child: Row(
                                              children: [
                                                Text('${TimeParser.parseIntToStringTime(widget.modelDataTable.endDayMin)}',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: SizeUtil.getSize(1.5,GlobalData.sizeScreen!)
                                                ),),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(14.0,0,0,0),
                                                  child: Text('Конец рабочего дня',
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: SizeUtil.getSize(1.5,GlobalData.sizeScreen!)
                                                    ),),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(13, 0, 0, 0),
                                            color: Colors.red,
                                            width: _getWight(GlobalData.numBoxes!) *
                                                GlobalData.numBoxes!.toDouble(),
                                            height: 1.5,
                                          ),
                                        ],
                                      ))
                                ],
                              )))):Container(),
                  //Столбцы таблицы
                  ValueListenableBuilder<Map>(
                    valueListenable: _notifierMapOffset,
                    builder: (context,mapOffset,child){
                      if(mapOffset.isNotEmpty){
                        return StreamBuilder<Map>(
                            stream:  AppModule.blocTable.dragS,
                            builder: (context,value){
                              if(value.data!=null){
                                if(value.data!['action']==1){
                                  int i=getIndex(widget.orderList[value.data!['index']]['id'],widget.orderList);
                                  _map={
                                    'id':widget.orderList[i]['id'],
                                    'enable':1,
                                    'start_date':widget.orderList[i]['start_date'],
                                    'expiration_date':widget.orderList[i]['expiration_date'],
                                    'post':widget.orderList[i]['post'],
                                    'orderBody':widget.orderList[i]['orderBody'],
                                  };
                                  if(!_isToPull){
                                    _mapOld={
                                      'id':widget.orderList[i]['id'],
                                      'enable':1,
                                      'start_date':widget.orderList[i]['start_date'],
                                      'expiration_date':widget.orderList[i]['expiration_date'],
                                      'post':widget.orderList[i]['post'],
                                      'orderBody':widget.orderList[i]['orderBody'],
                                    };
                                    _isToPull=true;
                                  }
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
                                  AppModule.blocTable.streamSinkDrag.add({'action':0,'index':0});
                                  _isToPull=false;

                                }
                              }

                              return Padding(
                                padding: EdgeInsets.fromLTRB(paddingLeft, 0, 0, 0),
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(0, 9, 0, 0),
                                    child: SingleChildScrollView(
                                      controller: _centerColumnsController,
                                      scrollDirection: Axis.vertical,
                                      physics: const AlwaysScrollableScrollPhysics(
                                          parent: BouncingScrollPhysics()),
                                      child: SizedBox(
                                        // _getWight(widget.modelDataTable.posts) * widget.modelDataTable.posts
                                        width: _getWight(GlobalData.numBoxes!) * GlobalData.numBoxes!,
                                        height: 80 *timeLine.length.toDouble(),
                                        child: SingleChildScrollView(
                                            controller: widget.scrollControllertop,
                                            scrollDirection: Axis.horizontal,
                                            physics: const AlwaysScrollableScrollPhysics(
                                                parent: BouncingScrollPhysics()),
                                            child: Row(
                                              children: List.generate(GlobalData.numBoxes!, (i) {
                                                return Container(
                                                    width: GlobalData.numBoxes!>1?150:300,
                                                    child: DragTargetTable(
                                                      80 * timeLine.length.toDouble(),
                                                      yBox: mapOffset['yBox'],
                                                      yLine: mapOffset['yLine'],
                                                      post:i,
                                                      tableState: widget.tableState,
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
                                    )),
                              );
                            });
                      }else{
                        return Container();
                      }
                    },


                  ),

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
                                  duration: Duration(seconds: 3),
                                  curve: Curves.easeOut);
                            },
                            onMove: (e) {
                          leave++;
                          if (leave == 1) {
                            _centerColumnsController.animateTo(
                                _centerColumnsController
                                    .position.maxScrollExtent,
                                duration: Duration(seconds: 3),
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
                        height: 100,
                        child: DragTarget<int>(
                            onLeave: (value) {
                              leave = 0;
                              _centerColumnsController.animateTo(
                                  _centerColumnsController.offset,
                                  duration: Duration(seconds: 3),
                                  curve: Curves.easeOut);
                            }, onMove: (e) {
                          leave++;
                          if (leave == 1) {

                            _centerColumnsController.animateTo(
                                _centerColumnsController
                                    .position.minScrollExtent,
                                duration: Duration(seconds: 3),
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
                        child: DragTarget<int>(
                            onLeave: (value) {
                          leave = 0;
                          widget.scrollControllertop.animateTo(
                              widget.scrollControllertop.offset,
                              duration: Duration(seconds:3),
                              curve: Curves.easeOut);

                        }, onMove: (e) {
                          leave++;
                          if (leave == 1) {
                            widget.scrollControllertop.animateTo(
                                widget.scrollControllertop
                                    .position.maxScrollExtent,
                                duration: Duration(seconds: 3),
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
                        child: DragTarget<int>(
                            onLeave: (value) {
                          leave = 0;
                          widget.scrollControllertop.animateTo(
                              widget.scrollControllertop.offset,
                              duration: Duration(seconds: 3),
                              curve: Curves.easeOut);
                        },
                            onMove: (e) {
                          leave++;
                          if (leave == 1) {
                            widget.scrollControllertop.animateTo(
                                widget.scrollControllertop
                                    .position.minScrollExtent,
                                duration: Duration(seconds: 3),
                                curve: Curves.easeOut);

                          }
                        }, builder: (BuildContext context,
                            List<dynamic> accepted, List<dynamic> rejected) {
                          return Container();
                        })),
                  )
                ]);

            });



  }
}




  //показать индекс из списка заказов по id
  getIndex(int id,List<Map> order){
  for(int i=0;order.length>i;i++){
    if(order[i]['id']==id){
      return i;
    }
  }
  }

