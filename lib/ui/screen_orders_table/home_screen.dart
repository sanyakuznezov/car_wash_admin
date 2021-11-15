

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



