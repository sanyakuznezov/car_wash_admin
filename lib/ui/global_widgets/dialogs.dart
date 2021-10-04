



 import 'package:flutter/material.dart';

class MainDialogs{


  static void showMaterialDialog(BuildContext context) {
     showDialog(
         context: context,
         builder: (context) {
           return AlertDialog(
             title: Text('Material Dialog'),
             content: Text('Hey! I am Coflutter!'),
             actions: <Widget>[
               TextButton(
                   onPressed: () {
                     dismissDialog(context);
                   },
                   child: Text('Close')),
               TextButton(
                 onPressed: () {
                   print('HelloWorld!');
                   dismissDialog(context);
                 },
                 child: Text('HelloWorld!'),
               )
             ],
           );
         });
   }

  static dismissDialog(BuildContext context) {
    Navigator.pop(context);
  }


 }