

 import 'package:badges/badges.dart';
import 'package:car_wash_admin/app_colors.dart';
import 'package:car_wash_admin/domain/model/user_data.dart';
import 'package:car_wash_admin/utils/size_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../global_data.dart';

class PageProfile extends StatefulWidget{

    UserData? _userData;

    PageProfile(this._userData);

  @override
  State<PageProfile> createState() => _PageProfileState();
}

class _PageProfileState extends State<PageProfile> {

  bool _isError=false;
  double radius=SizeUtil.getSize(6.0,GlobalData.sizeScreen!);
  double radius2=SizeUtil.getSize(2.0,GlobalData.sizeScreen!);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: AppColors.colorBackgrondProfile,
       body: Column(
         children: [
       AppBar(
         elevation: 1.0,
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
                     child: Text('Профиль',
                       textAlign: TextAlign.center,
                       style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,
                           fontSize: SizeUtil.getSize(2.8,GlobalData.sizeScreen!)),),
                   )
                 ],
               ),
             ),
           )

         ],
         backgroundColor: Colors.white),
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(SizeUtil.getSize(5.0,GlobalData.sizeScreen!)),
                      child: Center(
                        child: Badge(
                          elevation: 1.0,
                          badgeColor: AppColors.colorIndigo,
                          badgeContent: Container(
                            margin: EdgeInsets.all(SizeUtil.getSize(0.8,GlobalData.sizeScreen!)),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: SizeUtil.getSize(2.0,GlobalData.sizeScreen!),
                            ),
                          ),
                          child: CircleAvatar(
                              backgroundImage: NetworkImage(GlobalData.URL_BASE_IMAGE+widget._userData!.avatar),
                             onBackgroundImageError: (a,r){
                                setState(() {
                                  this._isError = true;
                                });

                             },
                            backgroundColor: Colors.white,
                              radius: radius,
                            child: _isError?Icon(
                              Icons.image_not_supported_rounded,
                              color: AppColors.colorBackgrondProfile,
                              size: SizeUtil.getSize(4.0,GlobalData.sizeScreen!),
                            ):Container(),
                             ),
                        ),
                      ),
                    ),
                     Text(' ${widget._userData!.firstname} ${widget._userData!.patronymic} ${widget._userData!.lastname}',
                     style: TextStyle(
                        color: AppColors.textColorDark,
                       fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                     ),),
                    Text('${widget._userData!.email}',
                      style: TextStyle(
                          color: AppColors.textColorHint,
                          fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                      ),),




                    Container(
                      margin: EdgeInsets.fromLTRB(0,SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(0.8,GlobalData.sizeScreen!)),
                      child:
                      Column(
                        children: [
                          Align(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(SizeUtil.getSize(4.0,GlobalData.sizeScreen!),SizeUtil.getSize(2.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(2.0,GlobalData.sizeScreen!)),
                              child: Text('Контактная информация',
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
                                      Text('Имя пользователя',
                                          style: TextStyle(
                                              color: AppColors.textColorItem,
                                              fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                                          )),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color: AppColors.colorIndigo,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(height: 2,
                                color: AppColors.colorBackgrondProfile),
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
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: AppColors.colorIndigo,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(height: 2,
                                    color: AppColors.colorBackgrondProfile),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )
         ],
       ),
    );
  }

  @override
  void initState() {

  }
}