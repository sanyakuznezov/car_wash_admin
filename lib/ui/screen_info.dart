





   import 'package:car_wash_admin/domain/model/model_service.dart';
import 'package:car_wash_admin/internal/dependencies/repository_module.dart';
import 'package:car_wash_admin/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../app_colors.dart';
import '../global_data.dart';


   bool _isLoading=true;

class ScreenInfo extends StatefulWidget{
  @override
  State<ScreenInfo> createState() => _ScreenInfoState();
}

class _ScreenInfoState extends State<ScreenInfo> {




  @override
  Widget build(BuildContext context) {
   return DefaultTabController(
     length: 2,
     initialIndex: 0,
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
                   Align(alignment: Alignment.centerRight,
                     child: GestureDetector(
                       onTap:(){
                         setState(() {

                         });
                       },
                       child: Icon(Icons.search,color: AppColors.colorIndigo),
                     ),
                   )

                 ],
               ),
             ),
           )
         ],
         bottom: TabBar(
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
       body: TabBarView(children: [
         PageServices(),
       PageSale()
       ],

       ),
     ),
   );
  }
}


  class PageServices extends StatefulWidget{
  @override
  State<PageServices> createState() => _PageServicesState();
}




 class _PageServicesState extends State<PageServices> {

   bool _isSwithSearch=false;
   int _selType=0;
   int _selVid=0;
   bool _isDetailing=false;
   int _serviceType=2;
   int _carType=1;
   List<ModelService> _mainList=[];

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
                      Text('${getType(_carType)}; ${getTypeSer(_selType)}; ${getTypeVid(_selVid)}',
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

   getType(int id){
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
   getTypeSer(int type){
     if(type==0){
       return 'Мойка';
     }else{
       return 'Дитейлинг';
     }
   }

   getTypeVid(int type){
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
     });


   }

   @override
  void initState() {
   super.initState();
   _getServiceInfo(context: context, carType:_carType, serviceType:_serviceType, isDetailing:_isDetailing, query:'');/**/
  }
}









class PageSale extends StatefulWidget{
  @override
  State<PageSale> createState() => _PageSaleState();
}

class _PageSaleState extends State<PageSale> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
    );
  }
}




   class _ItemList extends StatefulWidget{


     var onSelect=(ModelService? modelService,bool isRemove)=>modelService,isRemove;
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
                 color: AppColors.colorBackgrondProfile,
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