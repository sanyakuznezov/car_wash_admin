import 'dart:ui';

import 'package:car_wash_admin/utils/size_util.dart';
import 'package:flutter/material.dart';

import '../../../app_colors.dart';
import '../../../global_data.dart';



class MultiplicationTableCell extends StatelessWidget {
  final int value;


  MultiplicationTableCell({
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
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
}
