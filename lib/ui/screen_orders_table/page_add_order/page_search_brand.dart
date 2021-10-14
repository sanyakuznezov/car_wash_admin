


 import 'package:car_wash_admin/app_colors.dart';
import 'package:car_wash_admin/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';


import '../../../global_data.dart';

class SearchBrand extends StatefulWidget{
  @override
  StateSearchBrand createState() {
    // TODO: implement createState
   return StateSearchBrand();
  }


}


class StateSearchBrand extends State<SearchBrand>{

  String label = "Some Label";
  List<String> dummyList = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];
  TextEditingController myController = TextEditingController();


  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: AppColors.colorBackgrondProfile,
     body: Container(
        padding: EdgeInsets.fromLTRB(SizeUtil.getSize(2.0, GlobalData.sizeScreen!), SizeUtil.getSize(5.0, GlobalData.sizeScreen!),SizeUtil.getSize(2.0, GlobalData.sizeScreen!), 0),
        color: Colors.white,
       child: Wrap(
         children:[
           Column(
           children: [
             Row(
               children: [
             Expanded(
             child: Container(
               margin: EdgeInsets.all(SizeUtil.getSize(
                   1.0,
                   GlobalData.sizeScreen!)),
             decoration: BoxDecoration(
                 color: AppColors.colorBackgrondProfile,
                 borderRadius: BorderRadius.circular(SizeUtil.getSize(
                 1.0,
                 GlobalData.sizeScreen!))
             ),
               child: TextField(
               decoration: InputDecoration(
                 hintStyle: TextStyle(
                   color: Colors.grey
                 ),
                   hintText: 'Поиск',
                   border: InputBorder.none,
                   icon: Padding(
                     padding: EdgeInsets.all(SizeUtil.getSize(
                         1.0,
                         GlobalData.sizeScreen!)),
                     child: Icon(Icons.search,
                         color: Colors.grey),
                   )
               ),
                   controller: myController),
             )),
             GestureDetector(
               onTap:(){
                  Navigator.pop(context);
               },
               child: Text('Отмена',
                 style: TextStyle(
                   color:
                   AppColors.colorIndigo,
                   fontSize: SizeUtil.getSize(
                       2.3,
                       GlobalData.sizeScreen!),
                 ),
               ),
             )
               ],
             ),
             Column(
               children: List.generate(10, (index){
                 return ItemBrand();
               }),
             )

           ],
         ),]
       ),
     ),
   );
  }

  @override
  void initState() {

  }


}


 class ItemBrand extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding:  EdgeInsets.fromLTRB(SizeUtil.getSize(
          5.0,
          GlobalData.sizeScreen!), 0, 0, 0),
                child: Text('Марка 1',
                style:TextStyle(
                  color: Colors.black
                ),),
              ),
              Expanded(
                child: Align(
                    alignment: Alignment.centerRight,
                    child:SvgPicture.asset('assets/frame.svg')
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.fromLTRB(SizeUtil.getSize(
              5.0,
              GlobalData.sizeScreen!), 0, 0, 0),
          child: Divider(),)
        ],
      ),
    );
  }


 }