


  import 'package:car_wash_admin/utils/size_util.dart';
import 'package:car_wash_admin/utils/time_parser.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../app_colors.dart';
import '../../global_data.dart';

class PageQuickOrderNext extends StatefulWidget{
  @override
  State<PageQuickOrderNext> createState() => _PageQuickOrderNextState();
}

class _PageQuickOrderNextState extends State<PageQuickOrderNext> {
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
                          child: Text('Время',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,
                                fontSize: SizeUtil.getSize(2.8,GlobalData.sizeScreen!)),),
                        ),

                      ],
                    ),
                  ),
                )

              ],
            ),
            _PageTime(),
            _ItemInfoMain()
          ],
        ),
      ),
    );
  }
}

  class _PageTime extends StatefulWidget{
  @override
  State<_PageTime> createState() => _PageTimeState();
}

class _PageTimeState extends State<_PageTime> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SizeUtil.getSize(2.0,GlobalData.sizeScreen!)),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('Время начала',style:
            TextStyle(
              color:  Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
            ),),
          _TimeWindow(),
        ],
      ),
    );
  }
}

  class _TimeWindow extends StatefulWidget{



    @override
    State<_TimeWindow> createState() => _TimeWindowState();

  }

  class _TimeWindowState extends State<_TimeWindow> {
    @override
    Widget build(BuildContext context) {
      return Column(
        children: [
          Row(
            children: [
              Container(child: Text('Часы',textAlign: TextAlign.center,),width:SizeUtil.getSize(12.0,GlobalData.sizeScreen!),),
               Container(child: Text('Минуты',textAlign: TextAlign.center),width: SizeUtil.getSize(12.0,GlobalData.sizeScreen!),),
            ],
          ),
          Container(
            alignment: Alignment.center,
            height: SizeUtil.getSize(6.0,GlobalData.sizeScreen!),
            child: Row(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.colorBackgrondProfile,
                      borderRadius: BorderRadius.circular(SizeUtil.getSize(1.5,GlobalData.sizeScreen!))
                  ),
                  width: SizeUtil.getSize(8.0,GlobalData.sizeScreen!),
                  child: FutureBuilder<List<String>>(
                    future: TimeParser.getListTimeHourStart(),
                    builder: (context,hour){
                      if(hour.hasData){
                        return CarouselSlider(
                          options: CarouselOptions(
                              onPageChanged: (i,j){

                                },
                              initialPage: 0,
                              scrollDirection: Axis.vertical,
                              height:SizeUtil.getSize(8.0,GlobalData.sizeScreen!) ),
                          items: hour.data!.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Text('$i',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: AppColors.textColorPhone,
                                        fontWeight: FontWeight.bold,
                                        fontSize: SizeUtil.getSize(4.0,GlobalData.sizeScreen!)
                                    ));
                              },
                            );
                          }).toList(),
                        );
                      }else{
                        return Text('--',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColors.textColorPhone,
                                fontWeight: FontWeight.bold,
                                fontSize: SizeUtil.getSize(4.0,GlobalData.sizeScreen!)
                            ));
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                  child: Text(
                      ':',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.textColorPhone,
                          fontWeight: FontWeight.bold,
                          fontSize: SizeUtil.getSize(4.0,GlobalData.sizeScreen!)
                      )),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.colorBackgrondProfile,
                      borderRadius: BorderRadius.circular(SizeUtil.getSize(1.5,GlobalData.sizeScreen!))
                  ),
                  width: SizeUtil.getSize(8.0,GlobalData.sizeScreen!),
                  child: FutureBuilder<List<String>>(
                    future: TimeParser.getListTimeMinuteStart(),
                    builder: (comtext,minutes){
                      if(minutes.hasData){
                        return CarouselSlider(
                          options: CarouselOptions(
                              onPageChanged: (i,j){

                              },
                              initialPage: 0,
                              scrollDirection: Axis.vertical,
                              height:SizeUtil.getSize(8.0,GlobalData.sizeScreen!)),
                          items: minutes.data!.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Text('$i',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: AppColors.textColorPhone,
                                        fontWeight: FontWeight.bold,
                                        fontSize: SizeUtil.getSize(4.0,GlobalData.sizeScreen!)
                                    ));
                              },
                            );
                          }).toList(),
                        );
                      }else{
                        return Text('--',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColors.textColorPhone,
                                fontWeight: FontWeight.bold,
                                fontSize: SizeUtil.getSize(4.0,GlobalData.sizeScreen!)
                            ));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }


  class _ItemInfoMain extends StatefulWidget{

    @override
    State<_ItemInfoMain> createState() => _ItemInfoMainState();
  }

  class _ItemInfoMainState extends State<_ItemInfoMain> {
    String _typeCar = 'Седан';
    TextEditingController? numCarController;
    TextEditingController? regionCarController;

    @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Container(
        margin:  EdgeInsets.fromLTRB(0,SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(0.8,GlobalData.sizeScreen!)),
        child: Column(
          children: [
            Container(
              height: SizeUtil.getSize(5,GlobalData.sizeScreen!),
              margin: EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0),
              child: Row(
                children: [
                  SizedBox(
                    child: SvgPicture.asset('assets/ic_calendar.svg'),
                    height: SizeUtil.getSize(2.5,GlobalData.sizeScreen!),),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(SizeUtil.getSize(2.0,GlobalData.sizeScreen!), 0, 0, 0),
                      child: Text('Информация о заказе',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!),
                            color: AppColors.textColorTitle
                        ),),
                    ),
                  ),

                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0, 0),
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding:EdgeInsets.fromLTRB(SizeUtil.getSize(7.5,GlobalData.sizeScreen!),SizeUtil.getSize(2.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                    child: Row(
                      children: [
                        Text('Дата',
                            style: TextStyle(
                                color: AppColors.textColorItem,
                                fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                            )),
                        Expanded(
                          child: Padding(
                            padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                            child: Text('2021-10-09',
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
                  Container(
                      margin: EdgeInsets.fromLTRB(SizeUtil.getSize(7.3,GlobalData.sizeScreen!), 0, 0, 0),
                      height: 1,
                      color: AppColors.colorLine),
                  Container(
                    height: SizeUtil.getSize(5.0,GlobalData.sizeScreen!),
                    child: Padding(
                      padding:EdgeInsets.fromLTRB(SizeUtil.getSize(7.5,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                      child: Row(
                        children: [
                          Text('Тип ТС',
                              style: TextStyle(
                                  color: AppColors.textColorItem,
                                  fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                              )),
                          Expanded(
                            child: Padding(
                              padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                              child:Align(
                                alignment: Alignment.centerRight,
                                child: Text('Седан',
                                  style: TextStyle(color: AppColors.textColorPhone,
                                      fontWeight: FontWeight.bold,
                                      fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)),),
                              ),

                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(SizeUtil.getSize(7.3,GlobalData.sizeScreen!), 0, 0, 0),
                      height: 1,
                      color: AppColors.colorLine),
                  Padding(
                    padding:EdgeInsets.fromLTRB(SizeUtil.getSize(7.5,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                    child: Row(
                      children: [
                        Text('Номер ТС',
                            style: TextStyle(
                                color: AppColors.textColorItem,
                                fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                            )),
                        Expanded(
                          child: Padding(
                              padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SvgPicture.asset('assets/frame.svg'),
                                    SizedBox(width: SizeUtil.getSize(1.5,GlobalData.sizeScreen!),),
                                    Container(
                                      child: Text('WW6766',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                            fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                                        ),),
                                        padding: EdgeInsets.all(SizeUtil.getSize(0.5,GlobalData.sizeScreen!)),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black),
                                            borderRadius: BorderRadius.only(topLeft:Radius.circular(10),bottomLeft: Radius.circular(10),)
                                        )
                                    ),
                                    Container(
                                      child: Text(
                                        '777',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: SizeUtil.getSize(
                                                2.0, GlobalData.sizeScreen!)),
                                      ),
                                      padding: EdgeInsets.all(SizeUtil.getSize(0.5,GlobalData.sizeScreen!)),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.only(topRight:Radius.circular(10),bottomRight: Radius.circular(10),
                                    ))),
                                  ],
                                ),
                              )
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
      );
    }

    @override
    void initState() {
      numCarController=TextEditingController();
      regionCarController=TextEditingController();
      numCarController!.text='A000AA';
      regionCarController!.text='000';
    }
  }
