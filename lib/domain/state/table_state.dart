



 import 'dart:async';

import 'package:car_wash_admin/domain/model/model_data_table.dart';
import 'package:car_wash_admin/internal/dependencies/repository_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobx/mobx.dart';

import '../../global_data.dart';
 part 'table_state.g.dart';

class TableState=TableStateBase with _$TableState;

abstract class TableStateBase with Store{



  @observable
  ModelDataTable? modelDataTable;

  @observable
  bool isLoading = false;

  @observable
  bool isError = false;

  @observable
  String msgError='';

  Timer? _timer;
  int i=3;

  @action
  settingsRequest({required BuildContext context,required String date}){
    getSettings(context: context, date: date);
    _timer=Timer.periodic(Duration(minutes: 10), (timer) {
      if(!GlobalData.edit_mode){
        getSettings(context: context, date: date);
      }
    });

  }


  @action
 Future<void> editOrderJournal({required String endAt,required String startAt,required BuildContext context,required int idOrder,required int post}) async{
    isLoading=true;
     final result=await RepositoryModule.userRepository().editOrderJournal(endAt: endAt, startAt: startAt, context: context, idOrder: idOrder, post: post).catchError((error){
       Fluttertoast.showToast(
           msg: "Ошибка изменения данных",
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.CENTER,
           timeInSecForIosWeb: 3,
           backgroundColor: Colors.red,
           textColor: Colors.white,
           fontSize: 16.0
       );
       isLoading=false;
     });
    if(result==null){
      isLoading=false;
    }
     if(result!){
       isLoading=false;
       Fluttertoast.showToast(
           msg: "Данные успешно изменены",
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.CENTER,
           timeInSecForIosWeb: 3,
           backgroundColor: Colors.black,
           textColor: Colors.white,
           fontSize: 16.0
       );
     }else{
       Fluttertoast.showToast(
           msg: "Данные успешно изменены",
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.CENTER,
           timeInSecForIosWeb: 3,
           backgroundColor: Colors.red,
           textColor: Colors.white,
           fontSize: 16.0
       );
       isLoading=false;
     }

  }

  @action
  dispose(){
    _timer!.cancel();
  }

  Future<void> getSettings({required BuildContext context,required String date}) async{
   isLoading=true;
   final result=await RepositoryModule.userRepository().getDataSetting(context: context, date: date)
       .catchError((error){
     isError=true;
     isLoading=false;
     msgError='Ошибка получения данных';
   });
   if(result==null){
     isError=true;
     isLoading=false;
     msgError='Ошибка получения данных';
   }
   modelDataTable=result;
   GlobalData.maxRecordRange=modelDataTable!.maxRecordRange;
   GlobalData.numBoxes=modelDataTable!.posts;
   // modelDataTable!.startDayMin=360;
   //modelDataTable!.endDayMin=1290;
   GlobalData.endDayMin=modelDataTable!.endDayMin;
   GlobalData.startDayMin=modelDataTable!.startDayMin;
   print('Work day ${GlobalData.startDayMin} - ${GlobalData.endDayMin}');
   isLoading=false;
  }


}