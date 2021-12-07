import 'package:car_wash_admin/domain/state/bloc_page_route.dart';
import 'package:car_wash_admin/domain/state/table_state.dart';
import 'package:car_wash_admin/global_data.dart';
import 'package:car_wash_admin/internal/dependencies/app_module.dart';
import 'package:car_wash_admin/ui/global_widgets/container_botton_sheet.dart';
import 'package:car_wash_admin/ui/page_add_order/page_add_order.dart';
import 'package:car_wash_admin/utils/size_util.dart';
import 'package:car_wash_admin/utils/time_parser.dart';
import 'package:car_wash_admin/utils/time_position.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'body_order.dart';

bool _isWashingOrder=false;


//слой для размещения заказов и перемещение по слою заказов
class DragTargetTable extends StatefulWidget{

  double bodyHeaght;
   List<Map> orderList;
  int post;
  int timeStep;
  String time;
  TableState? tableState;
  var accept=(String? start,String? end,int? postNum)=>start,end,postNum;

  @override
  StateDragTargetTable createState() {
    // TODO: implement createState
    return StateDragTargetTable();
  }

  DragTargetTable(this.bodyHeaght,{required this.tableState,required this.orderList,required this.post,required this.timeStep,required this.accept,required this.time});
}

class StateDragTargetTable extends State<DragTargetTable> {
  int _leave = 0;
  double _y=0;
  double _scrollY = 0;
 List<Map> _offsetsOrder = [];
  double? startY;
  int? endCollision;
  int? startCollision;
  double? sizeBody;
  bool isCollision=false;
  int? _editState;
  int? _statusCode;
  final double c2=15;
  final double c3=SizeUtil.getSize(1.23,GlobalData.sizeScreen!);
  int? _timeParse;
  String? _date;




  @override
  Widget build(BuildContext context) {
    return Center(
      child: DragTarget<int>(
        builder: (BuildContext context, List<dynamic> accepted,List<dynamic> rejected) {
          _offsetsOrder.clear();
          _editState=0;
          _timeParse=TimeParser.parseHourForTimeLine(widget.time);
          return Container(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              alignment: Alignment.center,
              width: GlobalData.numBoxes!>1?150:300,
              height: widget.bodyHeaght,
              child: Stack(
                children: [
                  GestureDetector(
                    onDoubleTap: (){

                    },
                      onDoubleTapDown:(y){

                      if(!GlobalData.edit_mode){
                        if(_date==GlobalData.date){
                          if(TimeParser.isTimeValidate(TimePosition.getTime(y.localPosition.dy))){
                            Navigator.push(context, SlideTransitionSize(
                                PageAddOrder(
                                  editStatus:GlobalData.ADD_ORDER_MODE,
                                  timeEndWash: 1440,
                                  timeStartWash: 0,
                                  post:widget.post+1,time:TimePosition.getTime(y.localPosition.dy),date:GlobalData.date,)));
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('Время истекло')));
                          }
                        }else{
                          Navigator.push(context, SlideTransitionSize(
                              PageAddOrder(
                                editStatus:GlobalData.ADD_ORDER_MODE,
                                timeEndWash: 1440,
                                timeStartWash: 0,
                                post:widget.post+1,time:TimePosition.getTime(y.localPosition.dy),date:GlobalData.date,)));
                        }

                      }


                    },

                      onTap: () {
                      if (GlobalData.edit_mode) {
                        if(GlobalData.accept){
                          if(GlobalData.isCollision!){
                            _statusCode=2;
                          }else{
                            _statusCode=0;
                          }
                          showModalBottomSheet(
                            backgroundColor: Colors.white,
                            context: context,
                            builder: (context) => ContainerBottomSheet(
                              statusCode: _statusCode!,
                              onCancellation: (i){
                                AppModule.blocTable.streamSinkDrag.add({'action':6,'index':widget.orderList.length-1});
                              },
                                onAccept: (id){
                                  // AppModule.blocTable.streamSinkDrag.add({'action':3,
                                  //   'index':widget.orderList.length-1,
                                  // 'start':GlobalData.timeStart,
                                  // 'end':GlobalData.timeEnd,
                                  // 'post':GlobalData.post});
                                  widget.tableState!.editOrderJournal(endAt: GlobalData.timeEnd!.split(' ')[1], startAt: GlobalData.timeStart!.split(' ')[1], context: context, idOrder: GlobalData.idOrder!, post: GlobalData.post!);

                                },
                                post: GlobalData.post!,
                                timeStart: GlobalData.timeStart!,
                                timeEnd: GlobalData.timeEnd!),
                          );
                        }else{
                         if(GlobalData.timeEnd!.isEmpty){
                           GlobalData.edit_mode=false;
                           AppModule.blocTable.streamSinkEdit.add(1);
                           AppModule.blocTable.streamSinkDrag.add({'action':4});
                         }else{
                           if(GlobalData.isCollision!){
                             _statusCode=2;
                           }else{
                             _statusCode=1;
                           }

                           showModalBottomSheet(
                             backgroundColor: Colors.white,
                             context: context,
                             builder: (context) => ContainerBottomSheet(
                               statusCode: _statusCode!,
                               onCancellation: (i){
                                 GlobalData.edit_mode=false;
                                 AppModule.blocTable.streamSinkDrag.add({'action':4});
                               },
                                 onAccept: (id){
                                   // AppModule.blocTable.streamSinkDrag.add({'action':5,
                                   //   'id':GlobalData.id,
                                   //   'start':GlobalData.timeStart,
                                   //   'end':GlobalData.timeEnd,
                                   //   'post':GlobalData.post});
                                   widget.tableState!.editOrderJournal(endAt: TimeParser.parsingTime(GlobalData.timeEnd!.split(' ')[1]), startAt: GlobalData.timeStart!.split(' ')[1], context: context, idOrder: GlobalData.idOrder!, post: GlobalData.post!);

                                 },
                                 post: GlobalData.post!,
                                 timeStart: GlobalData.timeStart!,
                                 timeEnd: GlobalData.timeEnd!),
                           );

                         }
                        }

                      }

                  }),
                  Stack(
                      children: List.generate(widget.orderList.length, (a) {
                        if(widget.orderList[a]['post'] == widget.post + 1){
                            //проверяем переходящий заказ с предыдущего дня если да то начало заказа с 00:00
                            startY=getY(a,TimeParser.parseHour(widget.orderList[a]['start_date']),TimeParser.parseHour(widget.orderList[a]['expiration_date']),widget.timeStep);
                            sizeBody=_sizeBody(a,TimeParser.parseHour(widget.orderList[a]['start_date']), TimeParser.parseHour(widget.orderList[a]['expiration_date']),widget.timeStep);
                            endCollision=TimeParser.parseHourEndCollision( startY!, GlobalData.timeStepsConstant[widget.timeStep]['coof'],sizeBody!.toInt());
                            startCollision=TimeParser.parseHourStartCollision(widget.orderList[a]['start_date']);
                            if(widget.orderList[a]['enable']==1){
                              _offsetsOrder.add({'start':startCollision,'end':endCollision,'id':widget.orderList[a]['id']});
                            }
                            if(GlobalData.edit_mode){
                               if(widget.orderList.length==a+1&&_leave==0){
                                 _editState=1;
                               }
                            }

                            //Рзмещение заказов по таблице
                            return Positioned(
                                top: startY,
                                left: 5,
                                child: widget.orderList[a]['enable']==1?BodyCard(
                                  lengthOrders: widget.orderList.length,
                                  onMsgError: (data){
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('Время заказа истекло')));
                                  },
                                  offsetsOrder: _offsetsOrder,
                                  timePosition: _timeParse,
                                  onTimeStart: (start){
                                    GlobalData.timeStart =start;
                                    },
                                  onId: (id){
                                    GlobalData.id=id;
                                     if(widget.orderList[id!]['orderBody'].status==11){
                                       _isWashingOrder=true;
                                     }else{
                                       _isWashingOrder=false;
                                     }
                                  },
                                  onPost: (post){
                                    GlobalData.post=post;
                                  },
                                  bodyHeight: sizeBody!,
                                  dataOrder: widget.orderList[a],
                                  timeStep: widget.timeStep,
                                  stateDrag: _editState!,
                                ):Container());
                        } else{
                          return Container();

                        }
                      }
                        )),
                  _leave == 2 ? StreamBuilder<dynamic>(
                      stream: AppModule.blocTable.stateDYFeedback,
                      builder: (context, y) {
                        return Stack(
                          children: [
                            StreamBuilder<dynamic>(
                                stream: AppModule.blocTable.stateDY,
                                builder: (context, value) {
                                  if (value.data != null) {
                                    _scrollY = value.data;
                                  }

                                  //позиция тени во время перетаскивания заказа
                                  return y.data != null ? Positioned(
                                      top: y.data + _scrollY-35,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin:EdgeInsets.all(3.0),
                                            padding: EdgeInsets.all(3.0),
                                            decoration: BoxDecoration(
                                                color: isCollision?Colors.red.withOpacity(0.5):Colors.black12,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Text('${widget.post+1}',
                                              style: TextStyle(
                                                  color: Colors.white
                                              ),),
                                          ),
                                          Container(
                                            margin:EdgeInsets.all(3.0),
                                            padding: EdgeInsets.all(3.0),
                                            decoration: BoxDecoration(
                                                color: isCollision?Colors.red.withOpacity(0.5):Colors.black12,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Text(_isWashingOrder?'${widget.orderList[GlobalData.id!]['start_date'].split(' ')[1]}':
                                              '${TimeParser.parseReverseTimeStart(_y.toInt() + _scrollY.toInt(), widget.timeStep).split(' ')[1]}',
                                              style: TextStyle(
                                                  color: Colors.white
                                              ),),
                                          ),
                                          Container(
                                            width: GlobalData.numBoxes!>1?140:280,
                                            height: GlobalData.bodyHeightFeedBackWidget + c3,
                                            decoration: BoxDecoration(
                                                color: isCollision?Colors.red.withOpacity(0.5):Colors.black12,
                                                borderRadius: BorderRadius.circular(10)
                                            ),

                                          ),
                                          Container(
                                            margin:EdgeInsets.all(3.0),
                                            padding: EdgeInsets.all(3.0),
                                            decoration: BoxDecoration(
                                                color: isCollision?Colors.red.withOpacity(0.5):Colors.black12,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Text(_isWashingOrder?'${widget.orderList[GlobalData.id!]['expiration_date'].split(' ')[1]}': '${TimeParser.parseReverseTimeEnd(
                                                _y.toInt() + _scrollY.toInt(),
                                                GlobalData.bodyHeightFeedBackWidget.toInt(), widget.timeStep).split(' ')[1]}',
                                            style: TextStyle(
                                              color: Colors.white
                                            ),),
                                          ),
                                        ],
                                      )) : Container();
                                })
                          ],
                        );
                      }) : Container(),

                ],
              )
          );
        },
        onAccept: (int data) {
          setState(() {
            _leave = 0;
            GlobalData.accept = true;
            if(widget.orderList[data]['orderBody'].status==11){
              GlobalData.timeStart=widget.orderList[data]['start_date'];
              GlobalData.timeEnd=widget.orderList[data]['expiration_date'];
            }else{
              GlobalData.timeStart = TimeParser.parseReverseTimeStart(
                  _y.toInt() + _scrollY.toInt(), widget.timeStep);
              GlobalData.timeEnd = TimeParser.parseReverseTimeEnd(
                  _y.toInt() + _scrollY.toInt(),
                  GlobalData.bodyHeightFeedBackWidget.toInt(), widget.timeStep);
            }
            GlobalData.post=widget.post+1;
            widget.accept(GlobalData.timeStart,GlobalData.timeEnd,widget.post+1);
            _scrollY = 0;

          });
        },

        onLeave: (e) {
          setState(() {
            _leave = 1;
          });
        },
        //слушает карточку во время перетягивания
        onMove: (e) {
          GlobalData.accept=false;
          _y = e.offset.dy-120;
          AppModule.blocTable.streamSinkFeedback.add(_y);
          if (_leave != 2) {
            setState(() {
              _leave = 2;
            });
          }
          if(_offsetsOrder.isNotEmpty){
            isCollision=_isColision(_offsetsOrder,TimeParser.parseTimeStartFeedBack(_y+_scrollY,widget.timeStep),TimeParser.parseTimeEndFeedBack( _y+_scrollY,GlobalData.bodyHeightFeedBackWidget.toInt(),widget.timeStep));
            GlobalData.isCollision=isCollision;
          }else{
            isCollision=false;
            GlobalData.isCollision=false;
          }



        },



      ),

    );
  }


  @override
  void initState() {
    super.initState();
    _date=DateTime.now().toString().split(' ')[0];
  }

  @override
  void dispose() {
    super.dispose();
   // AppModule.blocTable.diponseScrollStream();
   // AppModule.blocTable.disponseFeedBackStream();
  }

  double _sizeBody(int index,int start,int end,int timeStep){
    double? result;
    if(start>end){
      //делаем проверку даты начала и конца заказа с выбранной
      if(widget.orderList[index]['start_date'].split(' ')[0]!=GlobalData.date){
       result=end.toDouble()+GlobalData.timeStepsConstant[timeStep]['shift'];
      }else{
        result=1800-start.toDouble();
      }
    }else{
      result=end.toDouble()-start.toDouble();
    }

    return result*GlobalData.timeStepsConstant[timeStep]['coof'];
  }

  //сдвиг координаты для позииии заказов в звисимости от размера экрана
  getY(int index,int start,int end,int timeStep){
    double s=110+TimeParser.shiftTime(time_start: TimeParser.parseHour(widget.orderList[index]['start_date']),timeStep: timeStep);
    if(start>end){
      if(widget.orderList[index]['start_date'].split(' ')[0]!=GlobalData.date){
          s=-110;
      }
    }
    if(GlobalData.sizeScreen!<700){
      return s-4;
    }else if(GlobalData.sizeScreen!>700&&GlobalData.sizeScreen!<800){
      return s+4;
    }else{
      return s;
    }
  }

  //проверяем пересечение с границами соседних заказов а так же линии времени
  //b1-время начала перетаскиваемоо заказа  b2- время окончания перетаскиваемоо заказа
  _isColision(List<Map> orders,int b1,int b2){
      for(int i=0;orders.length>i;i++){
        if(orders[i]['start']<b1&&orders[i]['end']>b1||orders[i]['start']<b2&&orders[i]['end']>b2){
          return true;
        }

        if(orders[i]['start']>orders[i]['end']){
         if( b1<=orders[i]['end']){
           return true;
         }
        }

        if(b1<=orders[i]['end']&&b2>=orders[i]['start']){
          return true;
        }

        //проверка для линии времени
        if(_date==GlobalData.date){
          if(b1<_timeParse!||b2<_timeParse!){
            return true;
          }
        }


      }



    return false;
  }


}


