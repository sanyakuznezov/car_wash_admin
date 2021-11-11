import 'package:car_wash_admin/data/mapper/mapper_data_order_for_table.dart';
import 'package:car_wash_admin/domain/model/model_data_table.dart';
import 'package:car_wash_admin/domain/model/model_order.dart';
import 'package:car_wash_admin/internal/dependencies/repository_module.dart';
import 'package:car_wash_admin/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import '../../../global_data.dart';
import 'table_head.dart';
import 'table_body.dart';

class MultiplicationTable extends StatefulWidget {
  @override
  _MultiplicationTableState createState() => _MultiplicationTableState();
}

class _MultiplicationTableState extends State<MultiplicationTable> {
  late LinkedScrollControllerGroup _controllers;
  late ScrollController _headController;
  late ScrollController _bodyController;
  late ScrollController _bodyControllertop;


  @override
  void initState() {
    super.initState();
    _controllers = LinkedScrollControllerGroup();
    _headController = _controllers.addAndGet();
    _bodyController = _controllers.addAndGet();
    _bodyControllertop=_controllers.addAndGet();

  }

  @override
  void dispose() {
    _headController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ModelDataTable?>(
        future: RepositoryModule.userRepository().getDataSetting(context: context, date: GlobalData.date!),
        builder: (context,data){

          if (data.connectionState.index!=3) {
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: Colors.indigo,
              ),
            );
          }
          if (data.data == null||data.hasError) {
            return Container(
                alignment: Alignment.center,
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
                )
            );
          }

          return FutureBuilder<List<ModelOrder>?>(
            future: RepositoryModule.userRepository().getListOrder(context: context, date:GlobalData.date!),
              builder: (context,orders){
              if (orders.connectionState.index!=3) {
                  return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      color: Colors.indigo,
                    ),
                  );
                }
              if (orders.data == null||orders.hasError) {
                  return Container(
                      alignment: Alignment.center,
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
                      )
                  );
                }
              return Column(
                children: [
                  TableHead(posts: data.requireData!.posts,
                    scrollController: _headController,
                  ),
                  Expanded(
                      child: Container(
                        // width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.all(10.0),
                        child: TableBody(
                          orderList: MapperDataOrderForTable.fromApi(list: orders.requireData!),
                         // orderList: GlobalData.dataOrdersList,
                          modelDataTable: data.requireData!,
                          scrollController_top: _bodyControllertop,
                          scrollController: _bodyController,
                        ),)),
                ],
              );


              });

    });



  }


}
