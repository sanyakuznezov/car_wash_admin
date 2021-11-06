


  import 'package:car_wash_admin/domain/model/model_calculate_price.dart';
import 'package:car_wash_admin/domain/model/model_service.dart';
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

 final List<ModelService> list;
 final Map<String,dynamic> order;
 final int totalPriceFinalOfListService;


  PageQuickOrderNext({required this.totalPriceFinalOfListService,required this.order,required this.list});

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
            _ItemInfoMain(order: widget.order),
            _ListService(modelServiceList: widget.list),
            _ItemPrice(
              order: widget.order,
                priceTotal: widget.totalPriceFinalOfListService),
            Padding(
              padding:EdgeInsets.fromLTRB(0,  SizeUtil.getSize(10,GlobalData.sizeScreen!), 0, 0),
              child: SizedBox(
                width: SizeUtil.getSize(40,GlobalData.sizeScreen!),
                child: RaisedButton(
                    color: AppColors.colorIndigo,
                    onPressed: (){

                    }, child: Text('Записать',style: TextStyle(
                    color: Colors.white
                ),)),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print('Data ${widget.order['date']} carType ${widget.order['carType']} '
        'carNumber ${widget.order['carNumber']}'
    'carRegion ${widget.order['carRegion']} totalPrice ${widget.order['totalPrice']}'
        'sale ${widget.order['sale']} workTime ${widget.order['workTime']} ComplexesList ${widget.order['ComplexesList']}'
        'ServicesList ${widget.order['ServicesList']}');
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
              Container(child: Text('Часы',textAlign: TextAlign.center,
              style: TextStyle(
                fontSize:SizeUtil.getSize(1.5,GlobalData.sizeScreen!)
              ),),width:SizeUtil.getSize(12.0,GlobalData.sizeScreen!),),
               Container(child: Text('Минуты',textAlign: TextAlign.center,
                 style: TextStyle(
                     fontSize:SizeUtil.getSize(1.5,GlobalData.sizeScreen!)
                 ),),width: SizeUtil.getSize(12.0,GlobalData.sizeScreen!),),
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
    final  List<ModelService> modelServiceList;


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

   final  ModelService modelService;

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