


  import 'package:car_wash_admin/app_colors.dart';
import 'package:car_wash_admin/domain/model/user_data.dart';
import 'package:car_wash_admin/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../global_data.dart';

class PageNameEdit extends StatefulWidget{


  UserData? _userData;

  @override
  StatePageNameEdit createState() {
    // TODO: implement createState
    return StatePageNameEdit();
  }

  PageNameEdit(this._userData);
}

 class StatePageNameEdit extends State<PageNameEdit>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBackgrondProfile,
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
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
                        child: Text('Имя пользователя',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,
                              fontSize: SizeUtil.getSize(2.8,GlobalData.sizeScreen!)),),
                      ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: Text('Ред.',
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
            margin: EdgeInsets.fromLTRB(0,SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0,0),
            color: Colors.white,
            child: Column(
              children: [
            Padding(
            padding:EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  child: Text('Имя',
                      style: TextStyle(
                          color: AppColors.textColorItem,
                          fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                      )),
                ),
              ),
              Expanded(
                child: Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget._userData!.firstname,
                        style: TextStyle(
                            color: AppColors.textColorPhone,
                            fontWeight: FontWeight.bold,
                            fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                        )),
                    ),
                ),
              ),
            ],
          ),
            ),
                Container(height: 1,
                    color: AppColors.colorLine),
                Padding(
                  padding:EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Text('Отчество',
                              style: TextStyle(
                                  color: AppColors.textColorItem,
                                  fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                              )),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(widget._userData!.patronymic,
                                style: TextStyle(
                                    color: AppColors.textColorPhone,
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(height: 1,
                    color: AppColors.colorLine),
                Padding(
                  padding:EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Text('Фамилия',
                              style: TextStyle(
                                  color: AppColors.textColorItem,
                                  fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                              )),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(widget._userData!.lastname,
                                style: TextStyle(
                                    color: AppColors.textColorPhone,
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                )

              ],
            ),
          )


        ],
      ),
    );
  }


 }