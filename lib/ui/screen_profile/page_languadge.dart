


import 'package:car_wash_admin/app_colors.dart';
import 'package:car_wash_admin/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../global_data.dart';

class PageLanguadge extends StatefulWidget{
  @override
  StatePageLanguage createState() {
    // TODO: implement createState
   return StatePageLanguage();
  }


}

 class StatePageLanguage extends State<PageLanguadge>{

  bool isLang_1=true;
  bool isLang_2=false;
  bool isLang_3=false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBackgrondProfile,
      body: Column(
        children: [
          AppBar(
            elevation: 0,
             backgroundColor: Colors.white,
            actions: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.colorIndigo,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text('Язык',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,
                              fontSize: SizeUtil.getSize(2.8,GlobalData.sizeScreen!)),),
                      ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: Text('Сохр.',
                          style: TextStyle(
                              color: AppColors.colorIndigo,
                              fontSize: SizeUtil.getSize(2.3,GlobalData.sizeScreen!)
                          ),),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),

          Container(
            margin: EdgeInsets.fromLTRB(0,SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(0.8,GlobalData.sizeScreen!)),
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding:EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                  child: Row(
                    children: [
                      Text('Русский',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                          )),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: isLang_1?SvgPicture.asset('assets/frame.svg'):Container()
                          ),
                        ),
                      ]),
                    ),
                Container(height: 1,
                    color: AppColors.colorLine),
                Padding(
                  padding:EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                  child: Row(
                    children: [
                      Text('Язык 2',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                          )),

                      Expanded(
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: isLang_2?SvgPicture.asset('assets/frame.svg'):Container()
                        ),
                      )],
                  ),
                ),
                Container(height: 1,
                    color: AppColors.colorLine),

                Padding(
                  padding:EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                  child: Row(
                    children: [
                      Text('Язык 3',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                          )),
                      Expanded(
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: isLang_3?SvgPicture.asset('assets/frame.svg'):Container()
                        ),
                      )],
                  ),
                ),

              ]),
                ),


              ],
            ),
          );
  }



 }