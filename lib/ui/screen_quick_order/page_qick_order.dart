



  import 'package:car_wash_admin/app_colors.dart';
import 'package:car_wash_admin/domain/model/model_calculate_price.dart';
import 'package:car_wash_admin/domain/model/model_service.dart';
import 'package:car_wash_admin/domain/state/bloc_page_route.dart';
import 'package:car_wash_admin/internal/dependencies/repository_module.dart';
import 'package:car_wash_admin/ui/page_add_order/page_add_order.dart';
import 'package:car_wash_admin/ui/page_add_order/page_list_services.dart';
import 'package:car_wash_admin/ui/screen_quick_order/page_quick_order_next.dart';
import 'package:car_wash_admin/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/svg.dart';

import '../../global_data.dart';



  int _typeCarInt =1;
  String? _dateValue;
  int _totalPriceFinalOfListService=0;
  List<ModelService> _listService=[];
  List<ModelServiceFromCalculate> _calculateList=[];
  late ValueNotifier<ModelCalculatePrice> _notifier;
  Future<ModelCalculatePrice?> _getPrice({required BuildContext context,required int carType,required List<int> servicesIds, required List<int> complexesIds})async{
    _isLoading=true;
    _notifier.value=ModelCalculatePrice(result: true,totalPrice: 0,sale: 0,saleName: 'test',workTime: 0,workTimeWithMultiplier: 0,list: []);
    final result=await RepositoryModule.userRepository().getPrice(context: context, carType: carType, servicesIds: servicesIds, complexesIds: complexesIds);
    _notifier.value=result!;
    _isLoading=false;
    return result;
  }
  List<int> _idServiceList=[];
  List<int> _idComplexList=[];
  bool _isLoading=false;
  Map<String,dynamic> _order={'date':'','post':0,'startTime':'','carType':1,'carNumber':'A000AA',
    'carRegion':000,
    'totalPrice':0,'sale':0,'workTime':0,'ComplexesList':[],
    'ServicesList':[]};


class PageQuickOrder extends StatefulWidget{
  @override
  State<PageQuickOrder> createState() => _PageQuickOrderState();
}

class _PageQuickOrderState extends State<PageQuickOrder> {

  bool _isEndAddOrder=false;

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
                         child: Text('Быстрая запись',
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

           _ItemInfoMain(),
           _ItemListWork(onEdit: (verifi){
             setState(() {
                _isEndAddOrder=verifi!;

              });
           },),
           _ItemPrice(),

           Padding(
             padding: EdgeInsets.all(SizeUtil.getSize(5,GlobalData.sizeScreen!)),
             child: SizedBox(
               width: SizeUtil.getSize(40,GlobalData.sizeScreen!),
             child: RaisedButton(
                 color: _isEndAddOrder?AppColors.colorIndigo:AppColors.colorDisableButton,
                 onPressed: (){
                   if(_isEndAddOrder){
                     Navigator.push(context,SlideTransitionRight(PageQuickOrderNext(
                       onSuccesAdd: (add){
                         if(add!){
                           Navigator.pop(context);
                         }
                       },
                         totalPriceFinalOfListService:_totalPriceFinalOfListService,
                         order:_order,
                         list:_calculateList)));
                   }
                 }, child: Text('Далее',style: TextStyle(
               color: Colors.white
             ),)),
             ),
           ),
         ],
       ),
     ),
   );
  }

  @override
  void initState() {
    super.initState();
    _order.update('date', (value) =>DateTime.now().toString().split(' ')[0]);
    _notifier=ValueNotifier<ModelCalculatePrice>(ModelCalculatePrice(result: true,totalPrice: 0,sale: 0,saleName: 'test',workTime: 0,workTimeWithMultiplier: 0,list: []));
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
                      child: Text('Основная информация',
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
                            child: Text('$_dateValue',
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
                          child: GestureDetector(
                            onTap: (){
                              DatePicker.showDatePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime(2021, 6, 7),
                                  maxTime: DateTime(2025, 6, 7), onChanged: (date) {
                                  }, onConfirm: (date) {
                                    setState(() {
                                      _dateValue=date.toString().split(' ')[0];
                                      _order.update('date', (value) =>_dateValue);
                                    });

                                  },
                                  currentTime: DateTime.now(), locale: LocaleType.ru);
                            },
                            child: Icon(
                              Icons.calendar_today_outlined,
                              color: AppColors.textColorTitle,
                              size: SizeUtil.getSize(2.0,GlobalData.sizeScreen!),
                            ),
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
                                child: DropdownButton<String>(
                                  value: _typeCar,
                                  icon: const Icon(Icons.arrow_drop_down,
                                    color: Colors.black,),
                                  iconSize: 24,
                                  elevation: 16,
                                  alignment: Alignment.centerRight,
                                  style: TextStyle(color: AppColors.textColorPhone,
                                      fontWeight: FontWeight.bold,
                                      fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.transparent,
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _typeCar = newValue!;
                                      if(_typeCar=='Седан'){
                                        _typeCarInt=1;
                                      }else if(_typeCar=='Кроссовер'){
                                        _typeCarInt=2;
                                      }else if(_typeCar=='Внедорожник'){
                                        _typeCarInt=3;
                                      }else if(_typeCar=='Микроавтобус'){
                                        _typeCarInt=4;
                                      }else if(_typeCar=='Иное'){
                                        _typeCarInt=5;
                                      }

                                      _order.update('carType', (value) => _typeCarInt);
                                      if(_listService.length>1){
                                        _getPrice(context: context, carType: _typeCarInt, servicesIds: _idServiceList, complexesIds: _idComplexList);
                                      }

                                    });
                                  },
                                  items: <String>['Седан', 'Кроссовер', 'Внедорожник', 'Микроавтобус','Иное']
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
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
                                    Padding(
                                      padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), SizeUtil.getSize(3.0,GlobalData.sizeScreen!)),
                                      child: SvgPicture.asset('assets/frame.svg'),
                                    ),
                                    Container(
                                      height: SizeUtil.getSize(6.0,GlobalData.sizeScreen!),
                                      width: SizeUtil.getSize(13,GlobalData.sizeScreen!),
                                      child: TextField(
                                        maxLength: 6,
                                        controller: numCarController,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                                        ),
                                        onChanged: (text){
                                          if(text.isNotEmpty){
                                            _order.update('carNumber', (value) => text);
                                          }else{
                                            _order.update('carNumber', (value) => 'A000AA');
                                          }
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(SizeUtil.getSize(0.5,GlobalData.sizeScreen!)),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.only(topLeft:Radius.circular(10),bottomLeft: Radius.circular(10))),

                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: SizeUtil.getSize(6.0,GlobalData.sizeScreen!),
                                      width: SizeUtil.getSize(8,GlobalData.sizeScreen!),
                                      child: TextField(
                                        maxLength: 3,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                                        ),
                                        controller: regionCarController,
                                        onChanged: (text){
                                          if(text.isNotEmpty){
                                            _order.update('carRegion', (value) => text);
                                          }else{
                                            _order.update('carRegion', (value) => '000');
                                          }
                                        },
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(SizeUtil.getSize(0.5,GlobalData.sizeScreen!)),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.only(topRight:Radius.circular(10),bottomRight: Radius.circular(10))),

                                        ),
                                      ),
                                    ),
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
      _dateValue=DateTime.now().toString().split(' ')[0];
      numCarController=TextEditingController();
      regionCarController=TextEditingController();
      numCarController!.text='A000AA';
      regionCarController!.text='000';
    }
  }


  class _ItemListWork extends StatefulWidget{

     var onEdit=(bool? verifi)=>verifi;

    @override
    State<_ItemListWork> createState() => _ItemListWorkState();

     _ItemListWork({required this.onEdit});
}

  class _ItemListWorkState extends State<_ItemListWork> {


    bool _isEdit=false;
    int i=-2;
    bool _loadData=true;

    @override
    Widget build(BuildContext context) {


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
                    child: SvgPicture.asset('assets/ic_list_work.svg'),
                    height: SizeUtil.getSize(2.5,GlobalData.sizeScreen!),),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(SizeUtil.getSize(2.0,GlobalData.sizeScreen!), 0, 0, 0),
                      child: Text('Список работ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!),
                            color: AppColors.textColorTitle
                        ),),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Expanded(
                      child: _listService.length>1?GestureDetector(
                        child: Text(_isEdit?'Отмена':'Править',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!),
                              color: AppColors.colorIndigo
                          ),),
                        onTap: (){
                          setState(() {
                            if(!_isEdit){
                              _isEdit=true;
                            }else{
                              _isEdit=false;
                            }

                          });
                        },
                      ):Container(),
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
                    padding:EdgeInsets.fromLTRB(SizeUtil.getSize(7.5,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                    child: Row(
                      children: [
                        Text('Добавить',
                            style: TextStyle(
                                color: AppColors.textColorItem,
                                fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                            )),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context, SlideTransitionLift(PageListServices(
                                  carType: _typeCarInt,listAlreadySelected: _listService,
                                  onListServices: (list){
                                    setState(() {
                                      _idComplexList.clear();
                                      _idServiceList.clear();
                                      _listService.clear();
                                      _listService.add(ModelService(listServices:[],id: 0, type: 'service', name: 'Въезд-Выезд', isDetailing: false, price: 0, time: 0));
                                      list!.forEach((element) {
                                        if(element.type=='complex'){
                                          _idComplexList.add(element.id);
                                        }else if(element.type=='service'){
                                          _idServiceList.add(element.id);
                                        }
                                        _listService.add(element);

                                      });
                                      _order.update('ComplexesList', (value) => _idComplexList);
                                      _order.update('ServicesList', (value) => _idServiceList);
                                      _getPrice(context: context, carType: _typeCarInt, servicesIds: _idServiceList, complexesIds: _idComplexList);
                                      _onEdit(_listService.length);
                                    });

                                  },)));
                              },
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: AppColors.colorIndigo,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(SizeUtil.getSize(7.3,GlobalData.sizeScreen!), 0, 0, 0),
                      height: 1,
                      color: AppColors.colorLine),

                  ValueListenableBuilder<ModelCalculatePrice>(
                      valueListenable: _notifier,
                      builder: (context,data,widget){
                        _calculateList.clear();
                        _calculateList.add(ModelServiceFromCalculate(id: 0,type: 'test',name: 'Въезд-Выезд',price: 0,oldPrice: 0));
                        if(data.saleName!='test'){
                          data.list.forEach((element) {
                            _calculateList.add(element);
                          });
                        }
                        return Column(
                            children:
                            List.generate(_calculateList.length, (index){
                              return Work(
                                listServices: _listService,
                                i: index,
                                isLoad: _isLoading,
                                modelCalculatePrice:_calculateList[index],
                                modelService: _listService.isNotEmpty?_listService[index]:ModelService(listServices:[],id: 0, type: 'service', name: 'Въезд-Выезд', isDetailing: false, price: 0, time: 0),
                                isEdit:_isEdit,
                                onRemove: (model){
                                  setState(() {
                                    for(int i=0;_listService.length>i;i++){
                                      if(_listService[i].id==model!.id){
                                        _listService.removeAt(i);
                                        break;
                                      }
                                    }
                                    _onEdit(_listService.length);
                                    if(model!.type=='complex'){
                                      for(int i=0;_idComplexList.length>i;i++){
                                        if(_idComplexList[i]==model.id){
                                          _idComplexList.removeAt(i);
                                          break;
                                        }
                                      }
                                    }else if(model.type=='service'){
                                      for(int i=0;_idServiceList.length>i;i++){
                                        if(_idServiceList[i]==model.id){
                                          _idServiceList.removeAt(i);
                                          break;
                                        }
                                      }
                                    }
                                    _order.update('ComplexesList', (value) => _idComplexList);
                                    _order.update('ServicesList', (value) => _idServiceList);
                                    _getPrice(context: context, carType: _typeCarInt, servicesIds: _idServiceList, complexesIds: _idComplexList);
                                    _onEdit(_listService.length);
                                    if(_calculateList.length==2){
                                      _isEdit=false;

                                    }

                                  });
                                },);
                            })

                        );


                      }
                  )


                ],
              ),
            ),
          ],
        ),
      );
    }

    _onEdit(int length){
      if(length>1){
        widget.onEdit(true);
      }else{
        widget.onEdit(false);
      }
    }

    @override
    void initState() {
      super.initState();

    }


  }


  class _ItemPrice extends StatefulWidget{



    @override
    State<_ItemPrice> createState() => _ItemPriceState();
  }

  class _ItemPriceState extends State<_ItemPrice> {

     late TextEditingController _textEditingController;
     late FocusNode _focusNode;
     String _finalPrice='';

    @override
    Widget build(BuildContext context) {

      return Container(
        margin:  EdgeInsets.fromLTRB(0,SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(0.8,GlobalData.sizeScreen!)),
        child: ValueListenableBuilder<ModelCalculatePrice>(
            valueListenable: _notifier,
            builder: (context,snapshot,widget) {
              if(snapshot!=null){
                _totalPriceFinalOfListService=snapshot.totalPrice;
                _order.update('totalPrice', (value) => snapshot.totalPrice);
                _order.update('sale', (value) => snapshot.sale);
                _order.update('workTime', (value) => snapshot.workTime);
                _finalPrice= (snapshot.totalPrice).toString();
              }
              return Column(
                children: [
                  Container(
                    height: SizeUtil.getSize(5,GlobalData.sizeScreen!),
                    margin: EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0),
                    child: Row(
                      children: [
                        SizedBox(
                          child: SvgPicture.asset('assets/ic_price.svg'),
                          height: SizeUtil.getSize(2.5,GlobalData.sizeScreen!),),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(SizeUtil.getSize(2.0,GlobalData.sizeScreen!), 0, 0, 0),
                            child: Text('Стоимость',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!),
                                  color: AppColors.textColorTitle
                              ),),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Expanded(
                            child: _listService.length>1?GestureDetector(
                              child: Text('Править',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!),
                                    color: AppColors.colorIndigo
                                ),),
                              onTap: (){
                                setState(() {
                                  _focusNode.requestFocus();

                                });
                              },
                            ):Container(),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0, 0),
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
                                    child: !_isLoading?Text('${snapshot.totalPrice} RUB',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: AppColors.textColorPhone,
                                            fontWeight: FontWeight.bold,
                                            fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                                        )):Align(
                                      alignment: Alignment.centerRight,
                                      child: SizedBox(
                                        height: SizeUtil.getSize(
                                            2.0,
                                            GlobalData.sizeScreen!),
                                        width: SizeUtil.getSize(
                                            2.0,
                                            GlobalData.sizeScreen!),
                                        child: CircularProgressIndicator(
                                          color: AppColors.colorIndigo,
                                          strokeWidth: SizeUtil.getSize(
                                              0.3,
                                              GlobalData.sizeScreen!),
                                        ),
                                      ),
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
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
                                  child: !_isLoading?Text('${snapshot.sale} RUB',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          color: AppColors.textColorPhone,
                                          fontWeight: FontWeight.bold,
                                          fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                                      )):Align(
                                    alignment: Alignment.centerRight,
                                    child: SizedBox(
                                      height: SizeUtil.getSize(
                                          2.0,
                                          GlobalData.sizeScreen!),
                                      width: SizeUtil.getSize(
                                          2.0,
                                          GlobalData.sizeScreen!),
                                      child: CircularProgressIndicator(
                                        color: AppColors.colorIndigo,
                                        strokeWidth: SizeUtil.getSize(
                                            0.3,
                                            GlobalData.sizeScreen!),
                                      ),
                                    ),
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
                          padding:EdgeInsets.fromLTRB(SizeUtil.getSize(7.5,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                          child: Row(
                            children: [
                              Text('Итого:',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: SizeUtil.getSize(2.3,GlobalData.sizeScreen!)
                                  )),
                              Expanded(
                                child: !_isLoading?
                                TextField(
                                  keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: _finalPrice,
                                        hintStyle: TextStyle(
                                            color: AppColors.textColorPhone,
                                            fontWeight: FontWeight.bold,
                                            fontSize: SizeUtil.getSize(2.3,GlobalData.sizeScreen!)
                                        ),
                                        contentPadding: EdgeInsets.all(
                                            SizeUtil.getSize(
                                                1.5,
                                                GlobalData
                                                    .sizeScreen!)),
                                        border: InputBorder.none),
                                    onChanged: (text) {
                                      if (text.isNotEmpty) {
                                        _order.update('totalPrice', (value) => int.parse(text));
                                      }else{
                                        _order.update('totalPrice', (value) => _finalPrice);
                                      }
                                    },
                                  controller: _textEditingController,
                                   focusNode: _focusNode,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        color: AppColors.textColorPhone,
                                        fontWeight: FontWeight.bold,
                                        fontSize: SizeUtil.getSize(2.3,GlobalData.sizeScreen!)
                                    )):Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(2.3,GlobalData.sizeScreen!), 0),
                                      child: Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                      height: SizeUtil.getSize(
                                          2.0,
                                          GlobalData.sizeScreen!),
                                      width: SizeUtil.getSize(
                                          2.0,
                                          GlobalData.sizeScreen!),
                                      child: CircularProgressIndicator(
                                        color: AppColors.colorIndigo,
                                        strokeWidth: SizeUtil.getSize(
                                            0.3,
                                            GlobalData.sizeScreen!),
                                      ),
                                  ),
                                ),
                                    ),
                              ),
                              Padding(
                                padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(
                                    2.0,
                                    GlobalData.sizeScreen!), 0),
                                child: Text('RUB',
                                    style: TextStyle(
                                        color: AppColors.textColorPhone,
                                        fontWeight: FontWeight.bold,
                                        fontSize: SizeUtil.getSize(2.3,GlobalData.sizeScreen!)
                                    )),
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
              );
            }
        ),
      );
    }


    @override
    void dispose() {
      super.dispose();
      _textEditingController.dispose();
      _focusNode.dispose();
    }

    @override
    void initState() {
      super.initState();
     _focusNode=FocusNode();
     _textEditingController=TextEditingController();
    }


  }
