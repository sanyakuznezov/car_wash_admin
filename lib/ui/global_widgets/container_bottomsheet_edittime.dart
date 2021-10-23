


  import 'package:car_wash_admin/utils/size_util.dart';
import 'package:car_wash_admin/utils/time_parser.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../app_colors.dart';
import '../../global_data.dart';


 int getTMS(String time, List<String> minutes){
   String h=time.split('-')[0].split(':')[1];
   int i=-1;
   int result=0;
   minutes.forEach((element) {
     i++;
     if(element==h){
       result=i;
     }
   });

   return result;
  }

 int getTHS(String time,List<String> hours){
   String h=time.split('-')[0].split(':')[0];
   int i=-1;
   int result=0;
   hours.forEach((element) {
     i++;
     if(element==h){
       result=i;
     }
   });

   return result;
  }

  int getTME(String time, List<String> minutes){
    String h=time.split('-')[1].split(':')[1];
    int i=-1;
    int result=0;
    minutes.forEach((element) {
      i++;
      if(element==h){
        result=i;
      }
    });

    return result;
  }

 int getTHE(String time,List<String> hours){
    String h=time.split('-')[1].split(':')[0];
    int i=-1;
    int result=0;
     hours.forEach((element) {
       i++;
         if(element==h){
         result=i;
         }
     });

    return result;
  }




class ContainerBottomSheetEditTime extends StatefulWidget{

  String time;
  int timeStart;
  int timeEnd;
  var onTimeSelect=(String? tStart,String tEnd)=>tStart,tEnd;
  

  @override
  State<ContainerBottomSheetEditTime> createState() => _ContainerBottomSheetEditTimeState();
   ContainerBottomSheetEditTime({required this.onTimeSelect,required this.timeStart,required this.timeEnd,required this.time});
}



  class _ContainerBottomSheetEditTimeState extends State<ContainerBottomSheetEditTime>{

   String h='';
   String m='';
   String h1='';
   String m1='';
   String _timeStart='';
   String _timeEnd='';
   bool _isValidate=true;


   @override
  void initState() {
   super.initState();
   h=widget.time.split('-')[0].split(':')[0];
   m=widget.time.split('-')[0].split(':')[1];
   m1=widget.time.split('-')[1].split(':')[1];
   h1=widget.time.split('-')[1].split(':')[0];

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
        padding: EdgeInsets.all(20),
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height/4.0,
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: new BorderRadius.only(
    topLeft:  const  Radius.circular(20.0),
    topRight: const  Radius.circular(20.0))
    ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
      Text('Время начала',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppColors.textColorPhone,
              fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
          )),
              Text('Время окончания',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.textColorPhone,
                      fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                  )),
            ],
          ),
          SizedBox(
            height: SizeUtil.getSize(2.0,GlobalData.sizeScreen!),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TimeStart(widget.time,widget.timeStart,onTimeHour: (hour){
                setState(() {
                  h=hour!;
                  _isValidate=true;
                });
              },
              onTimeMin: (min){
                setState(() {
                  m=min!;
                  _isValidate=true;
                });

              },),
              TimeEnd(widget.time,h,m,
              onTimeMin: (min){
                m1=min!;
                _isValidate=true;
              },
              onTimeHour: (hour){
                h1=hour!;
                _isValidate=true;

              },)
            ],
          ),
          SizedBox(
            height: SizeUtil.getSize(5.0,GlobalData.sizeScreen!),
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
                        fontSize: SizeUtil.getSize(3,GlobalData.sizeScreen!),
                        color: Colors.black,
                      ),),

                  )),
              Expanded(
                  child: GestureDetector(
                    onTap: (){
                      _timeEnd='$h1:$m1';
                      _timeStart='$h:$m';
                      if(_timeEnd==_timeStart){
                        _isValidate=false;
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('Время начала и окончания заказа совпадают')));
                      }
                      if(isTime(_timeStart,_timeEnd)){
                        _isValidate=false;
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('Время начала больше чем время окончания')));
                      }

                      if(_isValidate){
                        Navigator.pop(context);
                        widget.onTimeSelect(_timeStart,_timeEnd);
                      }

                    },
                    child:  Text('ПРОДОЛЖИТЬ',
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

  bool isTime(String start,String end){
    int hour1 = int.parse(end.split(':')[0]);
    int minute1 = int.parse(end.split(':')[1]);
    int hour = int.parse(start.split(':')[0]);
    int minute = int.parse(start.split(':')[1]);
    int i1= hour1 * 60 + minute1;
    int i= hour * 60 + minute;
    return i>i1;
  }
}


   class TimeStart extends StatefulWidget{

     String time;
     int timeStart;
     var onTimeHour=(String? timeH)=>timeH;
     var onTimeMin=(String? timeM)=>timeM;
  
  @override
  State<TimeStart> createState() => _TimeStartState();

     TimeStart(this.time, this.timeStart,{required this.onTimeHour,required this.onTimeMin});
}

class _TimeStartState extends State<TimeStart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width:  SizeUtil.getSize(19.0,GlobalData.sizeScreen!),
      height: SizeUtil.getSize(6.0,GlobalData.sizeScreen!),
      decoration: BoxDecoration(
          color: AppColors.colorBackgrondProfile,
          borderRadius: BorderRadius.circular(SizeUtil.getSize(1.5,GlobalData.sizeScreen!))
      ),
      child: Row(
        mainAxisAlignment:MainAxisAlignment.center,
        children: [
          Container(
            width: SizeUtil.getSize(8.0,GlobalData.sizeScreen!),
            child: FutureBuilder<List<String>>(
              future: TimeParser.getListTimeHourStart(),
              builder: (context,hour){
                if(hour.hasData){
                  return CarouselSlider(
                    options: CarouselOptions(
                      onPageChanged: (i,j){
                        widget.onTimeHour(hour.data![i]);
                      },
                      initialPage: getTHS(widget.time, hour.data!),
                        scrollDirection: Axis.vertical,
                        height:SizeUtil.getSize(8.0,GlobalData.sizeScreen!) ),
                    items: hour.data!.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Text('$i',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppColors.textColorPhone,
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeUtil.getSize(4.0,GlobalData.sizeScreen!)
                              ));
                        },
                      );
                    }).toList(),
                  );
                }else{
                 return Text('--',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.textColorPhone,
                          fontWeight: FontWeight.bold,
                          fontSize: SizeUtil.getSize(4.0,GlobalData.sizeScreen!)
                      ));
                }
              },
            ),
          ),
          Text(
              ':',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.textColorPhone,
                  fontWeight: FontWeight.bold,
                  fontSize: SizeUtil.getSize(4.0,GlobalData.sizeScreen!)
              )),
          Container(
            width: SizeUtil.getSize(8.0,GlobalData.sizeScreen!),
            child: FutureBuilder<List<String>>(
              future: TimeParser.getListTimeMinuteStart(),
              builder: (comtext,minutes){
                if(minutes.hasData){
                  return CarouselSlider(
                    options: CarouselOptions(
                        onPageChanged: (i,j){
                          widget.onTimeMin(minutes.data![i]);
                        },
                      initialPage: getTMS(widget.time, minutes.data!),
                        scrollDirection: Axis.vertical,
                        height:SizeUtil.getSize(8.0,GlobalData.sizeScreen!)),
                    items: minutes.data!.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Text('$i',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppColors.textColorPhone,
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeUtil.getSize(4.0,GlobalData.sizeScreen!)
                              ));
                        },
                      );
                    }).toList(),
                  );
                }else{
                  return Text('--',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.textColorPhone,
                          fontWeight: FontWeight.bold,
                          fontSize: SizeUtil.getSize(4.0,GlobalData.sizeScreen!)
                      ));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

 class TimeEnd extends StatefulWidget{

   String time;
   String selH;
   String selM;
   var onTimeHour=(String? timeH)=>timeH;
   var onTimeMin=(String? timeM)=>timeM;
  
  @override
  State<TimeEnd> createState() => _TimeEndState();
  TimeEnd(this.time, this.selH,this.selM,{required this.onTimeMin,required this.onTimeHour});
}

class _TimeEndState extends State<TimeEnd> {




  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width:  SizeUtil.getSize(19.0,GlobalData.sizeScreen!),
      height: SizeUtil.getSize(6.0,GlobalData.sizeScreen!),
      decoration: BoxDecoration(
          color: AppColors.colorBackgrondProfile,
          borderRadius: BorderRadius.circular(SizeUtil.getSize(1.5,GlobalData.sizeScreen!))
      ),
      child: Row(
        mainAxisAlignment:MainAxisAlignment.center,
        children: [
          Container(
            width: SizeUtil.getSize(8.0,GlobalData.sizeScreen!),
            child: FutureBuilder<List<String>>(
              future: TimeParser.getListTimeHourEnd(widget.selH),
              builder: (context,hour){
                if(hour.hasData){

                  return CarouselSlider(
                    options: CarouselOptions(
                      onPageChanged: (i,k){
                        widget.onTimeHour(hour.data![i]);
                      },
                        scrollDirection: Axis.vertical,
                        initialPage: getTHE(widget.time, hour.data!),
                        height:SizeUtil.getSize(8.0,GlobalData.sizeScreen!) ),
                    items: hour.data!.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Text('$i',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppColors.textColorPhone,
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeUtil.getSize(4.0,GlobalData.sizeScreen!)
                              ));
                        },
                      );
                    }).toList(),
                  );
                }else{
                  return Text('--',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.textColorPhone,
                          fontWeight: FontWeight.bold,
                          fontSize: SizeUtil.getSize(4.0,GlobalData.sizeScreen!)
                      ));
                }
              },
            ),
          ),
          Text(
              ':',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.textColorPhone,
                  fontWeight: FontWeight.bold,
                  fontSize: SizeUtil.getSize(4.0,GlobalData.sizeScreen!)
              )),
          Container(
            width: SizeUtil.getSize(8.0,GlobalData.sizeScreen!),
            child: FutureBuilder<List<String>>(
              future: TimeParser.getListTimeMinuteEnd(),
              builder: (context,minutes){
                if(minutes.hasData){
                  return CarouselSlider(
                    options: CarouselOptions(
                        onPageChanged: (i,k){
                          widget.onTimeMin(minutes.data![i]);
                        },
                      initialPage: getTME(widget.time,minutes.data!),
                        scrollDirection: Axis.vertical,
                        height:SizeUtil.getSize(8.0,GlobalData.sizeScreen!)),
                    items: minutes.data!.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Text('$i',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppColors.textColorPhone,
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeUtil.getSize(4.0,GlobalData.sizeScreen!)
                              ));
                        },
                      );
                    }).toList(),
                  );
                }else{
                  return Text('--',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.textColorPhone,
                          fontWeight: FontWeight.bold,
                          fontSize: SizeUtil.getSize(4.0,GlobalData.sizeScreen!)
                      ));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
