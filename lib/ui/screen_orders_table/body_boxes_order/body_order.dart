



import 'package:car_wash_admin/domain/state/bloc_page_route.dart';
import 'package:car_wash_admin/global_data.dart';
import 'package:car_wash_admin/internal/dependencies/app_module.dart';
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

  BodyCard(
      {required this.dataOrder,
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
                if(isTime(widget.timePosition!,widget.dataOrder['start_date'])){
                  if(!GlobalData.edit_mode&&widget.bodyHeight>=78) {
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
                  }
                }else{
                  widget.onMsgError('');
                }
              },

              child: StreamBuilder<dynamic>(
                stream: AppModule.blocTable.editState,
                builder: (context,state){
                  if(state.data==1){
                    if(widget.stateDrag==1){
                      widget.stateDrag =0;
                    }

                  }
                  return widget.stateDrag ==0?Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                          alignment: Alignment.center,
                         // margin: EdgeInsets.fromLTRB(0, 0, 0, 3),
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
                              //проверка на перехоной заказ
                              !rollingOrder?Expanded(child:Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      Text(
                                        widget.dataOrder['orderBody'].carNumber,
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.grey),
                                      ),
                                      Icon(
                                        Icons.sentiment_satisfied_alt,
                                        color: Colors.grey,
                                        size: 24.0,
                                      ),

                                      widget.bodyHeight>=156?
                                      Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                                          child:
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('- ${widget.dataOrder['orderBody'].carType}',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 16, color: Colors.grey),
                                              ),
                                              Text('- ${ widget.dataOrder['orderBody'].brandTitle}',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 16, color: Colors.grey),
                                              ),
                                            ],
                                          )):Container()
                                    ],
                                  ))):Container()
                            ],
                          ):Container()),

                    ],
                  ):LayerController(bodyHeaght: widget.bodyHeight,color: colorBage(widget.dataOrder['orderBody'].status)!,
                      dataOrder:widget.dataOrder,
                  timeStep: widget.timeStep,
                  offsetsOrder: widget.offsetsOrder);
                },))

        ],

      );

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

  isTime(int t1,String t2){
   var r=TimeParser.parseHour(t2);
   String date=DateTime.now().toString().split(' ')[0];
   if(t1>r&&GlobalData.date==date){
     return false;
   }
    return true;
  }



  @override
  void dispose() {
    super.dispose();
  //AppModule.blocTable.diponseEditStream();
  }
}



