





   import 'package:car_wash_admin/domain/model/model_sale.dart';
import 'package:car_wash_admin/domain/model/model_service.dart';
import 'package:car_wash_admin/domain/state/bloc_page_route.dart';
import 'package:car_wash_admin/internal/dependencies/repository_module.dart';
import 'package:car_wash_admin/ui/screen_information/page_search_services.dart';
import 'package:car_wash_admin/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../app_colors.dart';
import '../../global_data.dart';


   bool _isLoading=true;
   bool _isLoading_1=true;
   List<ModelService> _mainList=[];
   List<ModelSale> _mainList_1=[];

class ScreenInfo extends StatefulWidget{
  @override
  State<ScreenInfo> createState() => _ScreenInfoState();
}

class _ScreenInfoState extends State<ScreenInfo> with SingleTickerProviderStateMixin{


  int _index=0;
  int _carType=1;
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
   return DefaultTabController(
     initialIndex: 0,
     length: 2,
     child: Scaffold(
       backgroundColor: AppColors.colorBackgrondProfile,
       appBar: AppBar(
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
                       onTap: () {
                         Navigator.pop(context);

                       },
                       child: Icon(
                         Icons.arrow_back_ios,
                         color: AppColors.colorIndigo,
                       ),
                     ),
                   ),
                   Expanded(
                     child: Text(
                       'Информация',
                       textAlign: TextAlign.center,
                       style: TextStyle(
                           color: Colors.black,
                           fontWeight: FontWeight.bold,
                           fontSize: SizeUtil.getSize(
                               2.8, GlobalData.sizeScreen!)),
                     ),
                   ),
                    _mainList.length!=0&&_index==0?Align(alignment: Alignment.centerRight,
                     child: GestureDetector(
                       onTap:(){
                         Navigator.push(
                           context,
                           SlideTransitionRight(PageSearchServices(mainList:_mainList)),
                         );
                       },
                       child: Icon(Icons.search,color: AppColors.colorIndigo),
                     ),
                   ):Container()

                 ],
               ),
             ),
           )
         ],
         bottom: TabBar(
           controller: _tabController,
             onTap: (index) {
               setState(() {
                 _index=index;
               });
             },
            labelColor: Colors.black,
             tabs: [
           Tab(
             text: 'Услуги',

           ),
           Tab(
             text: 'Акции',
           )
         ]),
       ),
       body: TabBarView(
         controller: _tabController,
         children: [
         PageServices(onLoad: (load,carType){
           setState(() {
              _carType=carType;
           });
         },),
       PageSale(carType: _carType)
       ],

       ),
     ),
   );
  }

  @override
  void dispose() {
    super.dispose();
    //_tabController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length:2);
    _tabController.addListener(() {
      setState(() {
        _index=_tabController.index;
      });

    });
  }
}


  class PageServices extends StatefulWidget{

   var onLoad=(bool? load,int carType)=>load,carType;

  @override
  State<PageServices> createState() => _PageServicesState();

   PageServices({required this.onLoad});
}




 class _PageServicesState extends State<PageServices> {

   bool _isSwithSearch=false;
   int _selType=0;
   int _selVid=0;
   bool _isDetailing=false;
   int _serviceType=2;
   int _carType=1;
   late String _typeCar='Седан';




  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (!_isSwithSearch) Container(
              padding: EdgeInsets.all(SizeUtil.getSize(
                  2.8, GlobalData.sizeScreen!)),
              color: AppColors.color120,
              child: Wrap(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Align(
                            child: Text('Фильтры',style: TextStyle(color: AppColors.colorText22,
                                fontSize: SizeUtil.getSize(
                                    2.2, GlobalData.sizeScreen!))),
                            alignment: Alignment.centerLeft,),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      _isSwithSearch=true;
                                    });
                                  },
                                  child: Icon(Icons.remove,color: AppColors.colorIndigo)),),
                          )
                        ],
                      ),
                      Align(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(SizeUtil.getSize(1.5, GlobalData.sizeScreen!),SizeUtil.getSize(1.5, GlobalData.sizeScreen!),0,0),
                          child: Text('Тип',style: TextStyle(color: AppColors.textColorHint,
                              fontSize: SizeUtil.getSize(
                                  2.0, GlobalData.sizeScreen!))),
                        ),
                        alignment: Alignment.centerLeft,),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                _selType=0;
                                _isDetailing=false;
                                _getServiceInfo(context: context, carType:_carType, serviceType:_serviceType, isDetailing:_isDetailing, query:'');
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.all(SizeUtil.getSize(
                                  0.5, GlobalData.sizeScreen!)),
                              padding: EdgeInsets.all(SizeUtil.getSize(
                                  1.5, GlobalData.sizeScreen!)),
                              alignment: Alignment.center,
                              width: SizeUtil.getSize(
                                  15.0, GlobalData.sizeScreen!),
                              decoration: BoxDecoration(
                                  color: _selType==0?AppColors.colorIndigo:Colors.white,
                                  border: _selType==1?Border.all(width: 1,color: AppColors.textColorPhone):null,
                                  borderRadius: BorderRadius.circular(SizeUtil.getSize(
                                      1.5, GlobalData.sizeScreen!))
                              ),
                              child: Text(
                                'Мойка',
                                style: TextStyle(
                                    color:_selType==0?Colors.white:AppColors.textColorPhone
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                _selType=1;
                                _isDetailing=true;
                                _getServiceInfo(context: context, carType:_carType, serviceType:_serviceType, isDetailing:_isDetailing, query:'');
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.all(SizeUtil.getSize(
                                  0.5, GlobalData.sizeScreen!)),
                              padding: EdgeInsets.all(SizeUtil.getSize(
                                  1.5, GlobalData.sizeScreen!)),
                              alignment: Alignment.center,
                              width: SizeUtil.getSize(
                                  15.5, GlobalData.sizeScreen!),
                              decoration: BoxDecoration(
                                  color: _selType==1?AppColors.colorIndigo:Colors.white,
                                  border: _selType==0?Border.all(width: 1,color: AppColors.textColorPhone):null,
                                  borderRadius: BorderRadius.circular(SizeUtil.getSize(
                                      1.5, GlobalData.sizeScreen!))
                              ),
                              child: Text(
                                'Дитейлинг',
                                style: TextStyle(
                                    color:_selType==1?Colors.white:AppColors.textColorPhone
                                ),
                              ),
                            ),
                          )

                        ],
                      ),
                      Align(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(SizeUtil.getSize(1.5, GlobalData.sizeScreen!),SizeUtil.getSize(1.0, GlobalData.sizeScreen!),0,0),
                          child: Text('Вид',style: TextStyle(color: AppColors.textColorHint,
                              fontSize: SizeUtil.getSize(
                                  2.0, GlobalData.sizeScreen!))),
                        ),
                        alignment: Alignment.centerLeft,),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                _selVid=0;
                                _serviceType=2;
                                _getServiceInfo(context: context, carType:_carType, serviceType:_serviceType, isDetailing:_isDetailing, query:'');
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.all(SizeUtil.getSize(
                                  0.5, GlobalData.sizeScreen!)),
                              padding: EdgeInsets.all(SizeUtil.getSize(
                                  1.5, GlobalData.sizeScreen!)),
                              alignment: Alignment.center,
                              width: SizeUtil.getSize(
                                  15.0, GlobalData.sizeScreen!),
                              decoration: BoxDecoration(
                                  color: _selVid==0?AppColors.colorIndigo:Colors.white,
                                  border: _selVid==1?Border.all(width: 1,color: AppColors.textColorPhone):null,
                                  borderRadius: BorderRadius.circular(SizeUtil.getSize(
                                      1.5, GlobalData.sizeScreen!))
                              ),
                              child: Text(
                                'Комплекс',
                                style: TextStyle(
                                    color:_selVid==0?Colors.white:AppColors.textColorPhone
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                _selVid=1;
                                _serviceType=1;
                                _getServiceInfo(context: context, carType:_carType, serviceType:_serviceType, isDetailing:_isDetailing, query:'');
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.all(SizeUtil.getSize(
                                  1.5, GlobalData.sizeScreen!)),
                              padding: EdgeInsets.all(SizeUtil.getSize(
                                  1.5, GlobalData.sizeScreen!)),
                              alignment: Alignment.center,
                              width: SizeUtil.getSize(
                                  15.0, GlobalData.sizeScreen!),
                              decoration: BoxDecoration(
                                  color: _selVid==1?AppColors.colorIndigo:Colors.white,
                                  border: _selVid==0?Border.all(width: 1,color: AppColors.textColorPhone):null,
                                  borderRadius: BorderRadius.circular(SizeUtil.getSize(
                                      1.5, GlobalData.sizeScreen!))
                              ),
                              child: Text(
                                'Услуга',
                                style: TextStyle(
                                    color:_selVid==1?Colors.white:AppColors.textColorPhone
                                ),
                              ),
                            ),
                          )

                        ],
                      ),
                      Padding(
                        padding:EdgeInsets.fromLTRB(SizeUtil.getSize(1.5, GlobalData.sizeScreen!),SizeUtil.getSize(1.0, GlobalData.sizeScreen!),0,0),
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
                                    elevation: 1,
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
                                          _carType=1;
                                        }else if(_typeCar=='Кроссовер'){
                                          _carType=2;
                                        }else if(_typeCar=='Внедорожник'){
                                          _carType=3;
                                        }else if(_typeCar=='Микроавтобус'){
                                          _carType=4;
                                        }else if(_typeCar=='Иное'){
                                          _carType=5;
                                        }
                                        _getServiceInfo(context: context, carType:_carType, serviceType:_serviceType, isDetailing:_isDetailing, query:'');

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
                      )
                    ],
                  ),


                ],
              )) else Container(
            height: SizeUtil.getSize(
                8, GlobalData.sizeScreen!),
            color: Colors.white,
            child: Stack(
                children:[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:EdgeInsets.all(SizeUtil.getSize(
                          1.5, GlobalData.sizeScreen!)),
                      child:
                      Text('${_getType(_carType)}; ${_getTypeSer(_selType)}; ${_getTypeVid(_selVid)}',
                        style: TextStyle(
                            color: AppColors.textColorHint,
                            fontWeight: FontWeight.bold,
                            fontSize: SizeUtil.getSize(1.8,
                                GlobalData.sizeScreen!)),
                      ),),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: (){
                          setState(() {
                            _isSwithSearch=false;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(SizeUtil.getSize(
                              1.0, GlobalData.sizeScreen!),SizeUtil.getSize(
                              1.0, GlobalData.sizeScreen!),SizeUtil.getSize(
                              2.0, GlobalData.sizeScreen!),SizeUtil.getSize(
                              1.0, GlobalData.sizeScreen!)),
                          child: Icon(Icons.add,color: AppColors.colorIndigo),
                        )),)
                ]
            ),
          ),
          _isLoading?Center(child: Padding(
            padding: EdgeInsets.all(SizeUtil.getSize(
                3.0, GlobalData.sizeScreen!)),
            child: CircularProgressIndicator(
              color: AppColors.colorIndigo, strokeWidth: 2,),
          )):Container(
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(0, SizeUtil.getSize(
                3.0, GlobalData.sizeScreen!), 0, 0),
            child: Column(
              children: List.generate(_mainList.length, (index) {
                return _ItemList(modelService:_mainList[index],listServices: _mainList,);
              }),
            ),
          )
        ],
      ),
    );
  }

   _getType(int id){
     if(id==1){
       return 'Седан';
     }else if(id==2){
       return 'Кроссовер';
     }else if(id==3){
       return 'Внедорожник';
     }else if(id==4){
       return 'Микроавтобус';
     }else if(id==5){
       return 'Иное';
     }

   }
   _getTypeSer(int type){
     if(type==0){
       return 'Мойка';
     }else{
       return 'Дитейлинг';
     }
   }

   _getTypeVid(int type){
     if(type==0){
       return 'Комплекс';
     }else{
       return 'Услуга';
     }
   }
   Future<List<ModelService>?> _getServiceInfo({required BuildContext context,required int carType,required int serviceType, required bool isDetailing,required String query}) async{
     _isLoading=true;
     final result= await RepositoryModule.userRepository().getService(context: context, carType:_carType, serviceType: _serviceType, isDetailing: _isDetailing, query: '');
     setState(() {
       _isLoading=false;
       _mainList=result!;
       widget.onLoad(true,_carType);
     });


   }



   @override
  void initState() {
   super.initState();
   _getServiceInfo(context: context, carType:_carType, serviceType:_serviceType, isDetailing:_isDetailing, query:'');/**/
  }
}









class PageSale extends StatefulWidget{


  int carType;


  @override
  State<PageSale> createState() => _PageSaleState();

  PageSale({required this.carType});
}

class _PageSaleState extends State<PageSale> {

  String _typeCar='Седан';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: SizeUtil.getSize(5.1,GlobalData.sizeScreen!),
          margin: EdgeInsets.fromLTRB(0, SizeUtil.getSize(
        3.0, GlobalData.sizeScreen!), 0, 0),
          color: Colors.white,
          child: Padding(
            padding:EdgeInsets.fromLTRB(SizeUtil.getSize(3.0, GlobalData.sizeScreen!),SizeUtil.getSize(1.5, GlobalData.sizeScreen!),SizeUtil.getSize(3.0, GlobalData.sizeScreen!),SizeUtil.getSize(1.5, GlobalData.sizeScreen!)),
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
                      child:  DropdownButton<String>(
                        value: _typeCar,
                        icon: const Icon(Icons.arrow_drop_down,
                          color: Colors.black,),
                        iconSize: 24,
                        elevation: 1,
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
                              widget.carType=1;
                            }else if(_typeCar=='Кроссовер'){
                              widget.carType=2;
                            }else if(_typeCar=='Внедорожник'){
                              widget.carType=3;
                            }else if(_typeCar=='Микроавтобус'){
                              widget.carType=4;
                            }else if(_typeCar=='Иное'){
                              widget.carType=5;
                            }
                            _getSaleInfo(context: context, carType: widget.carType);

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

        _isLoading_1?Center(child: Padding(
          padding: EdgeInsets.all(SizeUtil.getSize(
              3.0, GlobalData.sizeScreen!)),
          child: CircularProgressIndicator(
            color: AppColors.colorIndigo, strokeWidth: 2,),
        )):_mainList_1.length>0?Container(
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(0, SizeUtil.getSize(
              3.0, GlobalData.sizeScreen!), 0, 0),
          child: Column(
            children: List.generate(_mainList_1.length, (index) {
              return _ItemSale(modelSale:_mainList_1[index]);
            }),
          ),
        ):Container(
          margin:  EdgeInsets.fromLTRB(0, SizeUtil.getSize(
              3.0, GlobalData.sizeScreen!), 0, 0),
          child: Center(
            child: Text('Список акций пуст',style: TextStyle(color: AppColors.textColorHint,
                fontSize: SizeUtil.getSize(
                    2.0, GlobalData.sizeScreen!))),
          ),
        ),
      ],
    );

  }
  _getType(int id){
    if(id==1){
      return 'Седан';
    }else if(id==2){
      return 'Кроссовер';
    }else if(id==3){
      return 'Внедорожник';
    }else if(id==4){
      return 'Микроавтобус';
    }else if(id==5){
      return 'Иное';
    }

  }

  Future<List<ModelSale>?> _getSaleInfo({required BuildContext context,required int carType}) async{
    _isLoading_1=true;
    final result= await RepositoryModule.userRepository().getSaleInfo(context: context, carType:widget.carType);
    setState(() {
      _isLoading_1=false;
      _mainList_1=result!;
    });


  }

  @override
  void initState() {
    super.initState();
    _getSaleInfo(context: context, carType: widget.carType);
  }


}




   class _ItemList extends StatefulWidget{


     ModelService modelService;
     List<ModelService> listServices;



     _ItemList({required this.modelService,required this.listServices});

     @override
     State<_ItemList> createState() => _ItemListState();
   }

   class _ItemListState extends State<_ItemList>{


     bool _isSelect=false;
     double _turns = 0.0;


     @override
  void initState() {
   super.initState();

     }

     @override
  void dispose() {
   super.dispose();

     }

  @override
     Widget build(BuildContext context) {
       return GestureDetector(
         onTap: (){
           setState(() {
             if(_isSelect){
               _isSelect=false;
               _turns=0.0;
             }else{
               _isSelect=true;
               _turns=0.5;

             }
           });
         },
         child: Container(
           color: Colors.white,
           padding: EdgeInsets.fromLTRB(0, SizeUtil.getSize(1.0,
               GlobalData.sizeScreen!), 0,0),
           child: Column(
             children: [
               Row(
                 children: [
                   Padding(
                     padding:  EdgeInsets.fromLTRB(SizeUtil.getSize(
                         5.0,
                         GlobalData.sizeScreen!), 0, 0, 0),
                     child: Text(widget.modelService.name,
                       style:TextStyle(
                           fontSize: SizeUtil.getSize(
                               2.0, GlobalData.sizeScreen!),
                           color: Colors.black
                       ),),
                   ),
                   Expanded(
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                         children: [
                           Text('${widget.modelService.price} RUB',
                               style: TextStyle(
                                   color: AppColors.colorText22,
                                   fontSize:
                                   SizeUtil.getSize(2.0, GlobalData.sizeScreen!))),
                           widget.modelService.type=='complex'
                               ? Container(
                               height: SizeUtil.getSize(3.0, GlobalData.sizeScreen!),
                               width: SizeUtil.getSize(4.0, GlobalData.sizeScreen!),
                               child:   AnimatedRotation(
                                   duration: Duration(milliseconds: 600),
                                   turns: _turns,
                                   child: Icon(Icons.arrow_drop_down,color: AppColors.colorIndigo,)))
                               : Container(
                             height: SizeUtil.getSize(3.0, GlobalData.sizeScreen!),
                             width: SizeUtil.getSize(4.0, GlobalData.sizeScreen!),
                           ),
                         ],
                       )),
                 ],
               ),

               Padding(padding: EdgeInsets.fromLTRB(SizeUtil.getSize(
                   5.0,
                   GlobalData.sizeScreen!), SizeUtil.getSize(
                   1.0,
                   GlobalData.sizeScreen!), 0, 0),
                 child: Container(
                   height: 1,
                   color: AppColors.colorLine,
                 ),),
               widget.modelService.type=='complex'&&_isSelect?Container(
                 width: MediaQuery.of(context).size.width,
                 color: AppColors.colorLine,
                 child: Padding(
                   padding: EdgeInsets.all(SizeUtil.getSize(1.5,GlobalData.sizeScreen!)),
                   child: Text('${getTextDetails(widget.listServices,widget.modelService.id)}',
                     textAlign: TextAlign.center,
                     style: TextStyle(
                         color: AppColors.textColorDark_100
                     ),),
                 ),
               ):Container(),
             ],
           ),
         ),
       );
     }

     String getTextDetails(List<ModelService> list,int id){
       String tetx='';
       list.forEach((element) {
         if(element.id==id){
           element.listServices.forEach((el) {
             tetx+='${el.name}; ';
           });


         }
       });

       return tetx;
     }

   }

   class _ItemSale extends StatefulWidget{

     ModelSale modelSale;

     @override
     State<_ItemSale> createState() => _ItemSaleState();

     _ItemSale({required this.modelSale});
}

   class _ItemSaleState extends State<_ItemSale> {

     bool _isSelect=false;
     double _turns = 0.0;
     @override
     Widget build(BuildContext context) {
      return GestureDetector(
        onTap: (){
          setState(() {
            if(_isSelect){
              _isSelect=false;
              _turns=0.0;
            }else{
              _isSelect=true;
              _turns=0.5;

            }
          });
        },
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(0, SizeUtil.getSize(1.0,
              GlobalData.sizeScreen!), 0,0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding:  EdgeInsets.fromLTRB(SizeUtil.getSize(
                        5.0,
                        GlobalData.sizeScreen!), 0, 0, 0),
                    child: Container(
                      width:SizeUtil.getSize(
                          30.0,
                          GlobalData.sizeScreen!),
                      child: Text(widget.modelSale.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:TextStyle(
                            fontSize: SizeUtil.getSize(
                                2.0, GlobalData.sizeScreen!),
                            color: Colors.black
                        ),),
                    ),
                  ),
                  Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('${widget.modelSale.saleText}',
                              style: TextStyle(
                                  color: AppColors.colorText22,
                                  fontSize:
                                  SizeUtil.getSize(2.0, GlobalData.sizeScreen!))),
                          Container(
                              height: SizeUtil.getSize(3.0, GlobalData.sizeScreen!),
                              width: SizeUtil.getSize(4.0, GlobalData.sizeScreen!),
                              child:   AnimatedRotation(
                                  duration: Duration(milliseconds: 600),
                                  turns: _turns,
                                  child: Icon(Icons.arrow_drop_down,color: AppColors.colorIndigo,))),
                        ],
                      )),
                ],
              ),

              Padding(padding: EdgeInsets.fromLTRB(SizeUtil.getSize(
                  5.0,
                  GlobalData.sizeScreen!), SizeUtil.getSize(
                  1.0,
                  GlobalData.sizeScreen!), 0, 0),
                child: Container(
                  height: 1,
                  color: AppColors.colorLine,
                ),),
             _isSelect?Container(
                width: MediaQuery.of(context).size.width,
                color: AppColors.colorLine,
                child: Padding(
                  padding: EdgeInsets.all(SizeUtil.getSize(1.5,GlobalData.sizeScreen!)),
                  child: Column(
                    children: [
                      Padding(
                        padding:EdgeInsets.all(SizeUtil.getSize(1.5,GlobalData.sizeScreen!)),
                        child: Text('${widget.modelSale.name}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                              color: AppColors.textColorDark_100,
                            fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                          ),),
                      ),
                      Text('${widget.modelSale.itemsText}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.textColorDark_100
                        ),),
                      Padding(
                        padding:EdgeInsets.all(SizeUtil.getSize(1.5,GlobalData.sizeScreen!)),
                        child: Text('Акция продлиться с ${widget.modelSale.startAt} до ${widget.modelSale.endAt}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textColorHint
                          ),),
                      ),
                    ],
                  ),
                ),
              ):Container(),
            ],
          ),
        ),
      );
     }
   }