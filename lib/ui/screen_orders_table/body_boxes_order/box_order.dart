


import 'dart:async';

import 'package:car_wash_admin/utils/size_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../global_data.dart';


class BoxOrder extends StatefulWidget{


  var callbackBox =(bool? drag,double? x,double? y)=>drag,x,y;
  int posts;
  BoxOrder({this.index,Key? key,required this.posts,required this.callbackBox}):super(key:key);

  @override
  StateBoxOrder createState() {
    return StateBoxOrder();
  }
  final int? index;



}

 class StateBoxOrder extends State<BoxOrder>{

   final containerKey = GlobalKey();
   double? x, y;


  @override
  Widget build(BuildContext context) {
    return Container(
          width: _getWight(widget.posts),
          height: 80,
          child: Stack(
            children: [
              widget.index! < widget.posts + 1
                  ? Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                          key: containerKey,
                        margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        color: Colors.grey,
                        height: 0.5,
                      ),
                    )
                  : Container(),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 0.5,
                  color: Colors.grey[200],

                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  color: Colors.grey,
                  height: 0.5,
                ),
              ),
              FutureBuilder(
                  future: _offset(containerKey),
                  builder: (context,data){
                    return Container();
                  }),
            ],
          ),
        );


  }

  //ширина бокса в зависимости от количества постов
  double _getWight(int posts){
    double w=150;
    if(posts==1){
      w=SizeUtil.getSize(40.0,GlobalData.sizeScreen!);
    }
    return w;
  }

  @override
  void initState() {
    super.initState();



  }

   Future<void> _offset(GlobalKey key) async {
    Timer.periodic(Duration(seconds: 3), (timer) {
      RenderBox? box = key.currentContext!.findRenderObject() as RenderBox;
      Offset position = box.localToGlobal(Offset.zero);
      y = position.dy;
      print('Offset line box $y');
      timer.cancel();
    });

   }

  parseHour(String time){
    String timeSplit=time.split(' ')[1];
    int hour=int.parse(timeSplit.split(':')[0]);
    int minute=int.parse(timeSplit.split(':')[1]);
    return hour*60+minute;
  }

 }






