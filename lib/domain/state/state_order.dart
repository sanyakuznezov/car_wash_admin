



  import 'package:car_wash_admin/domain/model/model_calculate_price.dart';
import 'package:car_wash_admin/domain/model/model_order_show.dart';
import 'package:car_wash_admin/internal/dependencies/repository_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
  part 'state_order.g.dart';

 class StateOrder=StateOrderBase with _$StateOrder;
abstract class StateOrderBase with Store{


  @observable
  ModelOrderShow? modelOrderShow;
  @observable
  bool isLoading=false;
  @observable
  bool isError=false;
  @observable
  bool isInitData=false;
  @observable
  bool isLoadPrice=false;
  @observable
  ModelCalculatePrice? modelCalculatePrice;

   @action
   dispose(){
     modelOrderShow=null;
     modelCalculatePrice=null;
   }
  @action
  Future<void>getPrice({required context, required int carType, required List<int> idServiceList,required List<int> idComplexList})async{
    isLoadPrice=true;
    final result=await RepositoryModule.userRepository().getPrice(context: context, carType:carType, servicesIds:idServiceList, complexesIds:idComplexList);
    modelCalculatePrice=result;
    isLoadPrice=false;
  }


  @action
  Future<void> getOrderShow({required BuildContext context,required int id})async{
    isLoading=true;
    final order=await RepositoryModule.userRepository().getOrderShow(context: context, id: id).catchError((error){
      isError=true;
    });
    modelOrderShow=order;
    isLoading=false;
  }


}