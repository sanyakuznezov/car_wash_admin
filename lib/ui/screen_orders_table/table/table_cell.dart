import 'dart:ui';

import 'package:car_wash_admin/utils/size_util.dart';
import 'package:flutter/material.dart';

import '../../../app_colors.dart';
import '../../../global_data.dart';



class MultiplicationTableCell extends StatelessWidget {
  final int value;
  final int posts;


  MultiplicationTableCell({required this.posts,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWight(posts),
      height: SizeUtil.getSize(6.22,GlobalData.sizeScreen!),
      color: AppColors.colorBackgrondProfile,
      alignment: Alignment.center,
      child:
          Container(
            height: SizeUtil.getSize(3.73,GlobalData.sizeScreen!),
            width: SizeUtil.getSize(3.73,GlobalData.sizeScreen!),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle
            ),
            child: Text(value.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeUtil.getSize(2.49,GlobalData.sizeScreen!),
                  color: Colors.black),
            ),
          )

    );
  }


  //ширина столбцов в зависимости от количества постов
  double getWight(int posts){
    double w=150;
    if(posts==1){
      w=SizeUtil.getSize(40.0,GlobalData.sizeScreen!);
    }
    return w;
  }
}
