

  import 'package:car_wash_admin/internal/dependencies/app_module.dart';
import 'package:car_wash_admin/utils/size_util.dart';
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


  @override
  StateContainerBottomSheet createState() {
    // TODO: implement createState
    return StateContainerBottomSheet();
  }

  ContainerBottomSheet({required this.statusCode,required this.post, required this.timeStart,required this.timeEnd,required this.onAccept,required this.onCancellation});
}

   class StateContainerBottomSheet extends State<ContainerBottomSheet>{
  @override
  Widget build(BuildContext context) {
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
              Expanded(child: Text('Пост ${widget.post}',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: SizeUtil.getSize(2.5,GlobalData.sizeScreen!),
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),),),

              Expanded(child: Text('${parseHour(widget.timeStart)}-${parseHour(widget.timeEnd)}',
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: SizeUtil.getSize(2.5,GlobalData.sizeScreen!),
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),),)
            ],
          ),
          SizedBox(
            height: SizeUtil.getSize(6,GlobalData.sizeScreen!),
          ),
            Text(widget.statusCode==0?'Переместить запись?':widget.statusCode==1?'Редактировать запись?':'Недопустимое изменение?',
              style: TextStyle(
                  color: widget.statusCode==2?Colors.red:Colors.grey,
                  fontSize: SizeUtil.getSize(2.3,GlobalData.sizeScreen!)),),
           SizedBox(
             height: SizeUtil.getSize(6,GlobalData.sizeScreen!),
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
                  fontSize: SizeUtil.getSize(3,GlobalData.sizeScreen!),
                  color: Colors.black,
                ),),

              )),
              Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                      if(widget.statusCode!=2){
                        Fluttertoast.showToast(
                            msg: "Запрос на сервер",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                        widget.onAccept(1);
                        GlobalData.edit_mode = false;
                        AppModule.blocTable.streamSinkEdit.add(1);
                      }
                    },
                child:  Text(widget.statusCode==2?'ПРОДОЛЖИТЬ':'ПОДТВЕРДИТЬ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: SizeUtil.getSize(3,GlobalData.sizeScreen!),
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