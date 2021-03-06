


  import 'dart:async';

import 'package:car_wash_admin/app_colors.dart';
import 'package:car_wash_admin/domain/model/model_calculate_price.dart';
import 'package:car_wash_admin/domain/model/model_order_show.dart';
import 'package:car_wash_admin/domain/model/model_service.dart';
import 'package:car_wash_admin/domain/model/model_worker.dart';
import 'package:car_wash_admin/domain/state/bloc_page_route.dart';
import 'package:car_wash_admin/domain/state/state_add_order.dart';
import 'package:car_wash_admin/domain/state/state_order.dart';
import 'package:car_wash_admin/internal/dependencies/repository_module.dart';
import 'package:car_wash_admin/ui/global_widgets/container_addorder.dart';
import 'package:car_wash_admin/ui/global_widgets/container_bottomsheet_edittime.dart';
import 'package:car_wash_admin/ui/global_widgets/container_deleteorder.dart';
import 'package:car_wash_admin/ui/screen_add_order/page_list_services.dart';
import 'package:car_wash_admin/ui/screen_add_order/page_list_workers.dart';
import 'package:car_wash_admin/ui/screen_add_order/page_search_brand.dart';
import 'package:car_wash_admin/utils/size_util.dart';
import 'package:car_wash_admin/utils/time_parser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobx/mobx.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../global_data.dart';
import '../../internal/dependencies/app_module.dart';



 Map<String,dynamic> _order={};
 String _surName='';
 String _lastName='';
 String _patronymicName='';
 late ValueNotifier<ModelCalculatePrice> _notifier;
  List<int> _idServiceList=[];
  List<int> _idComplexList=[];
  //TODO добавить список испонителей на APi и в модели
  List<ModelWorker> _listWorker=[];
  int _typeCarInt =1;
  bool _isLoading=false;
  int _editStatusMain=2;
  ValueNotifier<bool>? _fabNotifi;
  String? _dateValue;
  String? _date;
  bool _isEditTotalPrice=false;
  int _id=0;





  Future<ModelCalculatePrice?> _getPrice({required bool edit,required BuildContext context,required int carType,required List<int> servicesIds, required List<int> complexesIds})async{
    _isLoading=true;
    _notifier.value=ModelCalculatePrice(result: true,totalPrice: 0,sale: 0,saleName: 'test',workTime: 0,workTimeWithMultiplier: 0,list: []);
    final result=await RepositoryModule.userRepository().getPrice(context: context, carType: carType, servicesIds: servicesIds, complexesIds: complexesIds);
    _notifier.value=result!;
    if(edit){
      _fabNotifi!.value=true;
      _isEditTotalPrice=true;
    }
    _isLoading=false;
    return result;
  }


//TODO реализовать подгрузку свобоных промежутков времемни с учетом режима работы мойки по выбранной дате
class PageAddOrder extends StatefulWidget{


  int? post;
  String? date;
  String? time;
  int timeStartWash;
  int timeEndWash;
  bool isClose=false;
  bool isVisibleFAB=true;
   int?  idOrder;
  int editStatus;





  @override
  StatePageAddOrder createState() {
    // TODO: implement createState
    return StatePageAddOrder();
  }

  PageAddOrder({required this.editStatus,this.idOrder,required this.timeEndWash,required this.timeStartWash,required this.post,required this.date,required this.time}){
    isVisibleFAB=false;
    _editStatusMain=editStatus;
    if(_editStatusMain==GlobalData.EDIT_MODE){
      _id=idOrder!;
    }
  }


}

  class StatePageAddOrder extends State<PageAddOrder>{

    bool _isSucces=false;
    String? _msg;
    int? _idOrder=0;
    StateOrder? _stateOrder;
    bool _isEdit=false;

  @override
  Widget build(BuildContext context) {
    if(widget.isClose){
      Navigator.of(context, rootNavigator: true).pop('dialog');
      if(_isSucces){
        Timer.periodic(Duration(seconds: 1), (timer) {
          Navigator.pop(context);
          timer.cancel();
          AppModule.notifiForReload.value=_isSucces;
        });
      }
    }
    return Scaffold(
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
                  Text(widget.editStatus==GlobalData.ADD_ORDER_MODE?'Создать запись':'Просмотр записи',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,
                        fontSize: SizeUtil.getSize(2.8,GlobalData.sizeScreen!)),),
                  !_isSucces?GestureDetector(
                    onTap: () {
                      if(_editStatusMain==GlobalData.EDIT_MODE&&_idOrder!=0){
                        showMaterialModalBottomSheet(
                            backgroundColor: Colors.white,
                            context: context,
                            builder: (context) => ContainerDeleteOrder(
                              onAccept: (int? i) {
                                _deleteOrder(context: context, id: _idOrder!);
                              },));
                      }
                    },
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                            height: SizeUtil.getSize(
                                3.0, GlobalData.sizeScreen!),
                            child: _editStatusMain==GlobalData.EDIT_MODE
                                ? Icon(
                              Icons.delete_outline_outlined,
                              color: Colors.red,
                            )
                                :_editStatusMain==GlobalData.VIEW_MODE?SvgPicture.asset('assets/flag_1.svg'):Container())),
                  ):Container()
                ],
              ),
            ),
          )
        ],
      ),
      backgroundColor: AppColors.colorBackgrondProfile,
      floatingActionButton: ValueListenableBuilder<bool>(
        builder: (context,hide,widget){
          return hide?FloatingActionButton(
            onPressed: () {
              showMaterialModalBottomSheet(
                  backgroundColor: Colors.white,
                  context: context,
                  builder: (context) => ContainerAddOrder(
                    isEdit: _isEdit,
                    onAccept: (int? i) {
                      if(_editStatusMain==GlobalData.EDIT_MODE||_editStatusMain==GlobalData.VIEW_MODE){
                        _order.update('clientFullname', (value) =>'$_lastName $_surName $_patronymicName');
                        _order.update('ComplexesList', (value) => _idComplexList);
                        _order.update('ServicesList', (value) => _idServiceList);
                         _editOrder(map: _order, context: context,id: _idOrder!);
                      }else{
                       _validateTime(map: _order, context: context);
                      }

                    },));

            },
            child: const Icon(Icons.check_outlined,color:Colors.indigo),
            backgroundColor: Colors.white,
          ):Container();
        }, valueListenable: _fabNotifi!,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _isSucces?Container(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle_outline_outlined,color: Colors.green,size: SizeUtil.getSize(10,GlobalData.sizeScreen!),),
              Padding(
                padding: EdgeInsets.all(SizeUtil.getSize(1.5,GlobalData.sizeScreen!)),
                child: Text('$_msg',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,
                    fontSize: SizeUtil.getSize(2.8,GlobalData.sizeScreen!))),
              ),

          ],
        ),
              ),
            ):_editStatusMain==GlobalData.EDIT_MODE||_editStatusMain==GlobalData.VIEW_MODE?
            Observer(builder: (_){
                if(_stateOrder!.isError){
                   return Container(
                     height: MediaQuery.of(context).size.height,
                     child: Center(
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Icon(Icons.error,color: Colors.redAccent,size: SizeUtil.getSize(6.0,GlobalData.sizeScreen!),),
                           Text('Ошибка получения данных',style:
                           TextStyle(
                               fontWeight: FontWeight.bold,
                               color: Colors.redAccent
                           ),),
                         ],
                       ),
                     ),
                   );
                }

                if(!_stateOrder!.isLoading){
                  if(!_stateOrder!.isInitData){
                    _date=_stateOrder!.modelOrderShow!.date;
                    _order.update('personalFullname', (value) => _stateOrder!.modelOrderShow!.personalFullname);
                    _order.update('personalId', (value) =>_stateOrder!.modelOrderShow!.personalId);
                    _order.update('post', (value) => _stateOrder!.modelOrderShow!.post);
                    _order.update('date', (value) => _stateOrder!.modelOrderShow!.date);
                    _order.update('startTime', (value) =>_stateOrder!.modelOrderShow!.startTime);
                    _order.update('endTime', (value) =>_stateOrder!.modelOrderShow!.endTime);
                    _order.update('carType', (value) => _stateOrder!.modelOrderShow!.carType);
                    _order.update('carNumber', (value) => _stateOrder!.modelOrderShow!.carNumber);
                    _order.update('carRegion', (value) => _stateOrder!.modelOrderShow!.carRegion);
                    _order.update('carBrandId', (value) => _stateOrder!.modelOrderShow!.carBrandid==0?null:_stateOrder!.modelOrderShow!.carBrandid);
                    _order.update('carModelId', (value) => _stateOrder!.modelOrderShow!.carModelid==0?null:_stateOrder!.modelOrderShow!.carModelid);
                    _order.update('color', (value) => _stateOrder!.modelOrderShow!.color);
                    _order.update('clientPhone', (value) => _stateOrder!.modelOrderShow!.clientPhone);
                    _order.update('clientFullname', (value) => _stateOrder!.modelOrderShow!.clientFullname);
                    _order.update('totalPrice', (value) => _stateOrder!.modelOrderShow!.totalPrice);
                    _order.update('sale', (value) => _stateOrder!.modelOrderShow!.sale);
                    _order.update('workTime', (value) => _stateOrder!.modelOrderShow!.workTime);
                    _order.update('status', (value) => _stateOrder!.modelOrderShow!.status);
                    _order.update('adminComment', (value) => _stateOrder!.modelOrderShow!.adminComment);
                    _order.update('clientComment', (value) => _stateOrder!.modelOrderShow!.clientComment);
                    _order.update('ComplexesList', (value) => _stateOrder!.modelOrderShow!.complexes);
                    _order.update('ServicesList', (value) => _stateOrder!.modelOrderShow!.services);
                    _idOrder=_stateOrder!.modelOrderShow!.id;
                    if(_stateOrder!.modelOrderShow!.clientFullname.split(' ').length==3){
                      _surName=_stateOrder!.modelOrderShow!.clientFullname.split(' ')[1];
                      _lastName=_stateOrder!.modelOrderShow!.clientFullname.split(' ')[0];
                      _patronymicName=_stateOrder!.modelOrderShow!.clientFullname.split(' ')[2];
                    }else if(_stateOrder!.modelOrderShow!.clientFullname.split(' ').length==2){
                      _surName=_stateOrder!.modelOrderShow!.clientFullname.split(' ')[1];
                      _lastName=_stateOrder!.modelOrderShow!.clientFullname.split(' ')[0];
                    }else if(_stateOrder!.modelOrderShow!.clientFullname.split(' ').length==1){
                      _lastName=_stateOrder!.modelOrderShow!.clientFullname.split(' ')[0];
                    }
                    // //вызов списка работ
                    _stateOrder!.modelOrderShow!.services.forEach((element) {
                      _idServiceList.add(element['id']);
                    });
                    _stateOrder!.modelOrderShow!.complexes.forEach((element) {
                      _idComplexList.add(element['id']);
                    });
                    _stateOrder!.getPrice(context: context, carType: _stateOrder!.modelOrderShow!.carType, idServiceList: _idServiceList, idComplexList: _idComplexList);
                    _stateOrder!.isInitData=true;
                  }
                  return Column(
                    children: [
                      ItemDate.editOrder(
                          callback: (hide){
                            if(hide!){
                              _fabNotifi!.value=hide;
                            }
                          },
                          timeEndWash:widget.timeEndWash,timeStartWash:widget.timeStartWash,time:'${TimeParser.parseIntToStringTime(_stateOrder!.modelOrderShow!.startTime)}-${TimeParser.parseIntToStringTime(_stateOrder!.modelOrderShow!.endTime)}',post:_stateOrder!.modelOrderShow!.post),
                      ItemCar.editOrder(callback:(hide){
                        if(hide!){
                          _fabNotifi!.value=hide;
                        }
                      },modelOrderShow: _stateOrder!.modelOrderShow),
                      ItemClient.editOrder(callback:(hide){
                        if(hide!){
                          _fabNotifi!.value=hide;
                        }
                      },modelOrderShow: _stateOrder!.modelOrderShow),
                      Observer(
                          builder: (_){
                            if(!_stateOrder!.isLoadPrice){
                              _notifier.value=_stateOrder!.modelCalculatePrice!;
                              _isLoading=false;
                              _stateOrder!.isLoadPrice=true;
                            }
                            return Column(
                              children: [
                                ItemListWork.editOrder(callback: (hide){
                                  if(hide!){
                                    _fabNotifi!.value=hide;
                                  }
                                }),
                                ItemPrice.editOrder(callback:(hide){
                                  if(hide!){
                                    _fabNotifi!.value=hide;
                                  }
                                }),
                              ],
                            );

                          }),
                      ItemComment.editOrder(callback:(hide){
                        if(hide!){
                          _fabNotifi!.value=hide;
                        }
                      },
                          modelOrderShow: _stateOrder!.modelOrderShow),
                      ItemReview.editOrder(modelOrderShow: _stateOrder!.modelOrderShow)
                    ],
                  );

                }
                return Container(
                    height: MediaQuery.of(context).size.height,
                    alignment: Alignment.center,
                    child: Center(child: CircularProgressIndicator(color: AppColors.colorIndigo)));
              }
            ):Column(
              children: [
                ItemDate(timeEndWash:widget.timeEndWash,timeStartWash:widget.timeStartWash,time: widget.time,post: widget.post),
                ItemCar(),
                ItemClient(),
                ItemListWork(),
                ItemPrice(),
                ItemComment(editStatus: widget.editStatus),
                widget.editStatus!=GlobalData.ADD_ORDER_MODE?ItemReview():Container(),
                widget.editStatus==GlobalData.ADD_ORDER_MODE?SizedBox(height:  SizeUtil.getSize(
                    10.0,
                    GlobalData.sizeScreen!),):Container()

              ],
            )


          ],
        ),
      ),
    );

  }



  Future<void> _deleteOrder({required BuildContext context,required int id}) async{
    showLoaderDialog(context);
    final result = await RepositoryModule.userRepository().deleteOrder(context: context, id: id).catchError(
        (error){
          setState(() {
            widget.isClose=true;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.white,
              content:Text('Ошибка удаления заказа....',
                style: TextStyle(
                    color: Colors.red
                ),)));
        }
    );

    if(result==null){
      setState(() {
        widget.isClose=true;
      });
    }

    if(result!){
      setState(() {
        widget.isClose=true;
        _isSucces=true;
        _msg='Заказ удален';
        _fabNotifi!.value=false;
      });
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.white,
          content:Text('Заказ не удален, повторите попытку',
            style: TextStyle(
                color: Colors.red
            ),)));
      setState(() {
        widget.isClose=true;
      });

    }


  }


  @override
  void initState() {
    super.initState();
    _order={'personalFullname':'....','personalId':0,'date':'','post':0,'startTime':'','endTime':'','carType':1,'carNumber':'A000AA',
      'carRegion':000,'color':'Черный','carBrandId':null,'carModelId':null,'clientFullname':'','clientPhone':'',
      'totalPrice':0,'sale':0,'workTime':0,'status':10,'adminComment':'','clientComment':'','ComplexesList':[],
      'ServicesList':[]};
    _stateOrder=StateOrder();
    widget.time=_stateOrder!.validateTime(widget.timeEndWash,widget.time!);
   if( _editStatusMain==GlobalData.EDIT_MODE||_editStatusMain==GlobalData.VIEW_MODE){
       _stateOrder!.getOrderShow(context: context, id:widget.idOrder!);
    }
    if(_editStatusMain==GlobalData.ADD_ORDER_MODE){
      _isEdit=false;
      _date=widget.date;
      _order.update('post', (value) => widget.post);
      _order.update('date', (value) => widget.date);
      _order.update('startTime', (value) =>TimeParser.parseTimeForApi(widget.time!.split('-')[0]));
      _order.update('endTime', (value) =>TimeParser.parseTimeForApi(widget.time!.split('-')[1]));
    }
    if(_editStatusMain==GlobalData.EDIT_MODE||_editStatusMain==GlobalData.VIEW_MODE){
      _isEdit=true;
      _fabNotifi=ValueNotifier<bool>(false);

    }else if(_editStatusMain==GlobalData.ADD_ORDER_MODE){
      _fabNotifi=ValueNotifier<bool>(true);
    }
    _notifier=ValueNotifier<ModelCalculatePrice>(ModelCalculatePrice(result: true,totalPrice:0,sale:0,saleName: 'test',workTime:0,workTimeWithMultiplier: 0,list: []));
  }

  @override
  void dispose() {
    super.dispose();
    _notifier.dispose();
    _fabNotifi!.dispose();
    _idServiceList.clear();
    _idComplexList.clear();
    _stateOrder!.dispose();
    _isEditTotalPrice=false;
  }

  Future<bool?> _validateTime({required Map<String,dynamic> map,required BuildContext context})async{
    showLoaderDialog(context);
    final result= await RepositoryModule.userRepository().intersectionValidate(map: map, context: context)
        .catchError((error){
      setState(() {
        widget.isClose=true;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.white,
          content:Text('Ошибка проверки времени....',
      style: TextStyle(
        color: Colors.red
      ),)));
    });

    if(result==null){
      setState(() {
        widget.isClose=true;
      });
    }

         if(result!){
           _order.update('clientFullname', (value) =>'$_lastName $_surName $_patronymicName');
           _order.update('ComplexesList', (value) => _idComplexList);
           _order.update('ServicesList', (value) => _idServiceList);
           _addOrder(map: map, context: context);

         }else{
           setState(() {
             widget.isClose=true;
           });
         }


     return result;
  }

    Future<bool> _editOrder({required Map<String,dynamic> map,required BuildContext context,required int id}) async{
      showLoaderDialog(context);
      final result= await RepositoryModule.userRepository().editOrder(map: map, context: context,idOrder: id)
          .catchError((error){
        setState(() {
          widget.isClose=true;
        });
        Fluttertoast.showToast(
            msg: "Ошибка редактирования заказа....",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.black,
            fontSize: 16.0
        );

      });

      if(result==null){
        setState(() {
          widget.isClose=true;
        });
      }
      if(result!){
        setState(() {
          widget.isClose=true;
          widget.isVisibleFAB=false;
          _isSucces=true;
          _fabNotifi!.value=false;
          _msg='Заказ успешно отредактирован';

        });

      }else{
        setState(() {
          widget.isClose=true;
        });
        Fluttertoast.showToast(
            msg: "Заказ не отредактирован",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.black,
            fontSize: 16.0
        );
      }
      return result;

    }







  Future<bool> _addOrder({required Map<String,dynamic> map,required BuildContext context}) async{
    final result= await RepositoryModule.userRepository().addOrder(map: map, context: context)
        .catchError((error){
          setState(() {
            widget.isClose=true;
          });
          Fluttertoast.showToast(
              msg: "Ошибка создания заказа....",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.red,
              textColor: Colors.black,
              fontSize: 16.0
          );

    });

    if(result==null){
      setState(() {
        widget.isClose=true;
      });
    }
      if(result!){
        setState(() {
          widget.isClose=true;
          widget.isVisibleFAB=false;
          _isSucces=true;
          _msg='Заказ успешно опубликован';
          _fabNotifi!.value=false;
        });

      }else{
        setState(() {
          widget.isClose=true;
        });
        Fluttertoast.showToast(
            msg: "Заказ не опубликован",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.black,
            fontSize: 16.0
        );
      }
      return result;

    }



  }



  showLoaderDialog(BuildContext context){
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


   class ItemReview extends StatelessWidget{

    ModelOrderShow? modelOrderShow;

    ItemReview.editOrder({this.modelOrderShow});
    ItemReview({this.modelOrderShow});

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
                       child: SvgPicture.asset('assets/ic_review.svg'),
                       height: SizeUtil.getSize(2.5,GlobalData.sizeScreen!),),
                     Expanded(
                       child: Padding(
                         padding: EdgeInsets.fromLTRB(SizeUtil.getSize(2.0,GlobalData.sizeScreen!), 0, 0, 0),
                         child: Text('Отзывы',
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
                   color: AppColors.color120,
                   child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Padding(
                           padding: EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),SizeUtil.getSize(2.0,GlobalData.sizeScreen!), 0, 0),
                           child: Text('.....',
                             style: TextStyle(
                                 fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!),
                                 color: AppColors.textColorPhone
                             ),),
                         ),
                         Padding(
                           padding: EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.5,GlobalData.sizeScreen!), 0, SizeUtil.getSize(2.0,GlobalData.sizeScreen!)),
                           child: Text('Комментарий клиента',
                             style: TextStyle(
                                 fontSize: SizeUtil.getSize(1.5,GlobalData.sizeScreen!),
                                 color: AppColors.textColorItem_50
                             ),),
                         ),
                         Container(height: 1, color: AppColors.colorLine),
                       ])),

               Container(
                   alignment: Alignment.centerLeft,
                   width: MediaQuery.of(context).size.width,
                   color: Colors.white,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Padding(
                           padding: EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),SizeUtil.getSize(2.0,GlobalData.sizeScreen!), 0, 0),
                           child: Text('.....',
                             style: TextStyle(
                                 fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!),
                                 color: AppColors.textColorPhone
                             ),),
                         ),
                         Padding(
                           padding: EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.5,GlobalData.sizeScreen!), 0, SizeUtil.getSize(2.0,GlobalData.sizeScreen!)),
                           child: Text('Ответный отзыв персонала',
                             style: TextStyle(
                                 fontSize: SizeUtil.getSize(1.5,GlobalData.sizeScreen!),
                                 color: AppColors.textColorItem_50
                             ),),
                         ),
                       ]))


             ]));
  }


}


  class ItemComment extends StatefulWidget{

    ModelOrderShow? modelOrderShow;
    var callback=(bool? hide)=>hide;
    int? editStatus;


    ItemComment.editOrder({required this.callback,this.modelOrderShow});
    ItemComment({required this.editStatus,this.modelOrderShow});

  @override
  State<ItemComment> createState() => _ItemCommentState();
}

class _ItemCommentState extends State<ItemComment> {
    TextEditingController? commentController;
     FocusNode? myFocusNodeComment;

    @override
  void dispose() {
   super.dispose();
   myFocusNodeComment!.dispose();
   commentController!.dispose();
  }

  @override
  void initState() {
   super.initState();
   myFocusNodeComment=FocusNode();
   commentController=TextEditingController();
  }



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
                  child: SvgPicture.asset('assets/ic_coment.svg'),
                  height: SizeUtil.getSize(2.5,GlobalData.sizeScreen!),),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(SizeUtil.getSize(2.0,GlobalData.sizeScreen!), 0, 0, 0),
                    child: Text('Комментарии',
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
          widget.editStatus!=GlobalData.ADD_ORDER_MODE?Container(
              margin: EdgeInsets.fromLTRB(0, SizeUtil.getSize(1.0, GlobalData.sizeScreen!), 0, 0),
              color: AppColors.color120,
              child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),SizeUtil.getSize(3.0,GlobalData.sizeScreen!), 0, 0),
                  child: Text(_editStatusMain==GlobalData.EDIT_MODE||_editStatusMain==GlobalData.VIEW_MODE? widget.modelOrderShow!.clientComment:'.....',
                    style: TextStyle(
                        fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!),
                        color: AppColors.textColorPhone
                    ),),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),SizeUtil.getSize(2.2,GlobalData.sizeScreen!), 0, SizeUtil.getSize(2.0,GlobalData.sizeScreen!)),
                  child: Text('Комментарий клиента',
                    style: TextStyle(
                        fontSize: SizeUtil.getSize(1.5,GlobalData.sizeScreen!),
                        color: AppColors.textColorItem_50
                    ),),
                ),
                Container(height: 1, color: AppColors.colorLine),
              ])):Container(),
          Container(
            alignment: Alignment.centerLeft,
            width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(SizeUtil.getSize(1.5,GlobalData.sizeScreen!),SizeUtil.getSize(2.0,GlobalData.sizeScreen!), SizeUtil.getSize(1.5,GlobalData.sizeScreen!), 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                                padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                                child: SizedBox(
                                  height: SizeUtil.getSize(6.0, GlobalData.sizeScreen!),
                                  child: _editStatusMain!=GlobalData.VIEW_MODE?TextField(
                                      textAlign: TextAlign.start,
                                      focusNode: myFocusNodeComment,
                                      style: TextStyle(
                                          color: AppColors.textColorPhone,
                                          fontWeight: FontWeight.bold,
                                          fontSize: SizeUtil.getSize(1.8,
                                              GlobalData.sizeScreen!)),
                                      controller: commentController,
                                      keyboardType: TextInputType.multiline,
                                      textInputAction: TextInputAction.newline,
                                      maxLines: 10,
                                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                                      decoration: InputDecoration(
                                          hintText: _editStatusMain==GlobalData.EDIT_MODE||_editStatusMain==GlobalData.VIEW_MODE?widget.modelOrderShow!.adminComment:'.....',
                                          contentPadding: EdgeInsets.all(
                                              SizeUtil.getSize(
                                                  1.5,
                                                  GlobalData
                                                      .sizeScreen!)),
                                          border: InputBorder.none),
                                      onChanged: (text) {
                                        if(text.isNotEmpty){
                                          widget.callback(true);
                                          _order.update('adminComment', (value) => text);
                                        }
                                      }

                                  ):Padding(
                                    padding:EdgeInsets.fromLTRB(SizeUtil.getSize(1.5,GlobalData.sizeScreen!),SizeUtil.getSize(2.0,GlobalData.sizeScreen!), SizeUtil.getSize(1.5,GlobalData.sizeScreen!), 0),
                                    child: Text('${commentController!.text==''?'....':commentController!.text}',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: AppColors.textColorPhone,
                                          fontWeight: FontWeight.bold,
                                          fontSize: SizeUtil.getSize(1.8,
                                              GlobalData.sizeScreen!)),
                                    ),
                                  ),
                                )
                            ),
                          ),
                          _editStatusMain!=GlobalData.VIEW_MODE?GestureDetector(
                            onTap: (){
                              myFocusNodeComment!.requestFocus();
                            },
                            child: Icon(
                              Icons.edit,
                              color: AppColors.colorBackgrondProfile,
                            ),
                          ):Container(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0, 0, SizeUtil.getSize(2.0,GlobalData.sizeScreen!)),
                      child: Text('Комментарий персонала',
                        style: TextStyle(
                            fontSize: SizeUtil.getSize(1.5,GlobalData.sizeScreen!),
                            color: AppColors.textColorItem_50
                        ),),
                    ),
                  ]))
        ]));
  }
}



  class ItemPrice extends StatefulWidget{

    var callback=(bool? hide)=>hide;

  @override
  State<ItemPrice> createState() => _ItemPriceState();

  ItemPrice.editOrder({required this.callback});
  ItemPrice();
}

class _ItemPriceState extends State<ItemPrice> {

    String? _selWorkerString=_order['personalFullname'];
    late TextEditingController _textEditingController;
    late FocusNode _focusNode;
    String _finalPrice='';
    bool _isEdit=false;
    ModelWorker? _modelWorker=ModelWorker(id:0, firstname: '', lastname: '', patronymic: '', avatar: '', phone: '', email: '', post: '');


  @override
  Widget build(BuildContext context) {
   return Container(
     margin:  EdgeInsets.fromLTRB(0,SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(0.8,GlobalData.sizeScreen!)),
     child: ValueListenableBuilder<ModelCalculatePrice>(
       valueListenable: _notifier,
       builder: (context,snapshot,widget) {
         if(snapshot.result){
           _order.update('sale', (value) => snapshot.sale);
           _order.update('workTime', (value) => snapshot.workTime);
             _finalPrice=(snapshot.totalPrice).toString();
             if(_isEditTotalPrice){
               print('TotalPrice in widget $_finalPrice');
               _order.update('totalPrice', (value) => _finalPrice);
             }


         }
         return Column(
           children: [
             Container(
               height: SizeUtil.getSize(5,GlobalData.sizeScreen!),
               margin: EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0),
               child: Stack(
                   children:[ Row(
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

                     ],
                   ),
                     Align(
                       alignment: Alignment.bottomRight,
                       child: _editStatusMain==GlobalData.EDIT_MODE||_editStatusMain==GlobalData.ADD_ORDER_MODE?GestureDetector(
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
                     )

                   ]
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

                   Container(
                     width: MediaQuery.of(context).size.width,
                     child: Padding(
                       padding:EdgeInsets.fromLTRB(SizeUtil.getSize(7.5,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text('Итого',
                               style: TextStyle(
                                   color: Colors.black,
                                   fontWeight: FontWeight.bold,
                                   fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                               )),
                           Padding(
                             padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                             child: Row(
                               children: [
                                 !_isLoading?Container(
                                   width: SizeUtil.getSize(20,GlobalData.sizeScreen!),
                                   child: SizedBox(
                                     height: SizeUtil.getSize(5.5,GlobalData.sizeScreen!),
                                     child: TextField(
                                         keyboardType:
                                         _editStatusMain==GlobalData.EDIT_MODE||_editStatusMain==GlobalData.ADD_ORDER_MODE?TextInputType.number:TextInputType.none,
                                         decoration: InputDecoration(
                                             hintText: _order['totalPrice'].toString(),
                                             hintStyle: TextStyle(
                                                 color: AppColors.textColorPhone,
                                                 fontWeight: FontWeight.bold,
                                                 fontSize: SizeUtil.getSize(2.3,GlobalData.sizeScreen!)
                                             ),
                                             //contentPadding: EdgeInsets.all(SizeUtil.getSize(1.5, GlobalData.sizeScreen!)),
                                             border: InputBorder.none),
                                         onChanged: (text) {
                                           _isEditTotalPrice=false;
                                           if (text.isNotEmpty) {
                                             _order.update('totalPrice', (value) => int.parse(text));
                                           }else{
                                             _order.update('totalPrice', (value) => _finalPrice);
                                           }
                                           _fabNotifi!.value=true;
                                         },
                                         controller: _textEditingController,
                                         focusNode: _focusNode,
                                         textAlign: TextAlign.end,
                                         style: TextStyle(
                                             color: AppColors.textColorPhone,
                                             fontWeight: FontWeight.bold,
                                             fontSize: SizeUtil.getSize(2.3,GlobalData.sizeScreen!)
                                         )),
                                   ),
                                 ):Align(
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
                                 Align(
                                   alignment: Alignment.centerRight,
                                   child: Padding(
                                     padding: EdgeInsets.fromLTRB(SizeUtil.getSize(1.0, GlobalData.sizeScreen!), 0,0, 0),
                                     child: Text('RUB',
                                         style: TextStyle(
                                             color: AppColors.textColorPhone,
                                             fontWeight: FontWeight.bold,
                                             fontSize: SizeUtil.getSize(
                                                 2.3, GlobalData.sizeScreen!))),
                                   ),
                                 ),
                                 _editStatusMain==GlobalData.EDIT_MODE&&_order['totalPrice'].toString()!=(snapshot.totalPrice).toString()||_editStatusMain==GlobalData.VIEW_MODE&&_order['totalPrice'].toString()!=(snapshot.totalPrice).toString()?
                                 Padding(
                                   padding:EdgeInsets.fromLTRB(SizeUtil.getSize(1.0, GlobalData.sizeScreen!), 0,0, 0),
                                   child: GestureDetector(
                                     child: Icon(Icons.error,color: Colors.red,size: SizeUtil.getSize(2.2,GlobalData.sizeScreen!),),
                                     onTap: (){
                                       Fluttertoast.showToast(
                                           msg: "Цена скорректирована при создании заказа",
                                           toastLength: Toast.LENGTH_SHORT,
                                           gravity: ToastGravity.CENTER,
                                           timeInSecForIosWeb: 3,
                                           backgroundColor: Colors.white,
                                           textColor: Colors.black,
                                           fontSize: 16.0
                                       );
                                     },
                                   ),
                                 ):Container()
                               ],
                             ),
                           ),

                         ],
                       ),
                     ),
                   ),
                   Container(
                       height: 1,
                       color: AppColors.colorLine),

                   Padding(
                       padding:EdgeInsets.fromLTRB(SizeUtil.getSize(7.5,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                       child: Row(
                         children: [
                           Text('Исполнитель',
                               style: TextStyle(
                                   color: AppColors.textColorItem,
                                   fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                               )),
                           FutureBuilder<List<ModelWorker>?>(
                             future: RepositoryModule.userRepository().getWorkers(context: context),
                             builder: (context,value){
                               if (value.hasData) {
                                 return Expanded(
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.end,
                                     children: [
                                       Padding(
                                         padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                                         child: Text(_selWorkerString!,
                                             textAlign: TextAlign.end,
                                             style: TextStyle(
                                                 color: AppColors.textColorPhone,
                                                 fontWeight: FontWeight.bold,
                                                 fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                                             )),
                                       ),
                                       Align(
                                         alignment: Alignment.centerRight,
                                         child: GestureDetector(
                                           onTap: () {
                                             Navigator.push(
                                                 context,
                                                 SlideTransitionLift(
                                                     PageListWorkers(
                                                       onWorker: (data) {
                                                         setState(() {
                                                           _isEdit=true;
                                                           if(data==null){
                                                             _selWorkerString='....';
                                                             _modelWorker=ModelWorker(id:0, firstname: '', lastname: '', patronymic: '', avatar: '', phone: '', email: '', post: '');
                                                           }else{
                                                             _modelWorker = data;
                                                             _selWorkerString ='${data.lastname} ${data.firstname[0]}. ${data.patronymic[0]}.';
                                                           }
                                                           _order.update('personalFullname',(value) =>_selWorkerString);
                                                           _order.update('personalId', (value) => _modelWorker!.id);
                                                           print('personalFullname Edit ${_order['personalFullname']}');
                                                         });
                                                       },
                                                       list: value.data,
                                                       selWorker: _modelWorker!,
                                                     )));
                                           },
                                           child: _editStatusMain==GlobalData.ADD_ORDER_MODE?Icon(
                                             Icons.arrow_forward_ios,
                                             color: AppColors.colorIndigo,
                                           ):Container(),
                                         ),
                                       ),
                                     ],
                                   ),
                                 );
                               } else {
                                 return Expanded(
                                   child: Padding(
                                     padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.5,GlobalData.sizeScreen!), 0),
                                     child: Align(
                                       alignment: Alignment.centerRight,
                                       child: SizedBox(
                                         height: SizeUtil.getSize(
                                             2.0, GlobalData.sizeScreen!),
                                         width: SizeUtil.getSize(
                                             2.0, GlobalData.sizeScreen!),
                                         child: CircularProgressIndicator(
                                           color: AppColors.colorIndigo,
                                           strokeWidth: SizeUtil.getSize(
                                               0.3, GlobalData.sizeScreen!),
                                         ),
                                       ),
                                     ),
                                   ),
                                 );
                               }
                             },
                           ),

                         ],
                       )
                   ),

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
    if(_isEdit){
      widget.callback(true);
    }
  }


}

   class ItemListWork extends StatefulWidget{

     ModelCalculatePrice? modelCalculatePrice;
     var callback=(bool? hide)=>hide;


  @override
  State<ItemListWork> createState() => _ItemListWorkState();

     ItemListWork.editOrder({required this.callback});
     ItemListWork();
}

  class _ItemListWorkState extends State<ItemListWork> {


  bool _isEdit=false;
  List<ModelServiceFromCalculate> _calculateList=[];
  List<ModelService> _listService=[];
  int i=-2;
  bool _isAddService=false;

  @override
  Widget build(BuildContext context) {

  print('build list work');
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

               _idComplexList.length>0||_idServiceList.length>0?Align(
                 alignment: Alignment.bottomCenter,
                 child: Container(
                   child:  _editStatusMain!=GlobalData.VIEW_MODE?GestureDetector(
                     child: Text(_isEdit?'Отмена':'Править',
                       textAlign: TextAlign.right,
                       style: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!),
                           color: AppColors.colorIndigo
                       ),),
                     onTap: (){
                       if(_calculateList.length>1){
                         setState(() {
                           if (!_isEdit) {
                             _isEdit = true;
                           } else {
                             _isEdit = false;
                           }
                         });

                       }

                     },
                   ):Container(),
                 ),
               ):Container(),

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
                     _editStatusMain!=GlobalData.VIEW_MODE?Text('Добавить',
                         style: TextStyle(
                             color: AppColors.textColorItem,
                             fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                         )):Container(),
                     _editStatusMain!=GlobalData.VIEW_MODE?Expanded(
                       child: Align(
                         alignment: Alignment.centerRight,
                         child: GestureDetector(
                           onTap: (){
                             Navigator.push(context, SlideTransitionLift(PageListServices(
                               carType: _typeCarInt,listAlreadySelected: _listService,
                             onListServices: (list){
                                 setState(() {
                                   _isAddService=true;
                                   _idComplexList.clear();
                                   _idServiceList.clear();
                                   _listService.clear();
                                   _listService.add(ModelService(listServices:[],id: 0, type: 'service', name: 'Въезд-Выезд', isDetailing: false, price: 0, time: 0));
                                   list!.forEach((element) {
                                     _listService.insert(1,element);
                                     if(element.type=='complex'){
                                       _idComplexList.add(element.id);
                                     }else if(element.type=='service'){
                                       _idServiceList.add(element.id);
                                     }

                                   });
                                  // widget.callback(true);
                                   _getPrice(edit:true,context: context, carType: _typeCarInt, servicesIds: _idServiceList, complexesIds: _idComplexList);
                                 });

                             },)));
                           },
                           child: Icon(
                             Icons.arrow_forward_ios,
                             color: AppColors.colorIndigo,
                           ),
                         ),
                       ),
                     ):Container(),
                   ],
                 ),
               ),
               _editStatusMain!=GlobalData.VIEW_MODE?Container(
                   margin: EdgeInsets.fromLTRB(SizeUtil.getSize(7.3,GlobalData.sizeScreen!), 0, 0, 0),
                   height: 1,
                   color: AppColors.colorLine):Container(),
                ValueListenableBuilder<ModelCalculatePrice>(
                  valueListenable: _notifier,
                  builder: (context,data,widget){
                    _calculateList.clear();
                    _calculateList.add(ModelServiceFromCalculate(id: 0,type: 'test',name: 'Въезд-Выезд',price: 0,oldPrice: 0));
                    if(_editStatusMain==GlobalData.EDIT_MODE&&!_isAddService){
                      _listService.clear();
                      _listService.add(ModelService(listServices:[],id: 0, type: 'service', name: 'Въезд-Выезд', isDetailing: false, price: 0, time: 0));
                    }
                    data.list.forEach((element) {
                      _calculateList.add(element);
                      if(_editStatusMain==GlobalData.EDIT_MODE&&!_isAddService){
                        _listService.add(ModelService(listServices: [], id: element.id, type: element.type, name: element.name, isDetailing: false, price: element.price, time: 0));
                      }
                    });

                    // if(data.saleName!='test'){
                    //   data.list.forEach((element) {
                    //     _calculateList.add(element);
                    //     if(_editStatusMain==GlobalData.EDIT_MODE&&!_isAddService){
                    //       _listService.add(ModelService(listServices: [], id: element.id, type: element.type, name: element.name, isDetailing: false, price: element.price, time: 0));
                    //     }
                    //   });
                    //
                    // }

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
                                _getPrice(edit:true,context: context, carType: _typeCarInt, servicesIds: _idServiceList, complexesIds: _idComplexList);
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

  @override
  void initState() {
    super.initState();
    if(_isEdit){
      widget.callback(true);
    }

  }


}

  class ItemClient extends StatefulWidget{

  final ModelOrderShow? modelOrderShow;
  var callback=(bool? hide)=>hide;



  @override
  State<ItemClient> createState() => _ItemClientState();

  ItemClient.editOrder({required this.callback,required this.modelOrderShow});

    ItemClient({this.modelOrderShow});
}


class _ItemClientState extends State<ItemClient> {

  TextEditingController? telController;
  TextEditingController? nameController;
  TextEditingController? surnameController;
  TextEditingController? patronymicControler;
  late FocusNode myFocusNodeTel;
  late FocusNode myFocusNodeName;
  late FocusNode myFocusNodeSurname;
  late FocusNode myFocusNodePatronymic;
  final _UsNumberTextInputFormatter _inputFormatter=_UsNumberTextInputFormatter();

  @override
  void initState() {
    super.initState();
    telController=TextEditingController();
    nameController=TextEditingController();
    surnameController=TextEditingController();
    patronymicControler=TextEditingController();

    if(_editStatusMain==GlobalData.EDIT_MODE||_editStatusMain==GlobalData.VIEW_MODE){
      telController!.text=widget.modelOrderShow!.clientPhone;
    }

    if(_editStatusMain==GlobalData.EDIT_MODE||_editStatusMain==GlobalData.VIEW_MODE&&widget.modelOrderShow!.clientFullname!='....'){
      if(widget.modelOrderShow!.clientFullname.split(' ').length==3){
        nameController!.text=widget.modelOrderShow!.clientFullname.split(' ')[1];
        surnameController!.text=widget.modelOrderShow!.clientFullname.split(' ')[0];
        patronymicControler!.text=widget.modelOrderShow!.clientFullname.split(' ')[2];
      }else if(widget.modelOrderShow!.clientFullname.split(' ').length==2){
        nameController!.text=widget.modelOrderShow!.clientFullname.split(' ')[1];
        surnameController!.text=widget.modelOrderShow!.clientFullname.split(' ')[0];
      }else if(widget.modelOrderShow!.clientFullname.split(' ').length==1){
        nameController!.text=widget.modelOrderShow!.clientFullname.split(' ')[0];
      }
    }

    myFocusNodeTel = FocusNode();
    myFocusNodeName=FocusNode();
    myFocusNodeSurname=FocusNode();
    myFocusNodePatronymic=FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    myFocusNodeTel.dispose();
    myFocusNodePatronymic.dispose();
    myFocusNodeName.dispose();
    myFocusNodeSurname.dispose();
    telController!.dispose();
    nameController!.dispose();
    surnameController!.dispose();
    patronymicControler!.dispose();
  }

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
                  child: SvgPicture.asset('assets/ic_client.svg'),
                  height: SizeUtil.getSize(2.5,GlobalData.sizeScreen!),),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(SizeUtil.getSize(2.0,GlobalData.sizeScreen!), 0, 0, 0),
                    child: Text('Клиент',
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
                  padding:EdgeInsets.fromLTRB(SizeUtil.getSize(7.5,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                  child: Row(
                    crossAxisAlignment: _editStatusMain!=GlobalData.VIEW_MODE?CrossAxisAlignment.start:CrossAxisAlignment.center,
                    children: [
                      Text('Телефон',
                          style: TextStyle(
                              color: AppColors.textColorItem,
                              fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                          )),

                      Expanded(
                        child: Padding(
                          padding:EdgeInsets.fromLTRB(SizeUtil.getSize(7.0,GlobalData.sizeScreen!), 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                          child: SizedBox(
                            height: _editStatusMain!=GlobalData.VIEW_MODE?SizeUtil.getSize(4.0, GlobalData.sizeScreen!):SizeUtil.getSize(4.0, GlobalData.sizeScreen!),
                            child: _editStatusMain!=GlobalData.VIEW_MODE?TextFormField(
                              validator: (value){
                                _validatePhoneNumber(value!);
                              },
                              onSaved: (value){

                              },
                              textAlign: TextAlign.start,
                                focusNode: myFocusNodeTel,
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(15),
                                  FilteringTextInputFormatter.digitsOnly,
                                  _inputFormatter
                            ],
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.phone,
                              style: TextStyle(
                                  color: AppColors.textColorPhone,
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeUtil.getSize(1.8,
                                      GlobalData.sizeScreen!)),
                              controller: telController,
                              decoration: InputDecoration(
                                filled: true,
                                  hintText: '....',
                                  prefixText: '+7 ',
                                  contentPadding: EdgeInsets.fromLTRB(SizeUtil.getSize(1.5, GlobalData.sizeScreen!),SizeUtil.getSize(0.0, GlobalData.sizeScreen!),SizeUtil.getSize(0.0, GlobalData.sizeScreen!)
                                  ,SizeUtil.getSize(1.7, GlobalData.sizeScreen!)),
                                  border: InputBorder.none),
                              onChanged: (text) {
                                   if(text.isNotEmpty){
                                     widget.callback(true);
                                     _order.update('clientPhone', (value) => text);
                                   }
                                }

                            ):Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.all(Radius.circular( SizeUtil.getSize(1.0, GlobalData.sizeScreen!)))
                              ),
                              child:
                              Text('${widget.modelOrderShow!.clientPhone}',
                                  style: TextStyle(
                                      color: AppColors.textColorPhone,
                                      fontWeight: FontWeight.bold,
                                      fontSize: SizeUtil.getSize(1.8,
                                          GlobalData.sizeScreen!))),
                            ),
                          ),
                        ),
                      ),
                      _editStatusMain!=GlobalData.VIEW_MODE?GestureDetector(
                        onTap: (){
                          myFocusNodeTel.requestFocus();
                        },
                        child: Icon(
                          Icons.edit,
                          color: AppColors.colorBackgrondProfile,
                        ),
                      ):Container(),
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
                      Text('Фамилия',
                          style: TextStyle(
                              color: AppColors.textColorItem,
                              fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                          )),
                      Expanded(
                        child: Padding(
                          padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                          child: SizedBox(
                            height:
                            SizeUtil.getSize(3.0, GlobalData.sizeScreen!),
                            child: _editStatusMain!=GlobalData.VIEW_MODE?
                            TextField(
                                textAlign: TextAlign.end,
                                focusNode: myFocusNodeSurname,
                                 textCapitalization: TextCapitalization.sentences,
                                style: TextStyle(
                                    color: AppColors.textColorPhone,
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeUtil.getSize(1.8,
                                        GlobalData.sizeScreen!)),
                                controller: surnameController,
                                decoration: InputDecoration(
                                    hintText: '....',
                                    contentPadding: EdgeInsets.all(
                                        SizeUtil.getSize(
                                            1.5,
                                            GlobalData
                                                .sizeScreen!)),
                                    border: InputBorder.none),
                                onChanged: (text) {
                                      if(text.isNotEmpty){
                                        widget.callback(true);
                                        _lastName=text;
                                      }
                                }

                            ):Text('${surnameController!.text==''?'....':surnameController!.text}',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: AppColors.textColorPhone,
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeUtil.getSize(1.8,
                                        GlobalData.sizeScreen!))),
                          )
                        ),
                      ),
                      _editStatusMain!=GlobalData.VIEW_MODE?GestureDetector(
                        onTap: (){
                          myFocusNodeSurname.requestFocus();
                        },
                        child: Icon(
                          Icons.edit,
                          color: AppColors.colorBackgrondProfile,
                        ),
                      ):Container(),
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
                      Text('Имя',
                          style: TextStyle(
                              color: AppColors.textColorItem,
                              fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                          )),
                      Expanded(
                        child: Padding(
                          padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                          child: SizedBox(
                            height:
                            SizeUtil.getSize(3.0, GlobalData.sizeScreen!),
                            child:  _editStatusMain!=GlobalData.VIEW_MODE?TextField(
                                textCapitalization: TextCapitalization.sentences,
                                textAlign: TextAlign.end,
                                focusNode: myFocusNodeName,
                                style: TextStyle(
                                    color: AppColors.textColorPhone,
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeUtil.getSize(1.8,
                                        GlobalData.sizeScreen!)),
                                controller: nameController,
                                decoration: InputDecoration(
                                    hintText: '....',
                                    contentPadding: EdgeInsets.all(
                                        SizeUtil.getSize(
                                            1.5,
                                            GlobalData
                                                .sizeScreen!)),
                                    border: InputBorder.none),
                                onChanged: (text) {
                                    if(text.isNotEmpty){
                                      widget.callback(true);
                                      _surName=text;
                                    }
                                }

                            ):Text('${nameController!.text==''?'....':nameController!.text}',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: AppColors.textColorPhone,
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeUtil.getSize(1.8,
                                      GlobalData.sizeScreen!))),
                          )
                        ),
                      ),
                      _editStatusMain!=GlobalData.VIEW_MODE?GestureDetector(
                        onTap: (){
                          myFocusNodeName.requestFocus();
                        },
                        child: Icon(
                          Icons.edit,
                          color: AppColors.colorBackgrondProfile,
                        ),
                      ):Container(),
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
                      Text('Отчество',
                          style: TextStyle(
                              color: AppColors.textColorItem,
                              fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                          )),
                      Expanded(
                        child: Padding(
                          padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                          child:SizedBox(
                            height:
                            SizeUtil.getSize(3.0, GlobalData.sizeScreen!),
                            child: _editStatusMain!=GlobalData.VIEW_MODE?TextField(
                                textCapitalization: TextCapitalization.sentences,
                                textAlign: TextAlign.end,
                                focusNode: myFocusNodePatronymic,
                                style: TextStyle(
                                    color: AppColors.textColorPhone,
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeUtil.getSize(1.8,
                                        GlobalData.sizeScreen!)),
                                controller: patronymicControler,
                                decoration: InputDecoration(
                                    hintText: '....',
                                    contentPadding: EdgeInsets.all(
                                        SizeUtil.getSize(
                                            1.5,
                                            GlobalData
                                                .sizeScreen!)),
                                    border: InputBorder.none),
                                onChanged: (text) {
                                     if(text.isNotEmpty){
                                       widget.callback(true);
                                       _patronymicName=text;
                                     }
                                }

                            ):Text('${patronymicControler!.text==''?'....':patronymicControler!.text}',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: AppColors.textColorPhone,
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeUtil.getSize(1.8,
                                        GlobalData.sizeScreen!))),
                          )
                        ),
                      ),
                      _editStatusMain!=GlobalData.VIEW_MODE?GestureDetector(
                        onTap: (){
                          myFocusNodePatronymic.requestFocus();
                        },
                        child: Icon(
                          Icons.edit,
                          color: AppColors.colorBackgrondProfile,
                        ),
                      ):Container(),

                    ],
                  ),
                ),

              ],
                  ),
                ),
              ],
            ),
          );


  }

  String? _validatePhoneNumber(String value) {
    final phoneExp = RegExp(r'^\(\d\d\d\) \d\d\d\-\d\d\-\d\d$');
    if (!phoneExp.hasMatch(value)) {
      return 'Не верный фомат';
    }
    return null;
  }
}

  class _UsNumberTextInputFormatter extends TextInputFormatter {
    @override
    TextEditingValue formatEditUpdate(
        TextEditingValue oldValue,
        TextEditingValue newValue,
        ) {
      final newTextLength = newValue.text.length;
      final newText = StringBuffer();
      var selectionIndex = newValue.selection.end;
      var usedSubstringIndex = 0;
      if (newTextLength >= 1) {
        newText.write('(');
        if (newValue.selection.end >= 1) selectionIndex++;
      }

      if (newTextLength >= 4) {
        newText.write(newValue.text.substring(0, usedSubstringIndex = 3) + ') ');
        if (newValue.selection.end >= 3) selectionIndex += 2;
      }
      if (newTextLength >= 7) {
        newText.write(newValue.text.substring(3, usedSubstringIndex = 6) + '-');
        if (newValue.selection.end >= 6) selectionIndex++;
      }

      if (newTextLength >= 9) {
        newText.write(newValue.text.substring(6, usedSubstringIndex = 8) + '-');
        if (newValue.selection.end >= 8) selectionIndex++;
      }
// Dump the rest.
      if (newTextLength >= usedSubstringIndex) {
        newText.write(newValue.text.substring(usedSubstringIndex));
      }
      return TextEditingValue(
        text: newText.toString(),
        selection: TextSelection.collapsed(offset: selectionIndex),
      );
    }
  }



   class ItemCar extends StatefulWidget{

  ModelOrderShow? modelOrderShow;
  var callback=(bool? hide)=>hide;

  @override
  State<ItemCar> createState() => _ItemCarState();

  ItemCar.editOrder({required this.callback,required this.modelOrderShow});
  ItemCar();
}


class _ItemCarState extends State<ItemCar> {
     String _typeCar = 'Седан';
     List<String> _listCarType=['Седан', 'Кроссовер', 'Внедорожник', 'Микроавтобус','Иное'];
     String _brandCar='.....';
     String _modelCar='.....';
     TextEditingController? numCarController;
     TextEditingController? regionCarController;
     Color _colorCar=Color.fromRGBO(77,77,77, 1.0);
     int? _index;
     int? _idBrand;
     bool _isFirstData=true;
     late FocusNode focusEditColor;
     late TextEditingController editingControllerColor;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(_editStatusMain==GlobalData.EDIT_MODE&&_isFirstData){
      _typeCar= _getType(widget.modelOrderShow!.carType);
      _isFirstData=false;
    }

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
                 child: SvgPicture.asset('assets/ic_car.svg'),
                 height: SizeUtil.getSize(2.5,GlobalData.sizeScreen!),),
               Expanded(
                 child: Padding(
                   padding: EdgeInsets.fromLTRB(SizeUtil.getSize(2.0,GlobalData.sizeScreen!), 0, 0, 0),
                   child: Text('Автомобиль',
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
                           child: _editStatusMain!=GlobalData.VIEW_MODE? TextButton(
                                    onPressed: () {
                                      showCupertinoModalPopup(
                                          context: context,
                                          builder: (_) => Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: SizeUtil.getSize(
                                                    15, GlobalData.sizeScreen!),
                                                child: CupertinoPicker(
                                                  backgroundColor: Colors.white,
                                                  itemExtent: 30,
                                                  scrollController:
                                                      FixedExtentScrollController(
                                                          initialItem: _typeCarInt-1),
                                                  children: [
                                                    Text('Седан'),
                                                    Text('Кроссовер'),
                                                    Text('Внедорожник'),
                                                    Text('Микроавтобус'),
                                                    Text('Иное')
                                                  ],
                                                  onSelectedItemChanged:
                                                      (value) {
                                                    setState(() {
                                                      _typeCar=_listCarType[value];
                                                      _typeCarInt=value+1;
                                                      _order.update('carType', (value) => _typeCarInt);
                                                      _getPrice(edit:true,context: context, carType: _typeCarInt, servicesIds: _idServiceList, complexesIds: _idComplexList);
                                                    });

                                                      },
                                                ),
                                              ));
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          _typeCar,
                                          style: TextStyle(
                                              color: AppColors.textColorPhone,
                                              fontWeight: FontWeight.bold,
                                              fontSize: SizeUtil.getSize(
                                                  2.0, GlobalData.sizeScreen!)),
                                        ),
                                    Icon(Icons.arrow_drop_down,
                                     color: Colors.black,)
                                      ],
                                    )):Padding(
                             padding: EdgeInsets.all(SizeUtil.getSize(0.6,GlobalData.sizeScreen!)),
                             child: Text('${_getType(widget.modelOrderShow!.carType)}',
                             style: TextStyle(
                                 fontWeight: FontWeight.bold,
                                 fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                             ),),
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
                           child: _editStatusMain!=GlobalData.VIEW_MODE?Row(
                             mainAxisAlignment: MainAxisAlignment.end,
                             children: [
                               Container(
                                 height: SizeUtil.getSize(4.0,GlobalData.sizeScreen!),
                                 width: SizeUtil.getSize(13,GlobalData.sizeScreen!),
                                 child: _inputNumCar()
                               ),
                               Container(
                                 height: SizeUtil.getSize(4.0,GlobalData.sizeScreen!),
                                 width: SizeUtil.getSize(8,GlobalData.sizeScreen!),
                                 child: TextField(
                                   inputFormatters: [
                                     LengthLimitingTextInputFormatter(3),
                                   ],
                                   textAlign: TextAlign.center,
                                   style: TextStyle(
                                       fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                                   ),
                                   controller: regionCarController,
                                   onChanged: (text){
                                       if(text.isNotEmpty){
                                         widget.callback(true);
                                         _order.update('carRegion', (value) => int.parse(text));
                                       }else{
                                         _order.update('carRegion', (value) =>0);
                                       }
                                   },
                                   keyboardType: TextInputType.number,
                                   decoration: InputDecoration(
                                     contentPadding: EdgeInsets.all(SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                                       border: OutlineInputBorder(borderRadius: BorderRadius.only(topRight:Radius.circular(10),bottomRight: Radius.circular(10))),

                                   ),
                                 ),
                               ),

                             ],
                           ):Row(
                             mainAxisAlignment: MainAxisAlignment.end,
                             children: [
                               Container(
                                 decoration: BoxDecoration(
                                     border: Border.all(color: Colors.black),
                                   borderRadius: BorderRadius.only(topLeft:Radius.circular(10),bottomLeft: Radius.circular(10))
                                 ),
                                 alignment: Alignment.center,
                                 height: SizeUtil.getSize(4.0,GlobalData.sizeScreen!),
                                 width: SizeUtil.getSize(13,GlobalData.sizeScreen!),
                                 child: Text('${widget.modelOrderShow!.carNumber}'),
                               ),
                               Container(
                                 decoration: BoxDecoration(
                                   border: Border.all(color: Colors.black),
                                   borderRadius: BorderRadius.only(topRight:Radius.circular(10),bottomRight: Radius.circular(10))
                                 ),
                                 alignment: Alignment.center,
                                 height: SizeUtil.getSize(4.0,GlobalData.sizeScreen!),
                                 width: SizeUtil.getSize(8,GlobalData.sizeScreen!),
                                 child: Text('${widget.modelOrderShow!.carRegion}'),
                               ),
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

               Padding(
                 padding:EdgeInsets.fromLTRB(SizeUtil.getSize(7.5,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                 child: Row(
                   children: [
                     Text('Марка ТС',
                         style: TextStyle(
                             color: AppColors.textColorItem,
                             fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                         )),
                     Expanded(
                       child: Padding(
                         padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                         child: Text(_brandCar,
                             textAlign: TextAlign.end,
                             style: TextStyle(
                                 color: AppColors.textColorPhone,
                                 fontWeight: FontWeight.bold,
                                 fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                             )),
                       ),
                     ),
                     _editStatusMain!=GlobalData.VIEW_MODE?Align(
                       alignment: Alignment.centerRight,
                       child: GestureDetector(
                         onTap: (){
                           _modelCar='.....';
                            Navigator.push(context, SlideTransitionLift(SearchBrand.brand(id: 0,
                              onSelected: (id,brand){
                                 setState(() {
                                   _idBrand=id;
                                   _brandCar=brand;
                                   widget.callback(true);
                                   _order.update('carBrandId', (value) => _idBrand);
                                 });
                            },)));
                         },
                         child: Icon(
                           Icons.arrow_forward_ios,
                           color: AppColors.colorIndigo,
                         ),
                       ),
                     ):Container(),
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
                     Text('Модель ТС',
                         style: TextStyle(
                             color: AppColors.textColorItem,
                             fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                         )),
                     Expanded(
                       child: Padding(
                         padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                         child: Text(_modelCar,
                             textAlign: TextAlign.end,
                             style: TextStyle(
                                 color: AppColors.textColorPhone,
                                 fontWeight: FontWeight.bold,
                                 fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                             )),
                       ),
                     ),
                     _editStatusMain!=GlobalData.VIEW_MODE?Align(
                       alignment: Alignment.centerRight,
                       child: GestureDetector(
                         onTap: (){
                           if(_brandCar!='.....'){
                             Navigator.push(context, SlideTransitionLift(SearchBrand.model(
                                 id:_idBrand!,onSelected: (id,model){
                               setState(() {
                                 _modelCar=model;
                                 widget.callback(true);
                                 _order.update('carModelId', (value) => id);
                               });
                             })));
                           }else{
                             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                               content: Text('Выбери марку'),));
                           }
                         },
                         child: Icon(
                           Icons.arrow_forward_ios,
                           color: AppColors.colorIndigo,
                         ),
                       ),
                     ):Container(),
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
                     Text('Цвет',
                         style: TextStyle(
                             color: AppColors.textColorItem,
                             fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                         )),
                     _editStatusMain==GlobalData.ADD_ORDER_MODE?Expanded(
                       child: Padding(
                         padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                         child: Align(
                           alignment: Alignment.centerRight,
                           child: Container(
                             width: SizeUtil.getSize(5,GlobalData.sizeScreen!),
                             height: SizeUtil.getSize(2.5,GlobalData.sizeScreen!),
                             decoration: BoxDecoration(
                                 border: _index==1?Border.all(
                                   color: AppColors.colorsCar[0],
                                   width: 0.5,
                                 ):null,
                               color: _colorCar,
                               borderRadius: BorderRadius.all(Radius.circular(10))
                             ),
                           ),
                         )
                       ),
                     ):Expanded(
                       child: Padding(
                           padding:EdgeInsets.fromLTRB(0, 0, 0, SizeUtil.getSize(1.2, GlobalData.sizeScreen!)),
                           child: SizedBox(
                             height:
                             SizeUtil.getSize(5.0, GlobalData.sizeScreen!),
                             child: TextField(
                                 textAlign: TextAlign.end,
                                 focusNode: focusEditColor,
                                 keyboardType: _editStatusMain!=GlobalData.VIEW_MODE?TextInputType.text:TextInputType.none,
                                 style: TextStyle(
                                     color: AppColors.textColorPhone,
                                     fontWeight: FontWeight.bold,
                                     fontSize: SizeUtil.getSize(1.8,
                                         GlobalData.sizeScreen!)),
                                 controller: editingControllerColor,
                                 decoration: InputDecoration(
                                     hintText: '....',
                                     contentPadding: EdgeInsets.all(
                                         SizeUtil.getSize(
                                             1.5,
                                             GlobalData
                                                 .sizeScreen!)),
                                     border: InputBorder.none),
                                 onChanged: (text) {
                                   if(text.isNotEmpty){
                                     _lastName=text;
                                   }
                                 }

                             ),
                           )
                       ),
                     ),
                     _editStatusMain==GlobalData.ADD_ORDER_MODE?Align(
                       alignment: Alignment.centerRight,
                       child: GestureDetector(
                         onTap: (){
                           showMaterialModalBottomSheet(
                             backgroundColor: Colors.white,
                               context: context,
                               builder: (context) => BottomSheetColorContent(
                                 onColorCar: (color,index){
                                    setState(() {
                                      _index=index;
                                      _colorCar=color!;
                                      if(_index==0) {
                                        _order.update('color', (value) => 'Черный');
                                      }else if(_index==1){
                                        _order.update('color', (value) => 'Белый');
                                      }else if(_index==2){
                                        _order.update('color', (value) => 'Серый');
                                      }else if(_index==3){
                                        _order.update('color', (value) => 'Красный');
                                      }else if(_index==4){
                                        _order.update('color', (value) => 'Синий');
                                      }else if(_index==5){
                                        _order.update('color', (value) => 'Желтый');
                                      }else if(_index==6){
                                        _order.update('color', (value) => 'Фиолетовый');
                                      }else if(_index==7){
                                        _order.update('color', (value) => 'Зеленый');
                                      }else if(_index==8){
                                        _order.update('color', (value) => 'Коричневый');
                                      }else if(_index==9){
                                        _order.update('color', (value) => 'Оранжевый');
                                      }
                                      widget.callback(true);
                                    });
                               },));
                         },
                         child: Icon(
                           Icons.arrow_forward_ios,
                           color: AppColors.colorIndigo,
                         ),
                       ),
                     ):GestureDetector(
                       onTap: (){
                         focusEditColor.requestFocus();
                       },
                       child: _editStatusMain!=GlobalData.VIEW_MODE?Icon(
                         Icons.edit,
                         color: AppColors.colorBackgrondProfile,
                       ):Container(),
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

     _inputNumCar(){
       return TextField(
         controller: numCarController,
         textCapitalization: TextCapitalization.characters,
         textAlign: TextAlign.center,
         inputFormatters: [
           LengthLimitingTextInputFormatter(6),
         ],
         style: TextStyle(
             fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
         ),
         onChanged: (text){
           if(text.isNotEmpty){
             widget.callback(true);
             _order.update('carNumber', (value) => text);
           }else{
             _order.update('carNumber', (value) => 'AA000A');
           }
         },
         decoration: InputDecoration(
           contentPadding: EdgeInsets.all(SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
           border: OutlineInputBorder(borderRadius: BorderRadius.only(topLeft:Radius.circular(10),bottomLeft: Radius.circular(10))),

         ),
       );
     }





     _getType(int id) {
       if (id == 1) {
         return 'Седан';
       } else if (id == 2) {
         return 'Кроссовер';
       } else if (id == 3) {
         return 'Внедорожник';
       } else if (id == 4) {
         return 'Микроавтобус';
       } else if (id == 5) {
         return 'Иное';
       }
     }

     @override
  void initState() {
    super.initState();
        focusEditColor=FocusNode();
        editingControllerColor=TextEditingController();
        numCarController=TextEditingController();
        regionCarController=TextEditingController();
        numCarController!.text=_editStatusMain==GlobalData.EDIT_MODE||_editStatusMain==GlobalData.VIEW_MODE?widget.modelOrderShow!.carNumber:'A000AA';
        regionCarController!.text=_editStatusMain==GlobalData.EDIT_MODE||_editStatusMain==GlobalData.VIEW_MODE?widget.modelOrderShow!.carRegion.toString():'000';
        if(_editStatusMain==GlobalData.EDIT_MODE||_editStatusMain==GlobalData.VIEW_MODE){
          _brandCar=widget.modelOrderShow!.carBrandtitle;
          _idBrand=widget.modelOrderShow!.carBrandid;
          _modelCar=widget.modelOrderShow!.carModeltitle;
          editingControllerColor.text=widget.modelOrderShow!.color;
        }
     }

     @override
  void dispose() {
    super.dispose();
    focusEditColor.dispose();
    editingControllerColor.dispose();
    numCarController!.dispose();
    regionCarController!.dispose();
     }
}




    class ItemDate extends StatefulWidget{

      String? time;
      int? post;
      int timeStartWash;
      int timeEndWash;
      var callback=(bool? hide)=>hide;

      ItemDate({required this.timeEndWash,required this.timeStartWash,required this.post, required this.time});
      ItemDate.editOrder({required this.callback,required this.timeEndWash,required this.timeStartWash,required this.post, required this.time});

  @override
  State<ItemDate> createState() => _ItemDateState();
}

class _ItemDateState extends State<ItemDate> {

   String? _timeStart;
   String? _timeEnd;
   bool _isSelected=true;
   late StateAddOrder _stateAddOrder;




  @override
  Widget build(BuildContext context) {
   if(_isSelected){
     _timeStart=widget.time!.split('-')[0];
     _timeEnd=widget.time!.split('-')[1];
     _isSelected=false;
   }

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
                    child: Text('Дата и время',
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
                  padding:EdgeInsets.fromLTRB(SizeUtil.getSize(7.5,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('${_date}',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: AppColors.textColorPhone,
                                      fontWeight: FontWeight.bold,
                                      fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                                  )),
                              _editStatusMain!=GlobalData.VIEW_MODE?Padding(
                                padding: EdgeInsets.fromLTRB(SizeUtil.getSize(1.0,GlobalData.sizeScreen!),0,0,0),
                                child:


                                Observer(
                                  builder: (_){
                                    if(_stateAddOrder.isLoad){
                                        return SizedBox(
                                            width: SizeUtil.getSize(2.0,GlobalData.sizeScreen!),
                                            height: SizeUtil.getSize(2.0,GlobalData.sizeScreen!),
                                            child: CircularProgressIndicator(
                                                strokeWidth: SizeUtil.getSize(0.2,GlobalData.sizeScreen!),
                                                color: AppColors
                                                    .colorBackgrondProfile));

                                    }else{
                                      return Row(
                                        children: [
                                          GestureDetector(
                                            onTap: (){
                                              //date picker
                                              DatePicker.showDatePicker(context,
                                                  showTitleActions: true,
                                                  minTime: DateTime(TimeParser.parseMinRecordTime()[0],TimeParser.parseMinRecordTime()[1],TimeParser.parseMinRecordTime()[2]),
                                                  maxTime: DateTime(TimeParser.parseMaxRecordTime()[0],TimeParser.parseMaxRecordTime()[1],TimeParser.parseMaxRecordTime()[2]),
                                                  onChanged: (date) {
                                                  },
                                                  onConfirm: (date) {
                                                    setState(() {
                                                      _dateValue=date.toString().split(' ')[0];
                                                      _order.update('date', (value) =>_dateValue);
                                                      _date=_dateValue;
                                                      _stateAddOrder.isWorkDay(context: context, date: _date!, idOrder:_id, post: _order['post']);
                                                    });

                                                  },
                                                  currentTime: DateTime(int.parse(_date!.split('-')[0]),int.parse(_date!.split('-')[1]),int.parse(_date!.split('-')[2])), locale: LocaleType.ru);
                                            },
                                            child:
                                            Icon(
                                              Icons.edit,
                                              color: AppColors.colorBackgrondProfile,
                                              size: SizeUtil.getSize(3.0,GlobalData.sizeScreen!),
                                            ),
                                          ),
                                          _stateAddOrder.isErrorDay?GestureDetector(
                                                        onTap: () {
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  _stateAddOrder
                                                                      .msgError,
                                                              toastLength: Toast
                                                                  .LENGTH_SHORT,
                                                              gravity:
                                                                  ToastGravity
                                                                      .CENTER,
                                                              timeInSecForIosWeb:
                                                                  2,
                                                              backgroundColor:
                                                                  Colors.white,
                                                              textColor:
                                                                  Colors.black,
                                                              fontSize: 16.0);
                                                        },
                                                        child: Icon(
                                                          Icons.error,
                                                          color: Colors.red,
                                                          size: SizeUtil.getSize(
                                                              2.2,
                                                              GlobalData
                                                                  .sizeScreen!),
                                                        ))
                                                    : Container()
                                              ],
                                      );

                                    }
                                  },

                                ),
                              ):Container(),
                            ],
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
                Padding(
                  padding:EdgeInsets.fromLTRB(SizeUtil.getSize(7.5,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                  child: Row(
                    children: [
                      Text('Время',
                          style: TextStyle(
                              color: AppColors.textColorItem,
                              fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                          )),
                      Expanded(
                        child: Padding(
                          padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('${TimeParser.parseHouForWidget(_timeStart!)}-${TimeParser.parseHouForWidget(_timeEnd!)}',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(color: AppColors.textColorPhone,
                                      fontWeight: FontWeight.bold,
                                      fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!))),
                              _editStatusMain!=GlobalData.VIEW_MODE?Padding(
                                padding: EdgeInsets.fromLTRB(SizeUtil.getSize(1.0,GlobalData.sizeScreen!),0,0,0),
                                child:
                                Observer(
                                    builder: (_){
                                      if(_stateAddOrder.isLoad){
                                        return SizedBox(
                                          width: SizeUtil.getSize(2.0,GlobalData.sizeScreen!),
                                            height: SizeUtil.getSize(2.0,GlobalData.sizeScreen!),
                                            child: CircularProgressIndicator(
                                              strokeWidth: SizeUtil.getSize(0.2,GlobalData.sizeScreen!),
                                                color: AppColors
                                                    .colorBackgrondProfile));
                                      } else {
                                        if(!_stateAddOrder.isErrorDay){
                                          if (!_stateAddOrder.isError) {
                                            return GestureDetector(
                                                onTap: (){
                                                  showMaterialModalBottomSheet(
                                                      backgroundColor: Colors.white,
                                                      context: context, builder:
                                                      (context)=>ContainerBottomSheetEditTime(
                                                        idOrder: _id,
                                                        date: _order['date'],
                                                    post: _order['post'],
                                                    modelTimeFreeIntervals: _stateAddOrder.modelTimeFreeIntervals,
                                                    onTimeSelect: (tStart,tEnd){
                                                      setState(() {
                                                        if(_timeStart!=tStart||_timeEnd!=tEnd){
                                                          _timeStart=tStart;
                                                          _timeEnd=tEnd;
                                                          _order.update('startTime', (value) => TimeParser.parseTimeForApi(_timeStart!));
                                                          _order.update('endTime', (value) =>  TimeParser.parseTimeForApi(_timeEnd!));
                                                          widget.callback(true);
                                                        }
                                                      });
                                                    },
                                                    time: '$_timeStart-$_timeEnd',timeStart: widget.timeStartWash,timeEnd: widget.timeEndWash,));
                                                },
                                                child:Icon(
                                                  Icons.edit,
                                                  color: AppColors
                                                      .colorBackgrondProfile,
                                                  size: SizeUtil.getSize(
                                                      3.0, GlobalData.sizeScreen!),
                                                ));
                                          } else {
                                            return GestureDetector(
                                                onTap: () {
                                                  Fluttertoast.showToast(
                                                      msg: _stateAddOrder.msgError,
                                                      toastLength: Toast
                                                          .LENGTH_SHORT,
                                                      gravity: ToastGravity
                                                          .CENTER,
                                                      timeInSecForIosWeb: 2,
                                                      backgroundColor: Colors
                                                          .white,
                                                      textColor: Colors.black,
                                                      fontSize: 16.0
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.error, color: Colors.red,
                                                  size: SizeUtil.getSize(2.2,
                                                      GlobalData.sizeScreen!),));
                                          }

                                        }else{
                                          return Container(
                                            width: SizeUtil.getSize(5.0,
                                                GlobalData.sizeScreen!),
                                            height: SizeUtil.getSize(2.2,
                                                GlobalData.sizeScreen!),
                                          );
                                        }
                                      }
                                    }



                              )):Container()
                            ],
                          ),
                        ),
                      ),
                      _order['startTime']>_order['endTime']&&_order['endTime']!=0?
                      GestureDetector(
                         onTap: (){
                           Fluttertoast.showToast(
                               msg: "Заказ переходит на след. день",
                               toastLength: Toast.LENGTH_SHORT,
                               gravity: ToastGravity.CENTER,
                               timeInSecForIosWeb: 2,
                               backgroundColor: Colors.white,
                               textColor: Colors.black,
                               fontSize: 16.0
                           );
                         },
                          child: Icon(Icons.error,color: Colors.red,size: SizeUtil.getSize(2.2,GlobalData.sizeScreen!),)):Container()

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
                      Text('№ поста',
                          style: TextStyle(
                              color: AppColors.textColorItem,
                              fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                          )),
                      Expanded(
                        child: Padding(
                          padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                          child:
                          Align(
                            alignment: Alignment.centerRight,
                            child:
                            TextButton(
                                onPressed: () {
                                  showCupertinoModalPopup(
                                      context: context,
                                      builder: (_) => Container(
                                        width: MediaQuery.of(context)
                                            .size
                                            .width,
                                        height: SizeUtil.getSize(15, GlobalData.sizeScreen!),
                                        child: CupertinoPicker(
                                          backgroundColor: Colors.white,
                                          itemExtent: 30,
                                          scrollController:
                                          FixedExtentScrollController(initialItem: _order['post']-1),
                                          children:
                                          List.generate(_getListPosts().length, (index){
                                              return Text('${index+1} пост');
                                            }),
                                          onSelectedItemChanged:
                                              (value) {
                                              setState(() {
                                                if(_order['post']!=value+1){
                                                  widget.post=value+1;
                                                  _order.update('post', (v) => value+1);
                                                  widget.callback(true);
                                                  _stateAddOrder.getTimeIntervalsFree(context: context, date: _date!, idOrder:_id, post: _order['post']);
                                                }
                                              });

                                          },
                                        ),
                                      ));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('${widget.post}',
                                      style: TextStyle(
                                          color: AppColors.textColorPhone,
                                          fontWeight: FontWeight.bold,
                                          fontSize: SizeUtil.getSize(
                                              2.0, GlobalData.sizeScreen!)),
                                    ),
                                    Icon(Icons.arrow_drop_down,
                                      color: Colors.black,)
                                  ],
                                ))
                          ),
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
     super.initState();
     _stateAddOrder=StateAddOrder();
     if(_editStatusMain!=GlobalData.VIEW_MODE){
       _stateAddOrder.getTimeIntervalsFree(context: context, date: _date!, idOrder: _id, post: _order['post']);
     }

   }

   _getListPosts(){
     List<int> posts=[];
     int u=0;
     for(int i=0;GlobalData.numBoxes!>i;i++){
       u++;
       posts.add(u);
     }
     return posts;
   }
}

    class Work extends StatefulWidget{

   ModelService modelService;
   List<ModelService> listServices;
   bool isEdit;
   bool isLoad=false;
   int i;
   ModelServiceFromCalculate modelCalculatePrice;
   var onRemove=(ModelService? model)=>model;
   Work({required this.listServices,required this.i,required this.isLoad,required this.modelCalculatePrice,required this.modelService,required this.isEdit,required this.onRemove});


  @override
  State<Work> createState() => _WorkState();
}

class _WorkState extends State<Work> with TickerProviderStateMixin{

   AnimationController? controller;


  @override
  Widget build(BuildContext context) {
   return  Column(
     children: [
       Padding(
         padding:EdgeInsets.fromLTRB(SizeUtil.getSize(7.5,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text(widget.modelCalculatePrice.name,
                 style: TextStyle(
                     color: AppColors.textColorItem,
                     fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                 )),
             Container(
               child: Padding(
                 padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                 child: widget.modelCalculatePrice.price==0?Align(
                     alignment: Alignment.centerRight,
                     child: SvgPicture.asset('assets/frame.svg')):Row(
                       mainAxisAlignment: MainAxisAlignment.end,
                       children: [
                         Text(!widget.isLoad?'${widget.modelCalculatePrice.price} RUB':'.... RUB',
                         textAlign: TextAlign.end,
                         style: TextStyle(
                             color: AppColors.textColorPhone,
                             fontWeight: FontWeight.bold,
                             fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                         )),
                         widget.isEdit?Padding(
                           padding: EdgeInsets.fromLTRB(SizeUtil.getSize(1.0,GlobalData.sizeScreen!),0,0,0),
                           child: GestureDetector(
                             onTap: (){
                               widget.onRemove(widget.modelService);
                             },
                             child: Container(
                               width: SizeUtil.getSize(2.2,GlobalData.sizeScreen!),
                               height: SizeUtil.getSize(2.2,GlobalData.sizeScreen!),
                               child: Center(child: Icon(Icons.remove,color: Colors.white,size: SizeUtil.getSize(1.5,GlobalData.sizeScreen!),)),
                               decoration: BoxDecoration(
                                 color: Colors.red,
                                 shape: BoxShape.circle
                               ),
                             ),
                           ),
                         ):Container()
                       ],
                     ),
               ),
             ),

           ],
         ),
       ),
       widget.modelCalculatePrice.type!='complex'?!widget.isLoad?Container(
           margin: EdgeInsets.fromLTRB(SizeUtil.getSize(7.3,GlobalData.sizeScreen!), 0, 0, 0),
           height: 1,
           color: AppColors.colorLine):
       LinearProgressIndicator(
         value: controller!.value,
         color: AppColors.colorIndigo,
       ):Container(),
       widget.modelCalculatePrice.type=='complex'&&getTextDetails(widget.listServices,widget.modelCalculatePrice.id).isEmpty?Container(
           margin: EdgeInsets.fromLTRB(SizeUtil.getSize(7.3,GlobalData.sizeScreen!), 0, 0, 0),
           height: 1,
           color: AppColors.colorLine):Container(),
       widget.modelCalculatePrice.type=='complex'&&getTextDetails(widget.listServices,widget.modelCalculatePrice.id).isNotEmpty?Container(
         width: MediaQuery.of(context).size.width,
         color: AppColors.colorLine,
         child: Padding(
           padding: EdgeInsets.all(SizeUtil.getSize(1.5,GlobalData.sizeScreen!)),
           child: Text('${getTextDetails(widget.listServices,widget.modelCalculatePrice.id)}',
             textAlign: TextAlign.center,
             style: TextStyle(
             color: AppColors.textColorDark_100
           ),
           ),
         ),
       ):Container()
     ],
   );

  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    //controller!.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
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

  class BottomSheetColorContent extends StatefulWidget{

   var onColorCar=(Color? color,int? index)=>color,index;

  @override
  StateBottomSheetColorContent createState() {
    // TODO: implement createState
    return StateBottomSheetColorContent();
  }

   BottomSheetColorContent({required this.onColorCar});
}

  class StateBottomSheetColorContent extends State<BottomSheetColorContent>{

   int? _selected;

  @override
  Widget build(BuildContext context) {
   return Container(
     height: MediaQuery.of(context).size.height/4.0,
     decoration: BoxDecoration(
       color: Colors.white,
       borderRadius: BorderRadius.only(topLeft: Radius.circular(SizeUtil.getSize(4.0,GlobalData.sizeScreen!)),topRight: Radius.circular(SizeUtil.getSize(4.0,GlobalData.sizeScreen!))),
     ),
     child: GridView(
         gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
             maxCrossAxisExtent: 80,
             childAspectRatio: 3 / 2,
             crossAxisSpacing: 10,
             mainAxisSpacing: 10
         ),
            children:
         List.generate(10, (index){
               return Container(
                 alignment: Alignment.center,
                   width: SizeUtil.getSize(10.0,GlobalData.sizeScreen!),
                   height: SizeUtil.getSize(10.0,GlobalData.sizeScreen!),
                   decoration: BoxDecoration(
                       border: _selected==index?Border.all(
                         color: AppColors.colorsCar[0],
                         width: 2,
                       ):null,
                       shape: BoxShape.circle,
                       color: Colors.transparent),
               child: GestureDetector(
                 onTap: (){
                     setState(() {
                       _selected=index;
                       widget.onColorCar(AppColors.colorsCar[index],index);
                       Navigator.pop(context);
                     });
                 },
                 child: Container(
                     width: SizeUtil.getSize(5.0,GlobalData.sizeScreen!),
                     height: SizeUtil.getSize(5.0,GlobalData.sizeScreen!),
                     decoration: BoxDecoration(
                         border: index==1?Border.all(
                           color: AppColors.colorsCar[0],
                           width: 0.5,
                         ):null,
                         shape: BoxShape.circle,
                         color: AppColors.colorsCar[index])),
               ),);
     })
    ,
   ));
  }

  }
