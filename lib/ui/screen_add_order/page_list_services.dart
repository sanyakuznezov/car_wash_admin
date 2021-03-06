


 import 'package:car_wash_admin/domain/model/model_service.dart';
import 'package:car_wash_admin/internal/dependencies/repository_module.dart';
import 'package:car_wash_admin/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app_colors.dart';
import '../../../global_data.dart';

class PageListServices extends StatefulWidget{

  int carType;
  List<ModelService> listAlreadySelected;
  var onListServices=(List<ModelService>? list)=>list;
  bool loadList=false;


  @override
  State<PageListServices> createState() => _PageListServicesState();

  PageListServices({required this.carType,required this.onListServices,required this.listAlreadySelected});
}

class _PageListServicesState extends State<PageListServices> {


  int _selType=0;
  int _selVid=0;
   bool _isSwithSearch=false;
  List<ModelService> _mainList=[];
  List<ModelService> _searchList=[];
  List<ModelService> _selList=[];
  List<ModelService> _selListAlready=[];
  bool? _isSearching;
  bool _searhVisible=false;
  bool _isDetailing=false;
  int _serviceType=2;
  bool _isLoading=true;
  bool _isSelected=false;
  TextEditingController _searchController=TextEditingController();



  @override
  Widget build(BuildContext context) {
    if(!widget.loadList){
      _selListAlready=widget.listAlreadySelected;
      widget.loadList=false;
      _selList.clear();
      _selListAlready.forEach((element) {
        if(element.id!=0){
          _selList.add(element);
        }

      });

    }
    return WillPopScope (
      onWillPop: () async {
        widget.onListServices(_selList);
        return true;
      },
      child: Scaffold(
          floatingActionButton: _isSelected?FloatingActionButton(
            onPressed: () {
              // Add your onPressed code here!
              Navigator.pop(context);
              widget.onListServices(_selList);
            },
            child: const Icon(Icons.check_outlined,color:Colors.indigo),
            backgroundColor: Colors.white,
          ):null,
          backgroundColor: AppColors.colorBackgrondProfile,
          body: SingleChildScrollView(
            child: Column(
              children: [
                AppBar(
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
                                onTap: () {
                                  Navigator.pop(context);
                                  widget.onListServices(_selList);
                                },
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: AppColors.colorIndigo,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                '???????????? ??????????',
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
                                 if(!_searhVisible){
                                   _searhVisible=true;
                                 }else{
                                   _searhVisible=false;
                                   _searchList.clear();
                                 }
                               });
                                },
                                child: !_isLoading?Icon(Icons.search,color: AppColors.colorIndigo):Container(),
                              ),
                            )

                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding:EdgeInsets.fromLTRB(SizeUtil.getSize(
                        1.5, GlobalData.sizeScreen!), 0, SizeUtil.getSize(
                        1.5, GlobalData.sizeScreen!), 0),
                    child: _searhVisible?Container(
                      margin: EdgeInsets.all(SizeUtil.getSize(
                          1.3,
                          GlobalData.sizeScreen!)),
                      decoration: BoxDecoration(
                          color: AppColors.colorBackgrondProfile,
                          borderRadius: BorderRadius.circular(SizeUtil.getSize(
                              1.0,
                              GlobalData.sizeScreen!))
                      ),
                      child: TextField(
                        style: TextStyle(
                            color: AppColors.textColorPhone,
                            fontWeight: FontWeight.bold,
                            fontSize: SizeUtil.getSize(1.8,
                                GlobalData.sizeScreen!)),
                        controller: _searchController,
                        decoration: InputDecoration(
                            hintText: '?????????? ????????????',
                            hintStyle: TextStyle(
                                color: AppColors.textColorHint
                            ),
                            contentPadding: EdgeInsets.all(SizeUtil.getSize(
                                1.5, GlobalData.sizeScreen!)),
                            border: InputBorder.none),
                        onChanged: (text) {
                          if (_searchController.text.isEmpty) {
                            setState(() {
                              _isSearching = false;
                            });
                          } else {
                            setState(() {
                              _isSearching = true;
                            });
                          }
                          search(text);
                        },
                      ),
                    ):Container(),
                  ),
                ),

                !_searhVisible?!_isSwithSearch?Container(
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
                                child: Text('??????????????',style: TextStyle(color: AppColors.colorText22,
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
                              child: Text('??????',style: TextStyle(color: AppColors.textColorHint,
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
                                    _getService(context: context, carType:widget.carType , serviceType:_serviceType, isDetailing:_isDetailing, query:'');
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
                                    '??????????',
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
                                    _getService(context: context, carType:widget.carType , serviceType:_serviceType, isDetailing:_isDetailing, query:'');
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.all(SizeUtil.getSize(
                                      0.5, GlobalData.sizeScreen!)),
                                  padding: EdgeInsets.all(SizeUtil.getSize(
                                      1.5, GlobalData.sizeScreen!)),
                                  alignment: Alignment.center,
                                  width: SizeUtil.getSize(
                                      17.0, GlobalData.sizeScreen!),
                                  decoration: BoxDecoration(
                                      color: _selType==1?AppColors.colorIndigo:Colors.white,
                                      border: _selType==0?Border.all(width: 1,color: AppColors.textColorPhone):null,
                                      borderRadius: BorderRadius.circular(SizeUtil.getSize(
                                          1.5, GlobalData.sizeScreen!))
                                  ),
                                  child: Text(
                                    '??????????????????',
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
                              child: Text('??????',style: TextStyle(color: AppColors.textColorHint,
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
                                    _getService(context: context, carType:widget.carType , serviceType:_serviceType, isDetailing:_isDetailing, query:'');
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
                                    '????????????????',
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
                                    _getService(context: context, carType:widget.carType , serviceType:_serviceType, isDetailing:_isDetailing, query:'');
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
                                    '????????????',
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
                  )):Container(
              color: Colors.white,
              child: Column(
                children: [
                  Stack(
                      children:[
                        Padding(
                          padding:EdgeInsets.all(SizeUtil.getSize(
                              1.5, GlobalData.sizeScreen!)),
                          child:
                          Text('${getType(widget.carType)}; ${getTypeSer(_selType)}; ${getTypeVid(_selVid)}',
                          style: TextStyle(
                              color: AppColors.textColorPhone,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeUtil.getSize(1.8,
                                  GlobalData.sizeScreen!)),
                          ),),
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
                ],
              ),
            ):Container(),
                _isLoading?Center(child: Padding(
                  padding: EdgeInsets.all(SizeUtil.getSize(
                      3.0, GlobalData.sizeScreen!)),
                  child: CircularProgressIndicator(
                    color: AppColors.colorIndigo, strokeWidth: 2,),
                )):_searchList.length != 0?
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.fromLTRB(0, SizeUtil.getSize(
                      3.0, GlobalData.sizeScreen!), 0, 0),
                  child: Column(
                    children: List.generate(_searchList.length, (index) {
                      return _ItemList(modelService:_searchList[index],listAlready: _selListAlready,
                          onSelect: (value,remove) {
                            if(!remove){
                              _selListAlready.add(value!);
                              _selList.add(value);
                            }else{
                              _selList.remove(value);
                              for(int i=0;_selListAlready.length>i;i++){
                                if(_selListAlready[i].id==value!.id){
                                  _selListAlready.removeAt(i);
                                  break;
                                }
                              }
                              for(int i=0;_selList.length>i;i++){
                                if(_selList[i].id==value!.id){
                                  _selList.removeAt(i);
                                  break;
                                }
                              }
                            }
                            setState(() {
                              _isSelected=true;
                              // if(_selList.length>0){
                              //   _isSelected=true;
                              // }else{
                              //   _isSelected=false;
                              // }
                            });
                          });
                    }),
                  ),
                ):Container(
                  color: Colors.white,
                  margin: EdgeInsets.fromLTRB(0, SizeUtil.getSize(
                      3.0, GlobalData.sizeScreen!), 0, 0),
                  child: Column(
                    children: List.generate(_mainList.length, (index) {
                      return _ItemList(modelService:_mainList[index],listAlready: _selListAlready,
                          onSelect: (value,remove) {
                        if(!remove){
                         _selListAlready.add(value!);
                          _selList.add(value);
                        }else{
                          for(int i=0;_selListAlready.length>i;i++){
                            if(_selListAlready[i].id==value!.id){
                               _selListAlready.removeAt(i);
                              break;
                            }
                          }
                          for(int i=0;_selList.length>i;i++){
                            if(_selList[i].id==value!.id){
                              _selList.removeAt(i);
                              break;
                            }
                          }
                        }
                        setState(() {
                          _isSelected=true;
                          // if(_selList.length>0){
                          //   _isSelected=true;
                          // }else{
                          //   _isSelected=false;
                          // }
                        });
                      });
                    }),
                  ),
                )


              ]
            ),
          ) ),
    );


  }
  
  getType(int id){
  if(id==1){
    return '??????????';
  }else if(id==2){
    return '??????????????????';
  }else if(id==3){
    return '??????????????????????';
  }else if(id==4){
    return '????????????????????????';
  }else if(id==5){
    return '????????';
  }
 
  }
  getTypeSer(int type){
    if(type==0){
      return '??????????';
    }else{
      return '??????????????????';
    }
  }

  getTypeVid(int type){
      if(type==0){
        return '????????????????';
      }else{
        return '????????????';
      }
  }
  
  
  void search(String text) {
    _searchList.clear();
    if (_isSearching != null) {
      for (int i = 0; i < _mainList.length; i++) {
        ModelService data = _mainList[i];
        if (data.name.toLowerCase().contains(text.toLowerCase())) {
          _searchList.add(data);
        }
      }
    }
  }
  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }
  @override
  void initState(){
    super.initState();
    _isSearching = false;
    _getService(context: context, carType:widget.carType , serviceType:_serviceType, isDetailing:_isDetailing, query:'');

  }

   Future<List<ModelService>?> _getService({required BuildContext context,required int carType,required int serviceType, required bool isDetailing,required String query}) async{
      _isLoading=true;
       final result= await RepositoryModule.userRepository().getService(context: context, carType: widget.carType, serviceType: _serviceType, isDetailing: _isDetailing, query: '');
       setState(() {
         _isLoading=false;
         _mainList=result!;
       });


   }

}

 class _ItemList extends StatefulWidget{


   var onSelect=(ModelService? modelService,bool isRemove)=>modelService,isRemove;
   ModelService modelService;
   List<ModelService> listAlready;




   _ItemList({required this.modelService,required this.onSelect,required this.listAlready});

   @override
   State<_ItemList> createState() => _ItemListState();
 }

 class _ItemListState extends State<_ItemList> {

   bool _isAlreadySelected=false;
   bool _isSelect=false;

   @override
   Widget build(BuildContext context) {
     if(!_isAlreadySelected){
       _isAlreadySelected=true;
       widget.listAlready.forEach((element) {
         if(element.id==widget.modelService.id){
           _isSelect=true;
         }
       });
     }
     return GestureDetector(
       onTap: (){
             setState(() {
               if(_isSelect){
                 _isSelect=false;
                 widget.onSelect(widget.modelService,true);
               }else{
                 _isSelect=true;
                 widget.onSelect(widget.modelService,false);
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
                    _isSelect
                        ? Container(
                      height: SizeUtil.getSize(3.0, GlobalData.sizeScreen!),
                            width: SizeUtil.getSize(4.0, GlobalData.sizeScreen!),
                            child: SvgPicture.asset('assets/frame.svg'))
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
               ),)
           ],
         ),
       ),
     );
   }
 }


