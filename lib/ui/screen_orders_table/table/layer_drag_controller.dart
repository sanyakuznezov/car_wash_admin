

  import 'package:car_wash_admin/internal/dependencies/app_module.dart';
import 'package:car_wash_admin/utils/time_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../global_data.dart';





// ignore: must_be_immutable
class LayerController extends StatefulWidget{

   double bodyHeaght;
   Color color;
   Map dataOrder;
   int timeStep;
   List<Map> offsetsOrder;
   int lenghtOrders;



  @override
  State<StatefulWidget> createState() {
    return StateLayerController();
  }
  LayerController({required this.lenghtOrders,required this.bodyHeaght,required this.color,required this.dataOrder,required this.timeStep,required this.offsetsOrder});
}


   class StateLayerController extends State<LayerController>{

          double _wight=GlobalData.numBoxes!>1?130:260;
          bool visibleTime=false;
          int stateDrag=0;
          bool isDragEnd=false;
          bool isStretch=true;
          bool isVisibleToast=true;

     @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onVerticalDragUpdate: (d) {
          if(widget.timeStep!=3){
            if (d.primaryDelta! > 0) {
              widget.bodyHeaght+=getIncrement(widget.timeStep);
            } else if (d.primaryDelta! < 0) {
              widget.bodyHeaght-=getIncrement(widget.timeStep);
            }
            if(TimeParser.parseTimeStartFeedBack(widget.bodyHeaght+1,widget.timeStep)<=getTime(widget.timeStep)){
              isStretch=false;
              if(isVisibleToast){
                Fluttertoast.showToast(
                    msg: "Заказ ${getTime(widget.timeStep)} минут",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
                GlobalData.bodyHeightFeedBackWidget=80;
                GlobalData.timeEnd=TimeParser.parseSkrethTime(widget.bodyHeaght.toInt(),widget.timeStep,widget.dataOrder['start_date']);
                isVisibleToast=false;
              }

            }else{
              isStretch=true;
            }

            if(isStretch){
              setState(() {
                isVisibleToast=true;
              });
            }
          }


        },
        onVerticalDragEnd: (v){
          if(widget.timeStep==3){
            if (v.primaryVelocity! > 0) {
              widget.bodyHeaght+=getIncrement(widget.timeStep);
            } else if (v.primaryVelocity! < 0) {
              widget.bodyHeaght-=getIncrement(widget.timeStep);
            }
            if(TimeParser.parseTimeStartFeedBack(widget.bodyHeaght,widget.timeStep)<=getTime(widget.timeStep)){
              isStretch=false;
              if(isVisibleToast){
                Fluttertoast.showToast(
                    msg: "Заказ 5 минут",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0

                );
                GlobalData.bodyHeightFeedBackWidget=80;
                GlobalData.timeEnd=TimeParser.parseSkrethTime(widget.bodyHeaght.toInt(),widget.timeStep,widget.dataOrder['start_date']);
                isVisibleToast=false;
              }

            }else{
              isStretch=true;
            }

            if(isStretch){
              setState(() {
                isVisibleToast=true;
              });
            }
          }
          if(isStretch){
            widget.bodyHeaght=TimeParser.makeMultipleOfFive(widget.bodyHeaght);
            GlobalData.bodyHeightFeedBackWidget=widget.bodyHeaght;
            GlobalData.timeEnd=TimeParser.parseSkrethTime(widget.bodyHeaght.toInt(),widget.timeStep,widget.dataOrder['start_date']);
            GlobalData.isCollision=isColissionEdit(widget.offsetsOrder,TimeParser.parseHour(GlobalData.timeEnd!),TimeParser.parseHour(GlobalData.timeStart!));

          }
          
        },
        child: Container(
          width: _wight,
          height: widget.bodyHeaght,
          child: Draggable<int>(
                   maxSimultaneousDrags:1,
                  data: widget.dataOrder['id'],
                  affinity: Axis.horizontal,
                  axis: widget.dataOrder['orderBody'].status==11?Axis.horizontal:null,
                  onDragStarted: (){
                    AppModule.blocTable.streamSinkDrag.add({'action':1,'index':widget.dataOrder['id']});
                  },
                  onDragEnd: (r) {

                  },
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                             margin: EdgeInsets.fromLTRB(0, 1, 0, 3),
                             width: _wight,
                             height: widget.bodyHeaght,
                             decoration: BoxDecoration(
                                 color: widget.color,
                                 borderRadius: BorderRadius.circular(10)),
                             child: Padding(
                                 padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
                                 child:widget.bodyHeaght>60?
                                 // информация о заказе в теле карточки
                                 Column(
                                   children: [
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       children: [
                                         Text(
                                           widget.dataOrder['orderBody'].carNumber,
                                           style: TextStyle(
                                               fontSize: 12, color: Colors.white),
                                         ),
                                         Padding(
                                           padding: const EdgeInsets.all(3.0),
                                           child: Container(
                                             height: 12,
                                             width: 1,
                                             color:  Colors.white,
                                           ),
                                         ),
                                         Text(
                                           '${widget.dataOrder['orderBody'].carRegion}',
                                           style: TextStyle(
                                               fontSize: 12,  color: Colors.white),
                                         ),
                                       ],
                                     ),
                                     widget.bodyHeaght>=156?
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
                                                   color: Colors.white
                                               ),
                                             ),
                                             Container(
                                               width: 98,
                                               child: Text('${ widget.dataOrder['orderBody'].textArray[0]}',
                                                 style: TextStyle(
                                                     fontSize: 10, color: Colors.white),
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
                                                   color: Colors.white
                                               ),
                                             ),
                                             Container(
                                               width: 98,
                                               child: Text('${ widget.dataOrder['orderBody'].textArray[1]}',
                                                 style: TextStyle(
                                                     fontSize: 11, color: Colors.white),
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
                                                   color: Colors.white
                                               ),
                                             ),
                                             Container(
                                               width: 98,
                                               child: Text('${ widget.dataOrder['orderBody'].textArray[2]}',
                                                 style: TextStyle(
                                                     fontSize: 11, color: Colors.white),
                                               ),
                                             ),
                                           ],
                                         ):Container(),
                                         widget.dataOrder['orderBody'].textArray.length>4?
                                         Row(
                                           children: [
                                             Container(
                                               margin: const EdgeInsets.fromLTRB(0, 0, 3, 0),
                                               height: 3,
                                               width: 3,
                                               decoration: BoxDecoration(
                                                   shape: BoxShape.circle,
                                                   color: Colors.white
                                               ),
                                             ),
                                             Container(
                                               width: 98,
                                               child: Text('${ widget.dataOrder['orderBody'].textArray[3]}',
                                                 style: TextStyle(
                                                     fontSize: 11, color: Colors.white),
                                               ),
                                             ),
                                           ],
                                         ):Container(),
                                         widget.dataOrder['orderBody'].textArray.length>5?
                                         Row(
                                           children: [
                                             Container(
                                               margin: const EdgeInsets.fromLTRB(0, 0, 3, 0),
                                               height: 3,
                                               width: 3,
                                               decoration: BoxDecoration(
                                                   shape: BoxShape.circle,
                                                   color: Colors.white
                                               ),
                                             ),
                                             Container(
                                               width: 98,
                                               child: Text('${ widget.dataOrder['orderBody'].textArray[4]}',
                                                 style: TextStyle(
                                                     fontSize: 11, color: Colors.white),
                                               ),
                                             ),
                                           ],
                                         ):Container(),
                                         widget.dataOrder['orderBody'].textArray.length>=6?
                                         Row(
                                           children: [
                                             Container(
                                               margin: const EdgeInsets.fromLTRB(0, 0, 3, 0),
                                               height: 3,
                                               width: 3,
                                               decoration: BoxDecoration(
                                                   shape: BoxShape.circle,
                                                   color: Colors.white
                                               ),
                                             ),
                                             Container(
                                               width: 98,
                                               child: Text('${ widget.dataOrder['orderBody'].textArray[5]}',
                                                 style: TextStyle(
                                                     fontSize: 11, color: Colors.white),
                                               ),
                                             ),
                                           ],
                                         ):Container(),

                                         Padding(padding:const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                           child: Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               Text('ЦЕНА',
                                                 style: TextStyle(
                                                     fontWeight: FontWeight.bold,
                                                     fontSize: 10, color: Colors.white),
                                               ),
                                               Text('${ widget.dataOrder['orderBody'].totalPrice} P.',
                                                 overflow: TextOverflow.ellipsis,
                                                 style: TextStyle(
                                                     fontSize: 10, color: Colors.white),
                                               ),
                                             ],
                                           ),)
                                       ],
                                     ):Container()
                                   ],
                                 ):Container())),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: widget.color, width: 1),
                              shape: BoxShape.circle,
                              color: Colors.white),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: widget.color, width: 1),
                              shape: BoxShape.circle,
                              color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  childWhenDragging: Container(),
                  feedback: FeedBackWidget(widget.lenghtOrders,widget.bodyHeaght,widget.color,widget.dataOrder)),
        ));
  }
          getTime(int timeStep){
            if(timeStep==0){
              return 60;
            }else if(timeStep==1){
              return 30;
            }else if(timeStep==2){
              return 15;
            }else if(timeStep==3){
              return 0;
            }
          }

          getIncrement(int timeStep){
              if(timeStep==0){
              return 0.5;
            }else if(timeStep==1){
              return 1.0;
            }else if(timeStep==2){
              return 1.5;
            }else if(timeStep==3){
              return 80;
            }
          }
          //пересечение заказов при растягивании заказа
          //b2-время окончания заказа b1-время начала заказа
          isColissionEdit(List<Map> orders,int b2,int b1){
               bool result=false;
               for(int i=0;orders.length>i;i++){
                 if(orders[i]['id']!=widget.dataOrder['id']){
                   if(orders[i]['start']<b2&&orders[i]['end']>b2){
                     result=true;
                   }
                   if(orders[i]['start']<b1&&orders[i]['end']>b1){
                     result=true;
                   }


                   if(b1<=orders[i]['end']&&b2>=orders[i]['start']){
                     return true;
                   }
                 }

            }
            return result;
          }

}



  class FeedBackWidget extends StatefulWidget{

   final double bodyHeaght;
   final Color color;
   final Map dataOrder;
   final int lenghtOrders;
    FeedBackWidget(this.lenghtOrders,this.bodyHeaght,this.color,this.dataOrder);

  @override
  State<FeedBackWidget> createState() => _FeedBackWidgetState();
}

class _FeedBackWidgetState extends State<FeedBackWidget> {
  @override
    Widget build(BuildContext context) {
      return Material(
          child: Container(
            width: GlobalData.numBoxes!>1?130:260,
            height: widget.bodyHeaght,
            child:  Stack(
              children: [
                Align(
                    alignment: Alignment.center,
                    child:
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 1, 0, 3),
                        width: GlobalData.numBoxes!>1?130:260,
                        height: widget.bodyHeaght,
                        decoration: BoxDecoration(
                            color: widget.color,
                            borderRadius: BorderRadius.circular(10)
                        ),

                        child:Padding(
                            padding: EdgeInsets.fromLTRB(15,5,5,5),
                            child: Column(
                              children: [
                                Text(widget.dataOrder['orderBody'].carNumber,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                Icon(
                                  Icons.sentiment_satisfied_alt,
                                  color: Colors.white,
                                  size: 24.0,
                                ),

                                widget.bodyHeaght>=156?
                                Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                                    child:
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 120.0,
                                          child: Text('- ${widget.dataOrder['orderBody'].carType}',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 16, color: Colors.white),
                                          ),
                                        ),
                                        Container(
                                          width: 120.0,
                                          child: Text('- ${widget.dataOrder['orderBody'].brandTitle}',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 16, color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    )):Container()
                              ],
                            )))),
                Align(
                  alignment: Alignment.topRight,
                  child:  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                        border: Border.all(color: widget.color,width: 1),
                        shape: BoxShape.circle,
                        color: Colors.white),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child:  Container(
                    margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                        border: Border.all(color:widget.color,width: 1),
                        shape: BoxShape.circle,
                        color: Colors.white),
                  ),
                )
              ],
            ),
          )


      );
    }

  @override
  void dispose() {
    super.dispose();
    if(!GlobalData.accept){
      Fluttertoast.showToast(
          msg: "Заказ вернулся в исходное состояние",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      GlobalData.edit_mode=false;
      AppModule.blocTable.streamSinkEdit.add(1);
      AppModule.blocTable.streamSinkDrag.add({'action':6,'index':widget.lenghtOrders-1});

    }
  }
}


