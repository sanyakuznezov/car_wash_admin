


  import 'dart:async';

import 'package:car_wash_admin/domain/model/model_calculate_price.dart';
import 'package:car_wash_admin/domain/model/model_service.dart';
import 'package:car_wash_admin/domain/model/model_time.dart';
import 'package:car_wash_admin/internal/dependencies/repository_module.dart';
import 'package:car_wash_admin/utils/size_util.dart';
import 'package:car_wash_admin/utils/time_parser.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../app_colors.dart';
import '../../global_data.dart';

  late ValueNotifier<int> _notifierTime;
   String _hour='';
   String _min='';
class PageQuickOrderNext extends StatefulWidget{
  final List<ModelServiceFromCalculate> list;
 final Map<String,dynamic> order;
 final int totalPriceFinalOfListService;
 bool isClose=false;
 var onSuccesAdd=(bool? add)=>add;


  PageQuickOrderNext({required this.onSuccesAdd,required this.totalPriceFinalOfListService,required this.order,required this.list});

  @override
  State<PageQuickOrderNext> createState() => _PageQuickOrderNextState();
}

class _PageQuickOrderNextState extends State<PageQuickOrderNext> {

  bool _isSuccesSendOrder=false;


  @override
  Widget build(BuildContext context) {
    if(_isSuccesSendOrder){
      Timer.periodic(Duration(seconds: 1), (timer) {
        Navigator.pop(context);
        widget.onSuccesAdd(true);
        timer.cancel();
      });
    }

    return Scaffold(
      backgroundColor: AppColors.colorBackgrondProfile,
      appBar:             AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Container(
            width: MediaQuery.of(context).size.width,
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
      body: SingleChildScrollView(
        child: !_isSuccesSendOrder?Column(
          children: [
            _PageTime(order: widget.order),
            _ItemInfoMain(order: widget.order),
            _ListService(modelServiceList: widget.list),
            _ItemPrice(
              order: widget.order,
                priceTotal: widget.totalPriceFinalOfListService),
            Padding(
              padding:_isSuccesSendOrder?EdgeInsets.all(SizeUtil.getSize(3.0,GlobalData.sizeScreen!)):EdgeInsets.fromLTRB(0,  SizeUtil.getSize(5,GlobalData.sizeScreen!), 0, SizeUtil.getSize(5,GlobalData.sizeScreen!)),
              child: SizedBox(
                width: SizeUtil.getSize(40,GlobalData.sizeScreen!),
                child: RaisedButton(
                    color: AppColors.colorIndigo,
                    onPressed: (){
                      if(_hour.isNotEmpty&&_min.isNotEmpty){
                        widget.order.update('startTime', (val) => TimeParser.parseHourForTimeLine('$_hour:$_min'));
                        _sendOrder(context,widget.order);
                      }

                    }, child: Text('Записать',style: TextStyle(
                    color: Colors.white
                ),)) ),
            )
          ],
        ):Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Icon(Icons.check_circle_outline_outlined,color: Colors.green,size: SizeUtil.getSize(10,GlobalData.sizeScreen!),),
          Padding(
            padding: EdgeInsets.all(SizeUtil.getSize(1.5,GlobalData.sizeScreen!)),
            child: Text('Заказ создан!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,
                    fontSize: SizeUtil.getSize(2.8,GlobalData.sizeScreen!))),
          ),

            ],
          ),
        )

      ),
    );
  }
  
   //Отправка заказа на сервер
   Future<void>_sendOrder(BuildContext context,Map<String,dynamic> map)async{
     _showLoaderDialog(context);
      final result=await RepositoryModule.userRepository().addQuickOrder(context: context, map: map);
       if(result==null){
         Navigator.of(context, rootNavigator: true).pop('dialog');
         Fluttertoast.showToast(
             msg: "Ошибка сервера",
             toastLength: Toast.LENGTH_SHORT,
             gravity: ToastGravity.CENTER,
             timeInSecForIosWeb: 3,
             backgroundColor: Colors.white,
             textColor: Colors.black,
             fontSize: 16.0
         );
       }
      if(result!){
        setState(() {
          _isSuccesSendOrder=true;
          Navigator.of(context, rootNavigator: true).pop('dialog');
        });

      }

   }

  _showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Image.asset(
        "assets/car_wash.gif",
        height: SizeUtil.getSize(8, GlobalData.sizeScreen!),
        width: SizeUtil.getSize(8, GlobalData.sizeScreen!),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _notifierTime=ValueNotifier<int>(0);
    _hour='';
    _min='';
  }
}

  class _PageTime extends StatelessWidget{

   Map order;

   _PageTime({required this.order});

  @override
  Widget build(BuildContext context) {
   return Container(
     padding: EdgeInsets.all(SizeUtil.getSize(2.0,GlobalData.sizeScreen!)),
     color: Colors.white,
     child: Column(
       children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
             Text('Время начала',style:
             TextStyle(
                 color:  Colors.black,
                 fontWeight: FontWeight.bold,
                 fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
             ),),
             _TimeWindow(order: order),
           ],
         ),
         Padding(
           padding: EdgeInsets.fromLTRB(0, SizeUtil.getSize(4.0,GlobalData.sizeScreen!), 0,
               SizeUtil.getSize(1.8,GlobalData.sizeScreen!)),
           child: Container(
             height: 1,
             color: AppColors.colorLine,
           ),
         ),
         Row(
           children: [
             Text('Продолжительность заказа:',
                 style: TextStyle(
                     color: AppColors.textColorItem,
                     fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                 )),
             Spacer(),
             Text('${order['workTime']} мин.',
               style:
               TextStyle(
                   color:  AppColors.textColorPhone,
                   fontWeight: FontWeight.bold,
                   fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
               ),),

           ],
         )
       ],
     ),
   );
  }

}



  class _TimeWindow extends StatefulWidget{

    Map order;

    @override
    State<_TimeWindow> createState() => _TimeWindowState();

    _TimeWindow({required this.order});
}

  class _TimeWindowState extends State<_TimeWindow> {

    int i=0;
    late ValueNotifier<int> _notifier;
    late int _isLoad;
    CarouselController _carouselController=CarouselController();



    @override
    Widget build(BuildContext context) {
      _isLoad=0;
      return FutureBuilder<ModelTime>(
        future: RepositoryModule.userRepository().getListTimes(context: context, date: widget.order['date'], workTimeMin: widget.order['workTime'], considerLeftTime: false),
        builder: (context,data) {
          if(data.connectionState.index==3){
            if(data.hasData){
              _isLoad=2;
              _hour=data.data!.hour[0];
              _min=data.data!.minutes[0][0];
            }else{
              _isLoad=1;
            }
          }

          if(data.hasError){
            _isLoad=1;
          }

          return Column(
            children: [
              Row(
                children: [
                  Container(child: Text('Часы', textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: SizeUtil.getSize(1.5, GlobalData.sizeScreen!)
                    ),),
                    width: SizeUtil.getSize(12.0, GlobalData.sizeScreen!),),
                  Container(child: Text('Минуты', textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: SizeUtil.getSize(1.5, GlobalData.sizeScreen!)
                    ),),
                    width: SizeUtil.getSize(12.0, GlobalData.sizeScreen!),),
                ],
              ),
              Container(
                alignment: Alignment.center,
                height: SizeUtil.getSize(6.0, GlobalData.sizeScreen!),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.colorBackgrondProfile,
                          borderRadius: BorderRadius.circular(
                              SizeUtil.getSize(1.5, GlobalData.sizeScreen!))
                      ),
                      width: SizeUtil.getSize(8.0, GlobalData.sizeScreen!),
                      child: _isLoad==2?CarouselSlider(
                        options: CarouselOptions(
                            onPageChanged: (i, j) {
                              _carouselController.jumpToPage(0);
                              _hour = data.data!.hour[i];
                              _notifier.value = i;
                              },
                            initialPage: 0,
                            scrollDirection: Axis.vertical,
                            height: SizeUtil.getSize(
                                8.0, GlobalData.sizeScreen!)),
                        items: data.data!.hour.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Text('$i',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: AppColors.textColorPhone,
                                      fontWeight: FontWeight.bold,
                                      fontSize: SizeUtil.getSize(
                                          4.0, GlobalData.sizeScreen!)
                                  ));
                            },
                          );
                        }).toList(),

                      ):_isLoad==0?Center(
                        child: SizedBox(
                          height: SizeUtil.getSize(
                              2.0, GlobalData.sizeScreen!),
                          width:  SizeUtil.getSize(
                              2.0, GlobalData.sizeScreen!),
                          child: CircularProgressIndicator(color: AppColors.textColorHint,strokeWidth: 1,),
                        ),
                      ):_isLoad==1?Center(
                        child: SizedBox(
                            height: SizeUtil.getSize(
                                4.0, GlobalData.sizeScreen!),
                            width:  SizeUtil.getSize(
                                4.0, GlobalData.sizeScreen!),
                            child: Icon(Icons.error_outline_outlined)),
                      ):Container()
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                          SizeUtil.getSize(1.0, GlobalData.sizeScreen!)),
                      child: Text(
                          ':',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.textColorPhone,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeUtil.getSize(
                                  4.0, GlobalData.sizeScreen!)
                          )),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.colorBackgrondProfile,
                          borderRadius: BorderRadius.circular(
                              SizeUtil.getSize(1.5, GlobalData.sizeScreen!))
                      ),
                      width: SizeUtil.getSize(8.0, GlobalData.sizeScreen!),
                      child: ValueListenableBuilder<int>(
                        valueListenable: _notifier,
                        builder: (context, index, widget) {
                          if(data.hasData&&data.data!.minutes.isNotEmpty){
                            _min = data.data!.minutes[index][0];

                          }
                          return _isLoad==2?CarouselSlider(
                            carouselController: _carouselController,
                              options: CarouselOptions(
                                  enableInfiniteScroll: true,
                                  onPageChanged: (i, j) {
                                   _min = data.data!.minutes[index][i];
                                  },
                                  initialPage: 0,
                                  scrollDirection: Axis.vertical,
                                  height: SizeUtil.getSize(
                                      8.0, GlobalData.sizeScreen!)),
                              items: _getMinutes(index, data.data!).map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Text('$i',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: AppColors.textColorPhone,
                                            fontWeight: FontWeight.bold,
                                            fontSize: SizeUtil.getSize(
                                                4.0, GlobalData.sizeScreen!)
                                        ));
                                  },
                                );
                                    }).toList())
                                : _isLoad == 0
                                    ? Center(
                                        child: SizedBox(
                                          height: SizeUtil.getSize(
                                              2.0, GlobalData.sizeScreen!),
                                          width: SizeUtil.getSize(
                                              2.0, GlobalData.sizeScreen!),
                                          child: CircularProgressIndicator(
                                            color: AppColors.textColorHint,
                                            strokeWidth: 1,
                                          ),
                                        ),
                                      )
                                    : _isLoad == 1
                                        ? Center(
                                            child: SizedBox(
                                                height: SizeUtil.getSize(4.0,
                                                    GlobalData.sizeScreen!),
                                                width: SizeUtil.getSize(4.0,
                                                    GlobalData.sizeScreen!),
                                                child: Icon(Icons
                                                    .error_outline_outlined)),
                                          )
                                        : Container();
                          }
                      ),
                    ),
                  ],
                ),
              ),
              _isLoad == 1?SizedBox(height: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)):Container(),
              _isLoad == 1?Text('Нет доступного времени',style:
                TextStyle(
                    fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!),
                  color: Colors.redAccent
                ),):Container()
            ],
          );
        }
      );
    }

    //В зависимости от выбранного часа показать минуты
    List<dynamic>_getMinutes(int index,ModelTime modelTime){
      return modelTime.minutes[index];
    }

    @override
  void initState() {
   super.initState();
   _notifier=ValueNotifier<int>(0);
  }
}


  class _ItemInfoMain extends StatefulWidget{


    Map order;

    @override
    State<_ItemInfoMain> createState() => _ItemInfoMainState();

    _ItemInfoMain({required this.order});
}

  class _ItemInfoMainState extends State<_ItemInfoMain> {
    String _typeCar = 'Седан';
    TextEditingController? numCarController;
    TextEditingController? regionCarController;

    @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Container(
        margin:  EdgeInsets.fromLTRB(0,SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0,0),
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
                            child: Text('${widget.order['date']}',
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
                                child: Text('${_carType(widget.order['carType'])}',
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
                                      child: Text('${widget.order['carNumber']}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                            fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                                        ),),
                                        padding: EdgeInsets.all(SizeUtil.getSize(0.5,GlobalData.sizeScreen!)),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black),
                                            borderRadius: BorderRadius.only(topLeft:Radius.circular(10),bottomLeft: Radius.circular(10),)
                                        )
                                    ),
                                    Container(
                                      child: Text(
                                        widget.order['carRegion']==0?'000':'${widget.order['carRegion']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: SizeUtil.getSize(
                                                1.8, GlobalData.sizeScreen!)),
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
                  Container(
                      margin: EdgeInsets.fromLTRB(SizeUtil.getSize(7.3,GlobalData.sizeScreen!), 0, 0, 0),
                      height: 1,
                      color: AppColors.colorLine),
                ],
              ),
            )

          ],
        ),
      );
    }

    _carType(int type){
      if(type==1){
        return 'Седан';
      }else if(type==2){
        return 'Кроссовер';
      }else if(type==3){
        return 'Внедорожник';
      }else if(type==4){
        return 'Микроавтобус';
      }else if(type==5){
        return 'Иное';

      }
    }

    @override
    void initState() {
      numCarController=TextEditingController();
      regionCarController=TextEditingController();
      numCarController!.text='A000AA';
      regionCarController!.text='000';
    }
  }


  class _ItemPrice extends StatefulWidget{

    int priceTotal;
    Map order;

    @override
    State<_ItemPrice> createState() => _ItemPriceState();

    _ItemPrice({required this.order,required this.priceTotal});
}

  class _ItemPriceState extends State<_ItemPrice> {



    @override
    Widget build(BuildContext context) {
      return Container(
        child:Column(
          children: [
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding:EdgeInsets.fromLTRB(SizeUtil.getSize(7.5,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                    child: Row(
                      children: [
                        Text('Всего',
                            style: TextStyle(
                                color: AppColors.textColorItem,
                                fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                            )),
                        Expanded(
                          child: Padding(
                              padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                              child: Text('${widget.priceTotal} RUB',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: AppColors.textColorPhone,
                                      fontWeight: FontWeight.bold,
                                      fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                                  )
                              )
                          ),
                        ),
                      ],
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
                        Text('Скидка',
                            style: TextStyle(
                                color: AppColors.textColorItem,
                                fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                            )),
                        Expanded(
                          child: Padding(
                            padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                            child: Text('${widget.order['sale']} RUB',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: AppColors.textColorPhone,
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                                )
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  Container(
                      height: 1,
                      color: AppColors.colorLine),

                  Padding(
                    padding:EdgeInsets.fromLTRB(SizeUtil.getSize(7.5,GlobalData.sizeScreen!),SizeUtil.getSize(2.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(2.0,GlobalData.sizeScreen!)),
                    child: Row(
                      children: [
                        Text('Итого:',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                            )),
                        Expanded(
                          child: Padding(
                            padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                            child: Text('${widget.order['totalPrice']} RUB',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: AppColors.textColorPhone,
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                                )
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  Container(
                      height: 1,
                      color: AppColors.colorLine),

                ],
              ),
            ),
          ],
        )
      );
    }


    @override
    void dispose() {
      super.dispose();
    }

    @override
    void initState() {
      super.initState();
    }


  }


  class _ListService extends StatefulWidget{
    final  List<ModelServiceFromCalculate> modelServiceList;


    _ListService({required this.modelServiceList});

    @override
  State<_ListService> createState() => _ListServiceState();
}

class _ListServiceState extends State<_ListService> {
  @override
  Widget build(BuildContext context) {
    return Column(

      children: List.generate(widget.modelServiceList.length, (index){
          return index>0?_ItemListServise(modelService: widget.modelServiceList[index]):Container();
      }),
    );
  }
}


   class _ItemListServise extends StatefulWidget{

   final  ModelServiceFromCalculate modelService;

  @override
  State<_ItemListServise> createState() => _ItemListServiseState();

     _ItemListServise({required this.modelService});
}

class _ItemListServiseState extends State<_ItemListServise> {
  @override
  Widget build(BuildContext context) {
   return Container(
     color: Colors.white,
     child: Column(
       children: [
         Padding(
           padding:EdgeInsets.fromLTRB(SizeUtil.getSize(7.5,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
           child: Row(
             children: [
               Text(widget.modelService.name,
                   style: TextStyle(
                       color: AppColors.textColorItem,
                       fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                   )),
               Expanded(
                 child: Padding(
                   padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                   child: Text('${widget.modelService.price} RUB',
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
       ],
     ),
   );
  }
}
