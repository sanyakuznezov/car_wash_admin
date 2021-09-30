




import 'dart:convert';
import 'package:car_wash_admin/domain/state/bloc_verify_user.dart';
import 'package:car_wash_admin/ui/screen_orders_table/home_screen.dart';
import 'package:crypto/crypto.dart';
import 'package:car_wash_admin/internal/dependencies/repository_module.dart';
import 'package:car_wash_admin/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:progress_state_button/progress_button.dart';

import '../../global_data.dart';

class PageAuth extends StatefulWidget{
  @override
  StatePageAuth createState() {
    // TODO: implement createState
   return StatePageAuth();
  }




  }


  class StatePageAuth extends State<PageAuth>{

    TextEditingController ?textControllerEmail;
    TextEditingController ?textControllerPassword;
    FocusNode ?textFocusNodeEmail;
    FocusNode ?textFocusNodePassword;
    bool _isEditingEmail = false;
    bool _isEditingPassword = false;
    int _stateSingIn=0;
    ButtonState stateOnlyText = ButtonState.idle;
   late BlocVerifyUser _blocVerifyUser=BlocVerifyUser();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: _stateSingIn==0?Container(
        padding: EdgeInsets.fromLTRB(0, SizeUtil.getSize(3,GlobalData.sizeScreen!), 0, 0),
        margin: EdgeInsets.all(SizeUtil.getSize(3, GlobalData.sizeScreen!)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width:SizeUtil.getSize(25,GlobalData.sizeScreen!),
              height: SizeUtil.getSize(25,GlobalData.sizeScreen!),
              child: SvgPicture.asset(
                'assets/banner.svg',
              ),
            ),
            SizedBox(
              height: SizeUtil.getSize(5,GlobalData.sizeScreen!),
            ),
            Text('Вход',style: TextStyle(
                fontSize: SizeUtil.getSize(3,GlobalData.sizeScreen!),
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),),
            Padding(
                child: Divider(
                    color: Colors.grey
                ),
                padding: EdgeInsets.fromLTRB(0, SizeUtil.getSize(1,GlobalData.sizeScreen!)
                    , 0, 0)),

            Padding(
              padding: EdgeInsets.fromLTRB(0, SizeUtil.getSize(1,GlobalData.sizeScreen!)
                  , 0, SizeUtil.getSize(3,GlobalData.sizeScreen!)),
              child: TextFormField(
                focusNode: textFocusNodeEmail,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                controller: textControllerEmail,
                autofocus: false,
                onChanged: (value) {
                  setState(() {
                    _isEditingEmail = true;
                  });
                },
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Email',
                  errorText: _isEditingEmail
                      ? _validateEmail(textControllerEmail!.text)
                      : null,
                  errorStyle: TextStyle(
                    fontSize: SizeUtil.getSize(1,GlobalData.sizeScreen!),
                    color: Colors.redAccent,
                  ),
                ),

              ),),
            Padding(
              padding:EdgeInsets.fromLTRB(0, SizeUtil.getSize(1,GlobalData.sizeScreen!)
                  , 0, SizeUtil.getSize(3,GlobalData.sizeScreen!)),
              child: TextFormField(
                focusNode: textFocusNodePassword,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                controller: textControllerPassword,
                obscureText: true,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Пароль',
                    errorText: _isEditingPassword
                        ? _validatePassword(textControllerPassword!.text)
                        : null,
                    errorStyle: TextStyle(
                      fontSize: SizeUtil.getSize(1,GlobalData.sizeScreen!),
                      color: Colors.redAccent,
                    )

                ),
                autofocus: false,
                onChanged: (value) {
                  setState(() {
                    _isEditingPassword = true;
                  });
                },

              ),),

            Padding(
                padding:EdgeInsets.fromLTRB(0, SizeUtil.getSize(4,GlobalData.sizeScreen!)
                    , 0,0),
                child:  ProgressButton(
                  stateWidgets: {
                    ButtonState.idle: Text('Войти',style: TextStyle(color: Colors.white),),
                    ButtonState.loading: Text("Авторизация",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                    ButtonState.fail: Text("Ошибка",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                    ButtonState.success: Text("Успешно",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),)
                  },

                  stateColors: {
                    ButtonState.idle: Colors.indigo,
                    ButtonState.loading: Colors.blue.shade300,
                    ButtonState.fail: Colors.red.shade300,
                    ButtonState.success: Colors.green.shade400,
                  },
                  onPressed:() async {
                      setState(() {
                         _stateSingIn=1;
                      });
                      if(_validateEmail(textControllerEmail!.text)==null&&_validatePassword(textControllerPassword!.text)==null){
                        await RepositoryModule.userRepository().authorizationUser(email: textControllerEmail!.text, pass:generateMd5(textControllerPassword!.text))
                            .then((result) {
                              if(result.token.isNotEmpty){
                                _blocVerifyUser.saveDataTocken(result.guid, result.token,result.personals_carwash_id,result.personals_id);
                                Navigator.pop(context);
                                  Navigator.push(context,  MaterialPageRoute(builder: (context) => MyHomePage()));

                              }


                        }).catchError((error) {
                          setState(() {
                            print('Error $error');
                            _stateSingIn=0;
                          });
                        });
                      }
                  },
                  state: ButtonState.idle,
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(
                    0,
                    SizeUtil.getSize(2, GlobalData.sizeScreen!),
                    0,
                    SizeUtil.getSize(3, GlobalData.sizeScreen!)),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Я забыл пароль',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )),
            SizedBox(
              height: SizeUtil.getSize(5,GlobalData.sizeScreen!),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Новый поьзователь?',
                    style: TextStyle(
                      color: Colors.black,
                    )),
                Padding(padding: EdgeInsets.fromLTRB(SizeUtil.getSize(1, GlobalData.sizeScreen!), 0, 0, 0),
                  child: Text('Создать аккаунт',
                      style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      )),)

              ],
            )
          ],
        ),
      ):Container(
        width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child:
          Center(
            child:
            CircularProgressIndicator(
              color: Colors.indigo,strokeWidth: 4,),))

    );
  }



  String? _validateEmail(String value) {
    value = value.trim();

    if (textControllerEmail!.text != null) {
      if (value.isEmpty) {
        return 'Заполните поле';
      } else if (!value.contains(RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
        return 'Введите корректный адрес электронной почты';
      }
    }

    return null;
  }

  String? _validatePassword(String value) {
    value = value.trim();

    if (textControllerPassword!.text != null) {
      if (value.isEmpty) {
        return 'Заполните поле';
      } else if (value.length<6) {
        return 'Введите не менее пяти символов';
      }
    }

    return null;
  }

    String generateMd5(String input) {
      return md5.convert(utf8.encode(input)).toString();
    }

    @override
  void initState() {
      textControllerEmail = TextEditingController();
      textControllerEmail!.text = '';
      textFocusNodeEmail = FocusNode();
      textControllerPassword = TextEditingController();
      textControllerPassword!.text = '';
      textFocusNodePassword = FocusNode();
  }
}