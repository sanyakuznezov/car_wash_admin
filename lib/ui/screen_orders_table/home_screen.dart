

import 'package:car_wash_admin/app_colors.dart';
import 'package:car_wash_admin/domain/model/user_data.dart';
import 'package:car_wash_admin/domain/state/bloc_page_route.dart';
import 'package:car_wash_admin/internal/dependencies/app_module.dart';
import 'package:car_wash_admin/ui/screen_profile/page_profile.dart';
import 'package:car_wash_admin/ui/screen_quick_order/page_qick_order.dart';
import 'package:car_wash_admin/utils/size_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../../global_data.dart';
import '../screen_information/screen_info.dart';
import 'table/multiplication_table.dart';

class MyHomePage extends StatefulWidget {
  bool valid;
  UserData userData;
  MyHomePage({Key? key,required this.valid,required this.userData}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{


  double? top;
  var _currentIndex = 0;
  late AnimationController _controller;

  static List<Widget> _widgetOptions =<Widget>[
    ScreenInfo(),
    PageQuickOrder(),
  ];



  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    AppModule.blocTable.streamSink.add(0);
    GlobalData.date=DateTime.now().toString().split(' ')[0];

  }


  @override
  void dispose() {
    super.dispose();
    AppModule.blocTable.disponse();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth=MediaQuery.of(context).size.width;
    return Scaffold(
       // backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            MultiplicationTable(),
            StreamBuilder<dynamic>(
              stream: AppModule.blocTable.editState,
              builder: (context, snapshot) {
                if(!snapshot.hasData||snapshot.data==1){
                  _controller.animateTo(0.0);
                }else{
                  _controller.animateBack(1.0);
                }
                return FadeTransition(
                  opacity: Tween(
                    begin: 1.0,
                    end: 0.0,
                  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn)),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      alignment: Alignment.center,
                      width: SizeUtil.getSize(15.0,GlobalData.sizeScreen!),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow:[
                              BoxShadow(
                                color: Colors.black.withOpacity(.15),
                                blurRadius: 30,
                                offset: Offset(0,10),
                              )]
                        ),
                        height: SizeUtil.getSize(7.0,GlobalData.sizeScreen!),
                        margin: EdgeInsets.all(SizeUtil.getSize(2.5,GlobalData.sizeScreen!)),
                        child: ListView.builder(
                            itemCount: 2,
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: screenWidth * .024),
                            itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  _currentIndex = index;
                                 // HapticFeedback.lightImpact();
                                  Navigator.push(context,SlideTransitionRight(_widgetOptions.elementAt(_currentIndex)));
                                },
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: Padding(
                                  padding: EdgeInsets.all(SizeUtil.getSize(1.3,GlobalData.sizeScreen!)),
                                  child: Center(
                                    child: Icon(listOfIcons[index],
                                      size: screenWidth*.08,
                                      color:AppColors.colorIndigo),
                                  ),
                                )))),
                  ),
                );
              }
            )
          ],
        ));
  }
}

List<IconData> listOfIcons = [
  Icons.info_outline,
  Icons.add,
];



//
// Column(
// children: [
// Expanded(
// flex: 1,
// child:
// Container(
// padding: EdgeInsets.fromLTRB(10,SizeUtil.getSize(6,GlobalData.sizeScreen!), 10, 10),
// color: AppColors.colorIndigo,
// child:
// Expanded(
// child:
// Column(
// children: [
// Row(
// children: [
// Expanded(
// child: Align(
// alignment: Alignment.centerLeft,
// child: GestureDetector(
// onTap: (){
// Navigator.push(
// context,
// SlideTransitionRight(PageProfile()),
// );
// },
// child: Icon(
// Icons.person,
// color: Colors.white,
// ),
// ),
// ),
// flex: 1,
// ),
// Expanded(
// child: Align(
// alignment: Alignment.centerRight,
// child: Padding(
// padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
// child: GestureDetector(
// onTap: (){
// Navigator.push(
// context,
// SlideTransitionRight(ScreenInfo()),
// );
// },
// child: Icon(
// Icons.info_outline,
// color: Colors.white,
// ),
// ),
// )),
// flex: 1,
// ),
// GestureDetector(
// onTap: (){
// Navigator.push(
// context,
// SlideTransitionRight(PageQuickOrder()),
// );
// },
// child: Icon(
// Icons.add,
// color: Colors.white,
// ),
// ),
// ],
// ),
// Expanded(child:
// Row(
// crossAxisAlignment: CrossAxisAlignment.end,
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Expanded(
// flex: 1,
// child:
// Container(
// margin: EdgeInsets.fromLTRB(0, 0, 0, 18),
// decoration: BoxDecoration(
// border:Border(
// top: BorderSide(width: 2.0, color: Colors.white),
// bottom: BorderSide(width: 2.0, color: Colors.white),
// ),
// ),
// height: 20,
// child: Icon(
// Icons.height,
// size: 15,
// color: Colors.white,
// ),
// )
// ),
// Expanded(
// flex: 5,
// child:
// Container(
// alignment: Alignment.center,
// height: 35,
// margin: EdgeInsets.all(10),
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(10),
// color: Colors.white
// ),
//
// child: ValueListenableBuilder<String>(
// valueListenable: _notifierDropdownButton,
// builder: (context,item,widget){
// return DropdownButton<String>(
// value: item,
// icon: const Icon(Icons.arrow_drop_down,
// color: Colors.black,),
// iconSize: 24,
// elevation: 16,
// style: TextStyle(color: Colors.black,
// fontWeight: FontWeight.bold,
// fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)),
// underline: Container(
// height: 2,
// color: Colors.transparent,
// ),
// onChanged: (String? newValue) {
// _notifierDropdownButton.value = newValue!;
// AppModule.blocTable.streamSink.add(state(newValue));
// },
// items: <String>['1 час', '30 минут', '15 минут', '5 минут']
//     .map<DropdownMenuItem<String>>((String value) {
// return DropdownMenuItem<String>(
// value: value,
// child: Text(value),
// );
// }).toList(),
// );
// },
// ),
//
// )),
// Expanded(
// flex: 1,
// child:
// Container(
// margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
// height: 20,
// child: Icon(
// Icons.calendar_today_outlined,
// color: Colors.white,
// ),
// )
// ),
// Expanded(
// flex: 5,
// child:
// Container(
// alignment: Alignment.center,
// margin: EdgeInsets.all(10),
// height: 35,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(10),
// color: Colors.white
// ),
// child: TextButton(
// onPressed: () {
// DatePicker.showDatePicker(context,
// showTitleActions: true,
// minTime: DateTime(2021, 6, 7),
// maxTime: DateTime(2025, 6, 7), onChanged: (date) {
// }, onConfirm: (date) {
// setState(() {
// GlobalData.date=date.toString().split(' ')[0];
// dateValue= dateFormat(date.weekday, date.month, date.day);
// });
//
// },
// currentTime: DateTime.now(), locale: LocaleType.ru);
// },
// child: Text(
// dateValue,
// style: TextStyle(color: Colors.black,
// fontWeight: FontWeight.bold,
// fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
// ),
// ))
// )),
// ],
// ))
// ],
// ))),
// ),
// Expanded(flex: 4, child: MultiplicationTable()),
// ],
// )
