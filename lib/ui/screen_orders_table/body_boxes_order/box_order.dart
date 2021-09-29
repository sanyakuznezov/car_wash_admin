


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../global_data.dart';


class BoxOrder extends StatefulWidget{


  var callbackBox =(bool? drag,double? x,double? y)=>drag,x,y;
  BoxOrder({required this.dataOrder,this.index,Key? key,required this.callbackBox}):super(key:key);

  @override
  StateBoxOrder createState() {
    return StateBoxOrder();
  }
  final int? index;
  Map dataOrder;


}

 class StateBoxOrder extends State<BoxOrder>{



  @override
  Widget build(BuildContext context) {
    return Container(

          width: 150,
          height: 80,
          child: Stack(
            children: [
              widget.index! < GlobalData.numBoxes + 1
                  ? Align(
                      alignment: Alignment.topCenter,
                      child: Container(
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

            ],
          ),
        );


  }

  @override
  void initState() {
    super.initState();



  }


  parseHour(String time){
    String timeSplit=time.split(' ')[1];
    int hour=int.parse(timeSplit.split(':')[0]);
    int minute=int.parse(timeSplit.split(':')[1]);
    return hour*60+minute;
  }

 }





