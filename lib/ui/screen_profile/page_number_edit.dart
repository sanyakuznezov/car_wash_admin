

 import 'package:car_wash_admin/domain/model/user_data.dart';
import 'package:car_wash_admin/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../app_colors.dart';
import '../../global_data.dart';

class PageNumberEdit extends StatefulWidget{

  UserData? _userData;

  @override
  StatePageNumberEdit createState() {
    // TODO: implement createState
  return StatePageNumberEdit();
  }

  PageNumberEdit(this._userData);
}


class StatePageNumberEdit extends State<PageNumberEdit>{
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
              Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Stack(
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
                      Center(
                        child: Text('Номер телефона',
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
            margin: EdgeInsets.fromLTRB(0,SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(0.8,GlobalData.sizeScreen!)),
            child: Column(
              children: [
                Align(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(SizeUtil.getSize(4.0,GlobalData.sizeScreen!),SizeUtil.getSize(2.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(2.0,GlobalData.sizeScreen!)),
                    child: Text('Телефон',
                        style: TextStyle(
                            color: AppColors.textColorTitle,
                            fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                        )),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding:EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                        child: Row(
                          children: [
                            Text('Номер телефона',
                                style: TextStyle(
                                    color: AppColors.textColorItem,
                                    fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                                )),
                            Expanded(
                              child: Padding(
                                padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                                child: Text('${widget._userData!.phone}',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        color: AppColors.textColorPhone,
                                        fontWeight: FontWeight.bold,
                                        fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                                    )),
                              ),
                            ),
                          ],
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