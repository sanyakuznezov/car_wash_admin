



 import 'package:car_wash_admin/global_data.dart';
import 'package:flutter/material.dart';

import '../../../utils/size_util.dart';



class BoxTime extends StatelessWidget{

    String time='--:--';
    BoxTime({required this.time});

  @override
  Widget build(BuildContext context) {
     return Container(
       padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
       alignment: Alignment.topRight,
       width: 80,
       height: 80,
       child: Text(time,
         style: TextStyle(
           fontWeight: thumbnail(time)?FontWeight.bold:FontWeight.normal,
           fontSize: thumbnail(time)?15:13,
             color: thumbnail(time)?Colors.black:Colors.grey
         ),),
     );
  }


}

 bool thumbnail(String time){
  bool i=false;
    GlobalData.time_1.forEach((element) {
        if(time==element){
          i= true;
        }
    });
      return i;
 }