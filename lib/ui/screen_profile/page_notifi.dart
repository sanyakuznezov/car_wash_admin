


 import 'package:car_wash_admin/app_colors.dart';
import 'package:car_wash_admin/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../../global_data.dart';

class PageNotifi extends StatefulWidget{
  @override
  StatePageNotifi createState() {
    // TODO: implement createState
   return StatePageNotifi();
  }




}


 class StatePageNotifi extends State<PageNotifi>{

  bool _isEmail=false;
  bool _isWhatsApp=false;
  bool _isTelegram=false;
  bool _isNewOrder=false;
  bool _isDelOrder=false;
  bool _isNewOtziv=false;
  bool _isNewComment=false;
  bool _isRecordings=false;
  bool _isStaff=false;
  bool _isSale=false;
  bool _isPriceList=false;
  bool _isCarwashinformation=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBackgrondProfile,
      body: SingleChildScrollView(
        child: Column(
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
                          child: Text('Уведомления',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,
                                fontSize: SizeUtil.getSize(2.8,GlobalData.sizeScreen!)),),
                        )
                      ],
                    ),
                  ),
                )

              ],
            ),
        Container(
          margin: EdgeInsets.fromLTRB(0,SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(0.8,GlobalData.sizeScreen!)),
          child:Column(
            children: [
              Align(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(SizeUtil.getSize(4.0,GlobalData.sizeScreen!),SizeUtil.getSize(2.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(2.0,GlobalData.sizeScreen!)),
                  child: Text('Способ получения уведомлений',
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
                          Text('E-mail',
                              style: TextStyle(
                                  color: AppColors.textColorItem,
                                  fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                              )),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                height: SizeUtil.getSize(3.5,GlobalData.sizeScreen!),
                                child: Switch(onChanged: (bool value) {
                                     setState(() {
                                       _isEmail=value;
                                     });
                                },
                                  value: _isEmail),
                              )

                              )
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
                          Text('WhatsApp',
                              style: TextStyle(
                                  color: AppColors.textColorItem,
                                  fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                              )),
                          Expanded(
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    height: SizeUtil.getSize(3.5,GlobalData.sizeScreen!),
                                    child: Switch(onChanged: (bool value) {
                                      setState(() {
                                        _isWhatsApp=value;
                                      });
                                    },
                                        value: _isWhatsApp),
                                  )

                              )
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
                          Text('Telegram',
                              style: TextStyle(
                                  color: AppColors.textColorItem,
                                  fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                              )),
                          Expanded(
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    height: SizeUtil.getSize(3.5,GlobalData.sizeScreen!),
                                    child: Switch(onChanged: (bool value) {
                                      setState(() {
                                        _isTelegram=value;
                                      });
                                    },
                                        value: _isTelegram),
                                  )

                              )
                          ),
                        ],
                      ),
                    ),
                    ],
                ),
              )

            ],
          )



        ),



            Container(
                margin: EdgeInsets.fromLTRB(0,SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(0.8,GlobalData.sizeScreen!)),
                child:Column(
                  children: [
                    Align(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(SizeUtil.getSize(4.0,GlobalData.sizeScreen!),SizeUtil.getSize(2.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(2.0,GlobalData.sizeScreen!)),
                        child: Text('События',
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
                                Text('Новый заказ',
                                    style: TextStyle(
                                        color: AppColors.textColorItem,
                                        fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                                    )),
                                Expanded(
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: SizedBox(
                                          height: SizeUtil.getSize(3.5,GlobalData.sizeScreen!),
                                          child: Switch(onChanged: (bool value) {
                                            setState(() {
                                              _isNewOrder=value;
                                            });
                                          },
                                              value: _isNewOrder),
                                        )

                                    )
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
                                Text('Об удалении заказа',
                                    style: TextStyle(
                                        color: AppColors.textColorItem,
                                        fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                                    )),
                                Expanded(
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: SizedBox(
                                          height: SizeUtil.getSize(3.5,GlobalData.sizeScreen!),
                                          child: Checkbox(
                                            value: _isDelOrder,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                _isDelOrder=value!;
                                              });

                                          },),
                                        )

                                    )
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
                                Text('О новом отзыве',
                                    style: TextStyle(
                                        color: AppColors.textColorItem,
                                        fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                                    )),
                                Expanded(
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: SizedBox(
                                          height: SizeUtil.getSize(3.5,GlobalData.sizeScreen!),
                                          child: Switch(onChanged: (bool value) {
                                            setState(() {
                                              _isNewOtziv=value;
                                            });
                                          },
                                              value: _isNewOtziv),
                                        )

                                    )
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
                                Text('О новом комментарии',
                                    style: TextStyle(
                                        color: AppColors.textColorItem,
                                        fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                                    )),
                                Expanded(
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: SizedBox(
                                          height: SizeUtil.getSize(3.5,GlobalData.sizeScreen!),
                                          child: Checkbox(
                                            value: _isNewComment,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                _isNewComment=value!;
                                              });

                                            },),
                                        )

                                    )
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )

                  ],
                )



            ),


            Container(
                margin: EdgeInsets.fromLTRB(0,SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(0.8,GlobalData.sizeScreen!)),
                child:Column(
                  children: [
                    Align(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(SizeUtil.getSize(4.0,GlobalData.sizeScreen!),SizeUtil.getSize(2.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(2.0,GlobalData.sizeScreen!)),
                        child: Text('Изменения настроек',
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
                                Text('Записи',
                                    style: TextStyle(
                                        color: AppColors.textColorItem,
                                        fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                                    )),
                                Expanded(
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: SizedBox(
                                          height: SizeUtil.getSize(3.5,GlobalData.sizeScreen!),
                                          child: Checkbox(
                                            value: _isRecordings,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                _isRecordings=value!;
                                              });

                                            },),
                                        )

                                    )
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
                                Text('Персонала',
                                    style: TextStyle(
                                        color: AppColors.textColorItem,
                                        fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                                    )),
                                Expanded(
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: SizedBox(
                                          height: SizeUtil.getSize(3.5,GlobalData.sizeScreen!),
                                          child: Checkbox(
                                            value: _isStaff,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                _isStaff=value!;
                                              });

                                            },),
                                        )

                                    )
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
                                Text('Скидок',
                                    style: TextStyle(
                                        color: AppColors.textColorItem,
                                        fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                                    )),
                                Expanded(
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: SizedBox(
                                          height: SizeUtil.getSize(3.5,GlobalData.sizeScreen!),
                                          child: Checkbox(
                                            value: _isSale,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                _isSale=value!;
                                              });

                                            },),
                                        )

                                    )
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
                                Text('Прайс-листа',
                                    style: TextStyle(
                                        color: AppColors.textColorItem,
                                        fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                                    )),
                                Expanded(
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: SizedBox(
                                          height: SizeUtil.getSize(3.5,GlobalData.sizeScreen!),
                                          child: Checkbox(
                                            value: _isPriceList,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                _isPriceList=value!;
                                              });

                                            },),
                                        )

                                    )
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
                                Text('Информация об автомойке',
                                    style: TextStyle(
                                        color: AppColors.textColorItem,
                                        fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                                    )),
                                Expanded(
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: SizedBox(
                                          height: SizeUtil.getSize(3.5,GlobalData.sizeScreen!),
                                          child: Checkbox(
                                            value: _isCarwashinformation,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                _isCarwashinformation=value!;
                                              });

                                            },),
                                        )

                                    )
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )

                  ],
                )



            )



          ],



        ),
      ),
    );
  }


 }