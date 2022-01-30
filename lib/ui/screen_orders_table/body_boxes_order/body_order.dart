



import 'package:car_wash_admin/domain/state/bloc_page_route.dart';
import 'package:car_wash_admin/global_data.dart';
import 'package:car_wash_admin/internal/dependencies/app_module.dart';
import 'package:car_wash_admin/ui/global_widgets/container_botton_sheet.dart';
import 'package:car_wash_admin/ui/page_add_order/page_add_order.dart';
import 'package:car_wash_admin/utils/time_parser.dart';
import 'package:car_wash_admin/utils/time_position.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../table/layer_drag_controller.dart';


   bool accept=false;

class BodyCard extends StatefulWidget{

  Map dataOrder;
  List<Map> offsetsOrder;
  int timeStep;
  double bodyHeight;
  int stateDrag;
  var onTimeStart=(String? timeStart)=>timeStart;
  var onMsgError=(String? msg)=>msg;
  var onPost=(int? post)=>post;
  var onId=(int? id)=>id;
  int? timePosition;
  int lengthOrders;

  BodyCard(
      {required this.lengthOrders,
        required this.dataOrder,
      required this.timeStep,
      required this.bodyHeight,
      required this.stateDrag,
      required this.onTimeStart,
      required this.onPost,
      required this.onId,
      required this.offsetsOrder,
      required this.timePosition,
      required this.onMsgError});

  @override
  StateBodyCard createState() {
    // TODO: implement createState
    return StateBodyCard();
  }




}


class StateBodyCard extends State<BodyCard>{


   int? editStatus;
   bool rollingOrder=false;

  @override
  void initState() {
    super.initState();
    if(TimeParser.parseHour(widget.dataOrder['start_date'])>TimeParser.parseHour(widget.dataOrder['expiration_date'])){
      if(widget.dataOrder['start_date'].split(' ')[0]!=GlobalData.date){
        rollingOrder=true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
        children: [
          GestureDetector(
             onDoubleTap: (){
               if(widget.dataOrder['orderBody'].status==11){
                 editStatus=GlobalData.VIEW_MODE;
               }else{
                 editStatus=GlobalData.EDIT_MODE;
               }
               Navigator.push(context, SlideTransitionSize(
                   PageAddOrder(
                     editStatus:editStatus!,
                     timeEndWash: 1440,
                     timeStartWash: 0,
                     post:widget.dataOrder['post'],
                     time:'${widget.dataOrder['orderBody'].startDate.split(' ')[1]}-${widget.dataOrder['orderBody'].endDate.split(' ')[1]}',
                     date:GlobalData.date,
                     idOrder: widget.dataOrder['orderBody'].id,)));
             },

              onLongPress: () {
                if(_isCarryoverOrder(widget.dataOrder['expiration_date'],widget.dataOrder['start_date'])){
                  GlobalData.idOrder=widget.dataOrder['orderBody'].id;
                  showModalBottomSheet(
                    backgroundColor: Colors.white,
                    context: context,
                    builder: (context) => ContainerBottomSheet(
                        statusCode:0,
                        statusOrder: widget.dataOrder['orderBody'].status,
                        onCancellation: (i){
                          GlobalData.edit_mode=false;
                          AppModule.blocTable.streamSinkDrag.add({'action':4});
                        },
                        onAccept: (id){


                        },
                        post: 0,
                        timeStart: widget.dataOrder['start_date'],
                        timeEnd: widget.dataOrder['expiration_date']),
                  );
                }else{
                  if(_isTime(widget.timePosition!,widget.dataOrder['expiration_date'],widget.dataOrder['start_date'])){
                    if(widget.bodyHeight>=78) {
                      setState(() {
                        widget.stateDrag = 1;
                       AppModule.blocTable.streamSinkEdit.add(0);
                        GlobalData.bodyHeightFeedBackWidget = widget.bodyHeight.toDouble();
                        GlobalData.edit_mode = true;
                        GlobalData.accept=false;
                        GlobalData.idOrder=widget.dataOrder['orderBody'].id;
                        GlobalData.timeEnd='';
                        widget.onTimeStart(widget.dataOrder['start_date']);
                        widget.onPost(widget.dataOrder['post']);
                        widget.onId(widget.dataOrder['id']);
                      });
                    }else{
                      if(!GlobalData.edit_mode){
                        Fluttertoast.showToast(
                            msg: "Для редактирования заказа, перейдите на другой шаг времени",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }

                    }
                  }else{
                    widget.onMsgError('');
                  }
                }

              },

              child: StreamBuilder<dynamic>(
                stream: AppModule.blocTable.editState,
                builder: (context,state){
                  if(state.data==1){
                    if(widget.stateDrag==1){
                      widget.stateDrag=0;
                    }
                  }
                  return widget.stateDrag==0?Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                          alignment: Alignment.center,
                          width:GlobalData.numBoxes!>1?130:260,
                          height: widget.bodyHeight,
                          decoration: BoxDecoration(
                              color: colorBody(widget.dataOrder['orderBody'].status),
                              borderRadius: BorderRadius.circular(10)),

                          child: widget.bodyHeight>=78?Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 15,
                                height: 80,
                                decoration: BoxDecoration(
                                    color: colorBage(widget.dataOrder['orderBody'].status),
                                    borderRadius: widget.bodyHeight>=80?
                                    BorderRadius.only(topLeft:Radius.circular(10),bottomLeft: Radius.circular(0)):
                                    BorderRadius.only(topLeft:Radius.circular(10),bottomLeft: Radius.circular(10))
                                ),
                              ),
                              //проверка на переходной заказ
                              !rollingOrder?Expanded(
                                  child:
                                  Padding(
                                  padding: EdgeInsets.all(5),
                                  child:
                                      // информация о заказе в теле карточки
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          Text(
                                            widget.dataOrder['orderBody'].carNumber,
                                            style: TextStyle(
                                                fontSize: 12, color: Colors.grey),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Container(
                                              height: 12,
                                              width: 1,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                           '${widget.dataOrder['orderBody'].carRegion}',
                                            style: TextStyle(
                                                fontSize: 12, color: Colors.grey),
                                          ),
                                          widget.dataOrder['orderBody'].status==11?Padding(
                                            padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                                            child: Icon(
                                              Icons.sentiment_satisfied_alt,
                                              color: widget.dataOrder['orderBody'].reputation>=3?Colors.green:widget.dataOrder['orderBody'].reputation<=-3?Colors.red:Colors.grey,
                                              size: 17.0,
                                            ),
                                          ):Container(),

                                        ],
                                      ),



                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          widget.dataOrder['orderBody'].textArray.length>0?
                                          Row(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 0, 3, 0),
                                                height: 3,
                                                width: 3,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.grey
                                                ),
                                              ),
                                              Container(
                                                width: 98,
                                                child: Text('${ widget.dataOrder['orderBody'].textArray[0]}',
                                                  style: TextStyle(
                                                      fontSize: 10, color: Colors.grey),
                                                ),
                                              ),
                                            ],
                                          ):Container(),
                                          widget.dataOrder['orderBody'].textArray.length>2?
                                          Row(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 0, 3, 0),
                                                height: 3,
                                                width: 3,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.grey
                                                ),
                                              ),
                                              Container(
                                                width: 98,
                                                child: Text('${ widget.dataOrder['orderBody'].textArray[1]}',
                                                  style: TextStyle(
                                                      fontSize: 11, color: Colors.grey),
                                                ),
                                              ),
                                            ],
                                          ):Container(),
                                          widget.dataOrder['orderBody'].textArray.length>3?
                                          Row(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 0, 3, 0),
                                                height: 3,
                                                width: 3,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.grey
                                                ),
                                              ),
                                              Container(
                                                width: 98,
                                                child: Text('${ widget.dataOrder['orderBody'].textArray[2]}',
                                                  style: TextStyle(
                                                      fontSize: 11, color: Colors.grey),
                                                ),
                                              ),
                                            ],
                                          ):Container(),
                                          widget.dataOrder['orderBody'].textArray.length>4&&widget.bodyHeight>=90?
                                          Row(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 0, 3, 0),
                                                height: 3,
                                                width: 3,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.grey
                                                ),
                                              ),
                                              Container(
                                                width: 98,
                                                child: Text('${ widget.dataOrder['orderBody'].textArray[3]}',
                                                  style: TextStyle(
                                                      fontSize: 11, color: Colors.grey),
                                                ),
                                              ),
                                            ],
                                          ):Container(),
                                          widget.dataOrder['orderBody'].textArray.length>5&&widget.bodyHeight>=110?
                                          Row(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 0, 3, 0),
                                                height: 3,
                                                width: 3,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.grey
                                                ),
                                              ),
                                              Container(
                                                width: 98,
                                                child: Text('${ widget.dataOrder['orderBody'].textArray[4]}',
                                                  style: TextStyle(
                                                      fontSize: 11, color: Colors.grey),
                                                ),
                                              ),
                                            ],
                                          ):Container(),
                                          widget.dataOrder['orderBody'].textArray.length>=6&&widget.bodyHeight>=140?
                                          Row(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 0, 3, 0),
                                                height: 3,
                                                width: 3,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.grey
                                                ),
                                              ),
                                              Container(
                                                width: 98,
                                                child: Text('${ widget.dataOrder['orderBody'].textArray[5]}',
                                                  style: TextStyle(
                                                      fontSize: 11, color: Colors.grey),
                                                ),
                                              ),
                                            ],
                                          ):Container(),

                                          _isVisiblePrice(widget.bodyHeight,widget.dataOrder['orderBody'].textArray.length)?Padding(padding:const EdgeInsets.fromLTRB(0,10, 0, 0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('ЦЕНА',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                      fontSize: 10, color: Colors.grey),
                                                ),
                                                Text('${ widget.dataOrder['orderBody'].totalPrice} P.',
                                                  style: TextStyle(
                                                      fontSize: 10, color: Colors.grey),
                                                ),
                                              ],
                                            ),):Container()
                                        ],
                                      )
                                    ],
                                  ))):Container()
                            ],
                          ):Container()),

                    ],
                  ):LayerController(lenghtOrders:widget.lengthOrders,bodyHeaght: widget.bodyHeight,color: colorBage(widget.dataOrder['orderBody'].status)!,
                      dataOrder:widget.dataOrder,
                  timeStep: widget.timeStep,
                  offsetsOrder: widget.offsetsOrder);
                },))

        ],

      );

  }

   bool _isVisiblePrice(double wight,int length){

    bool visible=false;
    if(wight>=170&&length==6){
      visible=true;
    }
    if(wight>=160&&length==5){
      visible=true;
    }
    if(wight>=110&&length==4){
      visible=true;
    }
    if(wight>=90&&length<=3){
      visible=true;
    }

    return visible;
   }

  
  Color? colorBody(int status){
   return status==11?Colors.green[200]:
   status==20?Colors.yellow[200]:
   status==30?Colors.indigo[100]:
   status==40?Colors.grey[300]:Colors.blue[100];
  }

  Color? colorBage(int status){
    return status==11?Colors.green:
    status==20?Colors.yellow:
    status==30?Colors.indigo[400]:
    status==40?Colors.black:Colors.indigoAccent;
  }

   //проверка на перехоящий заказ
   // t2-время окончания заказа t3-время начала заказ
  _isCarryoverOrder(String t2,String t3){
    var r=TimeParser.parseHour(t2);
    var r2=TimeParser.parseHour(t3);
    var r3=GlobalData.endDayMin;
    if(r>r3||r<r2){
      return true;
    }
    return false;
  }

   //проверка времени окончания заказа по отношению к линии времени
   // t1-временная шкала t2-время окончания заказа t3-время начала заказа
   //r<r1- переходящий заказ
  _isTime(int t1,String t2,String t3){
   String dateStart=t3.split(' ')[0];
   String dateEnd=t2.split(' ')[0];
   var r=TimeParser.parseHour(t2);
   var r1=TimeParser.parseHour(t3);
   String date=DateTime.now().toString().split(' ')[0];
   if(GlobalData.date==date){
     if(r<r1){
         if(dateStart==GlobalData.date){
           if(t1>1440){
             return false;
           }
         }else if(dateEnd==GlobalData.date){
             if(t1>r){
               return false;
             }
         }
     }else{
       if(t1>r){
         return false;
       }
     }
   }





    return true;
  }



  @override
  void dispose() {
    super.dispose();
  //AppModule.blocTable.diponseEditStream();
  }
}



