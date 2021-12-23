


import 'package:car_wash_admin/domain/model/model_data_table.dart';
import 'package:car_wash_admin/domain/model/model_time_free_intervals.dart';
import 'package:car_wash_admin/internal/dependencies/repository_module.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
part 'state_add_order.g.dart';

 class StateAddOrder= StateAddOrderBase with _$StateAddOrder;

  abstract class StateAddOrderBase with Store{

   @observable
   bool isLoad=false;
   @observable
   bool isError=false;
   @observable
   bool isErrorDay=false;
   @observable
   ModelTimeFreeIntervals? modelTimeFreeIntervals;
   @observable
   String msgError='';
   ModelDataTable? modelDataTable;




   Future<void> getTimeIntervalsFree({required BuildContext context,required String date,required int idOrder,required int post}) async{
    print('getTimeIntervalsFree $idOrder $post $date');
    isLoad=true;
    isError=false;
    final result=await RepositoryModule.userRepository().getTimeFreeInterval(date: date, context: context, idOrder: idOrder, post: post).catchError((error){
     isError=true;
     isLoad=false;
     msgError='Ошибка загрузки доступных интервалов времени';
    });
    isLoad=false;
    if(result==null){
     isError=true;
     msgError='Ошибка загрузки доступных интервалов времени';
    }else{
     modelTimeFreeIntervals=result;
    }
   }

   Future<void> isWorkDay({required BuildContext context,required String date,required int idOrder,required int post})async{
    isLoad=true;
    isErrorDay=false;
    final result=await RepositoryModule.userRepository().getDataSetting(context: context, date: date)
        .catchError((error){
     isErrorDay=true;
     isLoad=false;
     msgError='Ошибка получения данных';
    });
    if(result==null){
     isErrorDay=true;
     isLoad=false;
     msgError='Ошибка получения данных';
    }
    modelDataTable=result;
    isLoad=false;
    if(!modelDataTable!.isWorkDay){
     isErrorDay=true;
     msgError='Не рабочий день';
    }else{
     getTimeIntervalsFree(context: context, date: date, idOrder: idOrder, post: post);
    }

   }

 }