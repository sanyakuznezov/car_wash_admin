

 import '../global_data.dart';

class TimeParser{

  static double shiftTime({required int time_start,required int timeStep}){
     double t=GlobalData.timeStepsConstant[timeStep]['coof'];
     int i=GlobalData.timeStepsConstant[timeStep]['time'];
     int? s=0;
     s=time_start-i;
     return s*t;
   }

   static parseSkrethTime(int y,int timeStep,String timeStart){
    var u=parseHour(timeStart);
     var result = y/GlobalData.timeStepsConstant[timeStep]['coof'];
    if(isMultipleOfFive(result)){
      var a=result/10;
      int b=a.toInt();
      var c=(b+1)-a;
      var d=c*10;
      var e;
      if(d<=2.5){
        e=d;
      }else{
        e=d-5;
      }
      result+=e;
    }
    var t=(u+result)/60;
     var i=t.toInt();
     var m=(result+u)-i*60;
     var h=m.toInt();
     String hour='';
     String minute='';
     if(i<10){
       hour='0$i';
     }else{
       hour=i.toString();
     }
     if(h<10){
       minute='0$h';
     }else{
       minute=h.toString();
     }
     return '2021-08-29 $hour:$minute';
   }

  static parseReverseTimeStart(int y,int timeStep){
    var result=y/GlobalData.timeStepsConstant[timeStep]['coof'];
    if(isMultipleOfFive(result)){
      var a=result/10;
      int b=a.toInt();
      var c=(b+1)-a;
      var d=c*10;
      var e;
      if(d<=2.5){
        e=d;
      }else{
        e=d-5;
      }
      result+=e;
    }
    var a = result/60;
    var i=a.toString().split('.')[0];
    var m=result.toInt()-int.parse(i)*60;
    String hour='';
    String minute='';
    if(int.parse(i)<10){
      hour='0$i';
    }else{
      hour=i;
    }
    if(m<10){
      minute='0$m';
    }else{
      minute=m.toString();
    }
    return '2021-08-29 $hour:$minute';
  }



 static parseReverseTimeEnd(int y,int bodyHeaght,int timeStep){
    var r=y/GlobalData.timeStepsConstant[timeStep]['coof'];
    var result=r+bodyHeaght/GlobalData.timeStepsConstant[timeStep]['coof'];
    if(isMultipleOfFive(result)){
      var a=result/10;
      int b=a.toInt();
      var c=(b+1)-a;
      var d=c*10;
      var e;
      if(d<=2.5){
        e=d;
      }else{
        e=d-5;
      }
      result+=e;
    }
    var a = result/60;
    var i=a.toString().split('.')[0];
    var m=result.toInt()-int.parse(i)*60;
    String hour='';
    String minute='';
    if(int.parse(i)<10){
      hour='0$i';
    }else{
      hour=i;
    }
    if(m<10){
      minute='0$m';
    }else{
      minute=m.toString();
    }
    return '2021-08-29 $hour:$minute';
  }

 static parseHour(String time) {
    String timeSplit = time.split(' ')[1];
    int hour = int.parse(timeSplit.split(':')[0]);
    int minute = int.parse(timeSplit.split(':')[1]);
    return hour * 60 + minute;
  }

  static parseHourForTimeLine(String time) {
    int hour = int.parse(time.split(':')[0]);
    int minute = int.parse(time.split(':')[1]);
    return hour * 60 + minute;
  }

  static parseHourEndCollision(double y,double timeStep,int bodyHeaght){
    var r=y/timeStep;
    var result=r+bodyHeaght/timeStep;
    return result.toInt()-20;
  }
  static parseHourStartCollision(String time){
    String timeSplit = time.split(' ')[1];
    int hour = int.parse(timeSplit.split(':')[0]);
    int minute = int.parse(timeSplit.split(':')[1]);
    return hour * 60 + minute;
  }

  static parseTimeStartFeedBack(double y,int timeStep){
    var result=y/GlobalData.timeStepsConstant[timeStep]['coof'];
    return result.toInt();
  }

  static parseTimeEndFeedBack(double y,int bodyHeaght,int timeStep){
    double k=GlobalData.timeStepsConstant[timeStep]['coof'];
    var r=y/k;
    var result=r+bodyHeaght/k;
    return result.toInt();
  }


 static bool isMultipleOfFive(double i){
    var u=i.toInt();
    var y=u/5;
    var s=y.toString().split('.')[1][0];
    print('s $s y $y');
    return int.parse(s)>0;
  }

  static double makeMultipleOfFive(double i){
    var result;
    var u=i.toInt();
    var y=u/5;
    var s=y.toString().split('.')[1][0];
    print('s $s y $y');
    if(int.parse(s)>0){
      var a=i/10;
      int b=a.toInt();
      var c=(b+1)-a;
      var d=c*10;
      var e;
      if(d<=2.5){
        e=d;
      }else{
        e=d-5;
      }
      result=i+e;
    }else{
      result=i;
    }

    return result;
  }


}

