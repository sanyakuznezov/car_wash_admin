

  import 'package:car_wash_admin/internal/dependencies/app_module.dart';
import 'package:car_wash_admin/utils/size_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../global_data.dart';

class ContainerAddOrder extends StatefulWidget{


  var onAccept=(int? i)=>i;
  bool isEdit;




  @override
  StateContainerAddOrder createState() {
    // TODO: implement createState
    return StateContainerAddOrder();
  }

  ContainerAddOrder({required this.isEdit,required this.onAccept});
}

   class StateContainerAddOrder extends State<ContainerAddOrder>{
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/4.5,
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
          Text(!widget.isEdit?'Опубликовать заказ?':'Редактировать заказ?',
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: SizeUtil.getSize(2.5,GlobalData.sizeScreen!),
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),),
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
                      widget.onAccept(1);
                    },
                child:  Text('ПОДТВЕРДИТЬ',
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