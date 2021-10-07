

  import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class SlideTransitionLift extends PageRouteBuilder{
  final Widget page;
  SlideTransitionLift(this.page) : super(
    pageBuilder: (context,animation,anotherAnimation){
        return page;
    },
    transitionDuration: Duration(milliseconds: 1000),
    reverseTransitionDuration: Duration(milliseconds: 400),
    transitionsBuilder: (context,animation,anotherAnimation,child){
        animation=CurvedAnimation(
          curve: Curves.fastLinearToSlowEaseIn,
          parent: animation,
          reverseCurve: Curves.fastOutSlowIn
        );
        return SlideTransition(position: Tween(begin: Offset(1.0,0.0),end: Offset(0.0,0.0)).animate(animation),
        child: page,);
    }
  );


}

  class SlideTransitionRight extends PageRouteBuilder{
    final Widget page;
    SlideTransitionRight(this.page) : super(
        pageBuilder: (context,animation,anotherAnimation){
          return page;
        },
        transitionDuration: Duration(milliseconds: 1000),
        reverseTransitionDuration: Duration(milliseconds: 400),
        transitionsBuilder: (context,animation,anotherAnimation,child){
          animation=CurvedAnimation(
              curve: Curves.fastLinearToSlowEaseIn,
              parent: animation,
              reverseCurve: Curves.fastOutSlowIn
          );
          return SlideTransition(position: Tween(begin: Offset(1.0,0.0),end: Offset(0.0,0.0)).animate(animation),
            textDirection: TextDirection.rtl,
            child: page,);
        }
    );


  }

  class SlideTransitionSize extends PageRouteBuilder{
    final Widget page;
    SlideTransitionSize(this.page) : super(
        pageBuilder: (context,animation,anotherAnimation){
          return page;
        },
        transitionDuration: Duration(milliseconds: 1000),
        reverseTransitionDuration: Duration(milliseconds: 200),
        transitionsBuilder: (context,animation,anotherAnimation,child){
          animation=CurvedAnimation(
              curve: Curves.fastLinearToSlowEaseIn,
              parent: animation,
              reverseCurve: Curves.fastOutSlowIn
          );
          return Align(
            alignment: Alignment.center,
            child: SizeTransition(
              axisAlignment: 0,
              axis: Axis.horizontal,
              sizeFactor: animation,
              child: page,),
          );
        }
    );


  }

