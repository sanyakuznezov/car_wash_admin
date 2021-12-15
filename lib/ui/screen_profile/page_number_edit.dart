

 import 'package:car_wash_admin/domain/model/user_data.dart';
import 'package:car_wash_admin/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../app_colors.dart';
import '../../global_data.dart';

//TODO интеграция с сервером

class PageNumberEdit extends StatefulWidget{

  UserData? _userData;

  @override
  StatePageNumberEdit createState() {
    // TODO: implement createState
  return StatePageNumberEdit();
  }

  PageNumberEdit(this._userData);
}


class StatePageNumberEdit extends State<PageNumberEdit>{

  final _UsNumberTextInputFormatter _inputFormatter=_UsNumberTextInputFormatter();
   late TextEditingController telController;
   late FocusNode myFocusNodeTel;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBackgrondProfile,
      body: Column(
        children: [
          AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            actions: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.colorIndigo,
                          ),
                        ),
                      ),
                      Center(
                        child: Text('Номер телефона',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,
                              fontSize: SizeUtil.getSize(2.8,GlobalData.sizeScreen!)),),
                      ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: (){
                            myFocusNodeTel.requestFocus();
                          },
                          child: Text('Ред.',
                            style: TextStyle(
                                color: AppColors.colorIndigo,
                                fontSize: SizeUtil.getSize(2.3,GlobalData.sizeScreen!)
                            ),),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),

          Container(
            margin: EdgeInsets.fromLTRB(0,SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(0.8,GlobalData.sizeScreen!)),
            child: Column(
              children: [
                Align(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(SizeUtil.getSize(4.0,GlobalData.sizeScreen!),SizeUtil.getSize(2.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(2.0,GlobalData.sizeScreen!)),
                    child: Text('Телефон',
                        style: TextStyle(
                            color: AppColors.textColorTitle,
                            fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                        )),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding:EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Номер телефона',
                                style: TextStyle(
                                    color: AppColors.textColorItem,
                                    fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                                )),
                            Padding(
                              padding:EdgeInsets.fromLTRB(SizeUtil.getSize(7.0,GlobalData.sizeScreen!), 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                              child: Container(
                                width: SizeUtil.getSize(16.2, GlobalData.sizeScreen!),
                                height: SizeUtil.getSize(7.2, GlobalData.sizeScreen!),
                                child: TextFormField(
                                    validator: (value){
                                      _validatePhoneNumber(value!);
                                    },
                                    onSaved: (value){

                                    },
                                    maxLength: 15,
                                    textAlign: TextAlign.start,
                                    focusNode: myFocusNodeTel,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                      _inputFormatter
                                    ],
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.phone,
                                    style: TextStyle(
                                        color: AppColors.textColorPhone,
                                        fontWeight: FontWeight.bold,
                                        fontSize: SizeUtil.getSize(1.8,
                                            GlobalData.sizeScreen!)),
                                    controller: telController,
                                    decoration: InputDecoration(
                                        hintText: '....',
                                        prefixText: '+7 ',
                                        border: InputBorder.none),
                                    onChanged: (text) {
                                      if(text.isNotEmpty){

                                      }
                                    }
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )

        ],
      ),
    );
  }

  String? _validatePhoneNumber(String value) {
    final phoneExp = RegExp(r'^\(\d\d\d\) \d\d\d\-\d\d\-\d\d$');
    if (!phoneExp.hasMatch(value)) {
      return 'Не верный фомат';
    }
    return null;
  }


  @override
  void dispose() {
    super.dispose();
    myFocusNodeTel.dispose();
    telController.dispose();
  }

  @override
  void initState() {
    super.initState();
    telController=TextEditingController();
    myFocusNodeTel = FocusNode();
    telController.text=widget._userData!.phone;

  }


}

 class _UsNumberTextInputFormatter extends TextInputFormatter {
   @override
   TextEditingValue formatEditUpdate(
       TextEditingValue oldValue,
       TextEditingValue newValue,
       ) {
     final newTextLength = newValue.text.length;
     final newText = StringBuffer();
     var selectionIndex = newValue.selection.end;
     var usedSubstringIndex = 0;
     if (newTextLength >= 1) {
       newText.write('(');
       if (newValue.selection.end >= 1) selectionIndex++;
     }

     if (newTextLength >= 4) {
       newText.write(newValue.text.substring(0, usedSubstringIndex = 3) + ') ');
       if (newValue.selection.end >= 3) selectionIndex += 2;
     }
     if (newTextLength >= 7) {
       newText.write(newValue.text.substring(3, usedSubstringIndex = 6) + '-');
       if (newValue.selection.end >= 6) selectionIndex++;
     }

     if (newTextLength >= 9) {
       newText.write(newValue.text.substring(6, usedSubstringIndex = 8) + '-');
       if (newValue.selection.end >= 8) selectionIndex++;
     }
// Dump the rest.
     if (newTextLength >= usedSubstringIndex) {
       newText.write(newValue.text.substring(usedSubstringIndex));
     }
     return TextEditingValue(
       text: newText.toString(),
       selection: TextSelection.collapsed(offset: selectionIndex),
     );
   }
 }
