

 import 'dart:async';

import 'package:car_wash_admin/data/local_data_base/app_data_base.dart';
import 'package:car_wash_admin/domain/model/user_data.dart';
import 'package:car_wash_admin/domain/state/state_edit_data_user.dart';
import 'package:car_wash_admin/internal/dependencies/repository_module.dart';
import 'package:car_wash_admin/utils/size_util.dart';
import 'package:car_wash_admin/utils/state_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../app_colors.dart';
import '../../global_data.dart';

//TODO интеграция с сервером

class PageNumberEdit extends StatefulWidget{

  UserData? _userData;
  var onNewNumber=(String? name)=>name;

  @override
  StatePageNumberEdit createState() {
    // TODO: implement createState
  return StatePageNumberEdit();
  }

  PageNumberEdit(this._userData,{required this.onNewNumber});
}


class StatePageNumberEdit extends State<PageNumberEdit>{

  final _UsNumberTextInputFormatter _inputFormatter=_UsNumberTextInputFormatter();
   late TextEditingController telController;
   late FocusNode myFocusNodeTel;
  final _input=StreamController<int>();
  final _output=StreamController<int>();
  bool _isEdit=false;
  bool _isSave=false;
  bool _isControllerAdd=true;
  late String lastname;
  late String name;
  late String firstname;
  late String email;
  late String phone;
  StateEditDataUser? _stateEditDataUser;

  void _onStateLoad(int state){
    _output.sink.add(state);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        if(_isSave){
          widget.onNewNumber('+7 $phone');
        }
        return true;
      },
      child: Scaffold(
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
                              if(_isSave){
                                widget.onNewNumber('+7 $phone');
                              }
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
                          child:StreamBuilder(
                            stream: _output.stream,
                            builder: (BuildContext context, AsyncSnapshot<int> snapshot){
                              if(snapshot.hasData){
                                if(snapshot.data==1){
                                  return GestureDetector(
                                    onTap:(){

                                      if (_isEdit) {
                                        _editPhone('+7 $phone',lastname,
                                            name,
                                            firstname,
                                            email);
                                      }
                                    },
                                    child: Text(
                                      'Сохр.',
                                      style: TextStyle(
                                        color:
                                        AppColors.colorIndigo,
                                        fontSize: SizeUtil.getSize(
                                            2.3,
                                            GlobalData.sizeScreen!),
                                      ),
                                    ),
                                  );
                                }else if(snapshot.data==2){
                                  return SizedBox(
                                    height: SizeUtil.getSize(
                                        2.0,
                                        GlobalData.sizeScreen!),
                                    width: SizeUtil.getSize(
                                        2.0,
                                        GlobalData.sizeScreen!),
                                    child: CircularProgressIndicator(
                                      color: AppColors.colorIndigo,
                                      strokeWidth: SizeUtil.getSize(
                                          0.3,
                                          GlobalData.sizeScreen!),
                                    ),
                                  );

                                }else if(snapshot.data==0){
                                  return Container();
                                }
                              }

                              return Container();
                            },
                          )
                          ,
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
                                  height: SizeUtil.getSize(5.0, GlobalData.sizeScreen!),
                                  child: Observer(
                                      builder: (_) {
                                        if (_stateEditDataUser!.isLoad) {
                                          return Center(
                                              child: SizedBox(
                                                height: SizeUtil.getSize(
                                                    3.5, GlobalData.sizeScreen!),
                                                width: SizeUtil.getSize(
                                                    3.5, GlobalData.sizeScreen!),
                                                child: CircularProgressIndicator(
                                            color: AppColors.colorIndigo,
                                            strokeWidth: SizeUtil.getSize(
                                                  0.5, GlobalData.sizeScreen!),
                                          ),
                                              ));
                                        } else {
                                           lastname=_stateEditDataUser!.userData!.lastname;
                                           name=_stateEditDataUser!.userData!.firstname;
                                           email=_stateEditDataUser!.userData!.email;
                                           firstname=_stateEditDataUser!.userData!.patronymic;
                                           if (_isControllerAdd) {
                                             phone=_stateEditDataUser!.userData!.phone.substring(3,_stateEditDataUser!.userData!.phone.length);
                                            telController.text =phone;
                                            _isControllerAdd = false;
                                          }

                                          return TextFormField(
                                            validator: (value) {
                                              _validatePhoneNumber(value!);
                                            },
                                            onChanged: (text) {
                                              if (text.isNotEmpty) {
                                                phone=text;
                                                _isEdit = true;
                                                _input.sink.add(1);
                                              }
                                            },
                                            textAlign: TextAlign.start,
                                            focusNode: myFocusNodeTel,
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              _inputFormatter
                                            ],
                                            textInputAction: TextInputAction.next,
                                            keyboardType: TextInputType.phone,
                                            style: TextStyle(
                                                color: AppColors.textColorPhone,
                                                fontWeight: FontWeight.bold,
                                                fontSize: SizeUtil.getSize(
                                                    1.8, GlobalData.sizeScreen!)),
                                            controller: telController,
                                            decoration: InputDecoration(
                                                hintText: '....',
                                                prefixText: '+7 ',
                                                border: InputBorder.none),
                                          );
                                        }
                                      }),
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
    _input.close();
    _output.close();
  }

  @override
  void initState() {
    super.initState();
    _stateEditDataUser=StateEditDataUser();
    _stateEditDataUser!.getDataUserLocal();
    telController=TextEditingController();
    myFocusNodeTel = FocusNode();
    telController.text=widget._userData!.phone;
    _input.stream.listen(_onStateLoad);

  }

  _editPhone(String numberPhone,String lastname,String firstname,String patronymic,String email) async{
    if(await StateNetwork.initConnectivity()==2){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('Отсутствует подключение к сети...'),));
    }else{
      if(numberPhone.isNotEmpty){
        _input.sink.add(2);
        final result=await RepositoryModule.userRepository().uploadDataUser(phone:numberPhone,firstname: firstname, patronymic: patronymic, lastname: lastname, email: email)
            .catchError((error){
          _input.sink.add(0);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text('Ошибка загрузки...'),));
        });
        if(result){
          _input.sink.add(0);
          _isEdit=false;
          _isSave=true;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black,
            content: Text('Данные успешно изменены'),));
        }
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.black,
          content: Text('Поля не могут быть пустыми'),));
      }

    }


  }

  Future<UserData?> getDataUserLocal() async{
    final database = await $FloorAppDataBase.databaseBuilder('app_database.db').build();
    final userDao = database.userataDao;
    final result=await userDao.getDataUser();
    return result;
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
