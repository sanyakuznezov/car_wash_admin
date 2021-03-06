




import 'dart:async';
import 'dart:convert';
import 'package:car_wash_admin/domain/state/bloc_verify_user.dart';
import 'package:car_wash_admin/ui/global_widgets/dialogs.dart';
import 'package:car_wash_admin/ui/screen_orders_table/home_screen.dart';
import 'package:car_wash_admin/utils/state_network.dart';
import 'package:connectivity/connectivity.dart';
import 'package:crypto/crypto.dart';
import 'package:car_wash_admin/internal/dependencies/repository_module.dart';
import 'package:car_wash_admin/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../global_data.dart';

class PageAuth extends StatefulWidget{

 final bool? valid;

  @override
  StatePageAuth createState() {
    // TODO: implement createState
   return StatePageAuth();
  }

  PageAuth({this.valid});


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
    bool _isObscure = true;



  @override
  Widget build(BuildContext context) {
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
              Text('????????',style: TextStyle(
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
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        }),
                    labelText: '????????????',
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
                      ButtonState.idle: Text('??????????',style: TextStyle(color: Colors.white),),
                      ButtonState.loading: Text("??????????????????????",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                      ButtonState.fail: Text("????????????",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                      ButtonState.success: Text("??????????????",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),)
                    },

                    stateColors: {
                      ButtonState.idle: Colors.indigo,
                      ButtonState.loading: Colors.blue.shade300,
                      ButtonState.fail: Colors.red.shade300,
                      ButtonState.success: Colors.green.shade400,
                    },
                    onPressed:() async {
                      if(await StateNetwork.initConnectivity()==2){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('?????????????????????? ?????????????????????? ?? ????????...'),));
                      }else{
                        if(_validateEmail(textControllerEmail!.text)==null&&_validatePassword(textControllerPassword!.text)==null){
                          setState(() {
                            _stateSingIn=1;
                          });
                          await RepositoryModule.userRepository().authorizationUser(email: textControllerEmail!.text, pass:generateMd5(textControllerPassword!.text))
                              .then((result) {
                            if(result!.token!.isNotEmpty){
                              _blocVerifyUser.saveDataTocken(result.guid!, result.token!,result.personals_carwash_id,result.personals_id);
                              Navigator.pop(context);
                              Navigator.push(context,  MaterialPageRoute(builder: (context) => MyHomePage(valid: true,userData: result)));

                            }


                          }).catchError((error) {
                            setState(() {
                              print('Error $error');
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('???????????????? ?????????? ?????? ????????????'),));
                              _stateSingIn=0;
                            });
                          });
                        }
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
                    child: GestureDetector(
                      onTap: (){
                        _launchURL('https://app.crmstep.ru/auth/reset');
                      },
                      child: Text(
                        '???????????? ????????????',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  )),
              SizedBox(
                height: SizeUtil.getSize(5,GlobalData.sizeScreen!),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('?????????? ?????????????????????????',
                      style: TextStyle(
                        color: Colors.black,
                      )),
                  Padding(padding: EdgeInsets.fromLTRB(SizeUtil.getSize(1, GlobalData.sizeScreen!), 0, 0, 0),
                    child: GestureDetector(
                      onTap: (){
                        _launchURL('https://app.crmstep.ru/auth/register');
                      },
                      child: Text('?????????????? ??????????????',
                          style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          )),
                    ),)

                ],
              )
            ],
          ),
        ):Container(width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
                    child: Image.asset(
                      "assets/car_wash.gif",
                      height: SizeUtil.getSize(10, GlobalData.sizeScreen!),
                      width: SizeUtil.getSize(10, GlobalData.sizeScreen!),
                    ),
                  )),
    );
  }

  String? _validateEmail(String value) {
    value = value.trim();
    if (textControllerEmail!.text != null) {
      if (value.isEmpty) {
        return '?????????????????? ????????';
      } else if (!value.contains(RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
        return '?????????????? ???????????????????? ?????????? ?????????????????????? ??????????';
      }
    }

    return null;
  }

  String? _validatePassword(String value) {
    value = value.trim();

    if (textControllerPassword!.text != null) {
      if (value.isEmpty) {
        return '?????????????????? ????????';
      } else if (value.length<6) {
        return '?????????????? ???? ?????????? ???????? ????????????????';
      } else if (value.length>48) {
        return '?????????????? ???? ?????????? 48 ????????????????';
      }
    }

    return null;
  }

    void _launchURL(String _url) async =>
        await canLaunch(_url) ? await launch(_url) : throw '???? ?????????????? ?????????????????? $_url';

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

    @override
  void dispose() {
   super.dispose();
  }



}