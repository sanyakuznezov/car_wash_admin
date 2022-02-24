

  import 'package:car_wash_admin/domain/state/bloc_page_route.dart';
import 'package:car_wash_admin/internal/dependencies/app_module.dart';
import 'package:car_wash_admin/ui/screen_add_order/page_add_order.dart';
import 'package:car_wash_admin/utils/size_util.dart';
import 'package:car_wash_admin/utils/time_parser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../global_data.dart';

class ContainerBottomSheet extends StatefulWidget{

  int post;
  String timeStart;
  String timeEnd;
  var onAccept=(int? i)=>i;
  var onCancellation=(int? i)=>i;
  int statusCode;
  int? statusOrder;


  @override
  StateContainerBottomSheet createState() {
    // TODO: implement createState
    return StateContainerBottomSheet();
  }

  ContainerBottomSheet({this.statusOrder,required this.statusCode,required this.post, required this.timeStart,required this.timeEnd,required this.onAccept,required this.onCancellation});
}

   class StateContainerBottomSheet extends State<ContainerBottomSheet>{

   bool _isCarryoverOrder=false;
   String _textMain='Переместить запись?';

  @override
  Widget build(BuildContext context) {
    if(TimeParser.parseStringTimeToInt(widget.timeEnd.split(' ')[1])>GlobalData.endDayMin||
        TimeParser.parseStringTimeToInt(widget.timeEnd.split(' ')[1])<TimeParser.parseStringTimeToInt(widget.timeStart.split(' ')[1])){
      _isCarryoverOrder=true;
      _textMain='Запись находится между двумя днями. Изменения разрешены только на странице редактирования';
    }else{
      if(widget.statusCode==1){
        _textMain='Редактировать запись?';
      }else if(widget.statusCode==2){
        _textMain='Недопустимое изменение?';
      }
    }
    return Container(
      padding: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/3.5,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
    topLeft:  const  Radius.circular(20.0),
    topRight: const  Radius.circular(20.0))
      ),
      child:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              !_isCarryoverOrder?Expanded(child: Text('Пост ${widget.post}',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: SizeUtil.getSize(2.5,GlobalData.sizeScreen!),
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),),):Container(),

              !_isCarryoverOrder?Expanded(child: Text('${parseHour(widget.timeStart)}-${TimeParser.parsingTime(widget.timeEnd.split(' ')[1])}',
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: SizeUtil.getSize(2.5,GlobalData.sizeScreen!),
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),),):Container(),
            ],
          ),
          !_isCarryoverOrder?SizedBox(
            height: SizeUtil.getSize(6,GlobalData.sizeScreen!))
              :SizedBox(height: SizeUtil.getSize(2,GlobalData.sizeScreen!)),
            Text('$_textMain',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: widget.statusCode==2||_isCarryoverOrder?Colors.red:Colors.grey,
                  fontSize: SizeUtil.getSize(2.3,GlobalData.sizeScreen!)),),
          !_isCarryoverOrder?SizedBox(
             height: SizeUtil.getSize(1.5,GlobalData.sizeScreen!),
           ):SizedBox(
            height: SizeUtil.getSize(3.0,GlobalData.sizeScreen!),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child:
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                  GlobalData.edit_mode=false;
                  AppModule.blocTable.streamSinkEdit.add(1);
                  widget.onCancellation(1);
                  Fluttertoast.showToast(
                      msg: "Заказ вернулся в исходное состояние",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                },
                child:  Text('ОТМЕНА',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: SizeUtil.getSize(2.5,GlobalData.sizeScreen!),
                  color: Colors.black,
                ),),

              )),
              Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                      if(_isCarryoverOrder){
                        GlobalData.edit_mode = false;
                        AppModule.blocTable.streamSinkEdit.add(1);
                        widget.onCancellation(1);
                        Navigator.push(context, SlideTransitionSize(
                            PageAddOrder(
                              editStatus:widget.statusOrder==11?GlobalData.VIEW_MODE:GlobalData.EDIT_MODE,
                              timeEndWash: 1440,
                              timeStartWash: 0,
                              post:widget.post,
                              time:'${parseHour(widget.timeStart)}-${TimeParser.parsingTime(widget.timeEnd.split(' ')[1])}',
                              date:GlobalData.date,
                              idOrder: GlobalData.idOrder)));
                      }else{
                        if(widget.statusCode!=2){
                          widget.onAccept(1);
                          GlobalData.edit_mode = false;
                          AppModule.blocTable.streamSinkEdit.add(1);
                        }
                      }

                    },
                child:  Text(widget.statusCode==2?'ПРОДОЛЖИТЬ':'ПОДТВЕРДИТЬ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: SizeUtil.getSize(2.5,GlobalData.sizeScreen!),
                      color: Colors.blue,

                    ),),
                )
              )
            ],
          )
        ],
      ),
    );
  }

   }

  parseHour(String time){
    return time.split(' ')[1];
  }