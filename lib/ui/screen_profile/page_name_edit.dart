


  import 'dart:async';

import 'package:car_wash_admin/app_colors.dart';
import 'package:car_wash_admin/data/local_data_base/app_data_base.dart';
import 'package:car_wash_admin/domain/model/user_data.dart';
import 'package:car_wash_admin/domain/state/bloc_page_route.dart';
import 'package:car_wash_admin/internal/dependencies/repository_module.dart';
import 'package:car_wash_admin/ui/screen_profile/page_profile.dart';
import 'package:car_wash_admin/utils/size_util.dart';
import 'package:car_wash_admin/utils/state_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


import '../../global_data.dart';

class PageNameEdit extends StatefulWidget{

  var onNewName=(String? name)=>name;


  @override
  StatePageNameEdit createState() {
    // TODO: implement createState
    return StatePageNameEdit();
  }

  PageNameEdit({required this.onNewName});
}

 class StatePageNameEdit extends State<PageNameEdit>{

  bool _isEdit=false;
  bool _isSave=false;
  bool _isControllerAdd=true;
  TextEditingController? nameController;
  TextEditingController? lastnameController;
  TextEditingController? firstnameController;
  final _input=StreamController<int>();
  final _output=StreamController<int>();
  late FocusNode _focusNodename;
  late FocusNode _focusNodelastname;
  late FocusNode _focusNodefirstname;


  void _onStateLoad(int state){
    _output.sink.add(state);
  }


  @override
  void dispose() {
    super.dispose();
    _input.close();
    _output.close();
    _focusNodename.dispose();
    _focusNodefirstname.dispose();
    _focusNodelastname.dispose();
    nameController!.dispose();
    lastnameController!.dispose();
    firstnameController!.dispose();
  }

  @override
  void initState() {
    super.initState();
    nameController=TextEditingController();
    lastnameController=TextEditingController();
    firstnameController=TextEditingController();
    _focusNodelastname=FocusNode();
    _focusNodefirstname=FocusNode();
    _focusNodename=FocusNode();
    _input.stream.listen(_onStateLoad);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBackgrondProfile,
      body: FutureBuilder<UserData?>(
          future: getDataUserLocal(),
          builder: (context,data){
            if(data.data==null){
              return Center(child: CircularProgressIndicator(color: AppColors.colorIndigo,strokeWidth: SizeUtil.getSize(0.5,GlobalData.sizeScreen!),));
            }else{
              if(_isControllerAdd){
                nameController!.text= data.data!.firstname;
                lastnameController!.text=data.data!.lastname;
                firstnameController!.text=data.data!.patronymic;
                _isControllerAdd=false;
              }
                return Column(
                  children: [
                    AppBar(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      actions: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  if(_isSave){
                                    widget.onNewName('${nameController!.text} ${firstnameController!.text} ${lastnameController!.text}');
                                  }
                                },
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: AppColors.colorIndigo,
                                ),
                              ),
                              Text(
                                'Имя пользователя',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeUtil.getSize(
                                        2.8, GlobalData.sizeScreen!)),
                              ),
                              StreamBuilder(
                                stream: _output.stream,
                                builder: (BuildContext context, AsyncSnapshot<int> snapshot){
                                  if(snapshot.hasData){
                                    if(snapshot.data==1){
                                      return GestureDetector(
                                        onTap:(){
                                          if (_isEdit) {
                                            _editName(data.data!.phone,lastnameController!.text,
                                                nameController!.text,
                                                firstnameController!.text,
                                                data.data!.email);
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

                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0,
                          SizeUtil.getSize(3.0, GlobalData.sizeScreen!), 0, 0),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                SizeUtil.getSize(3.0, GlobalData.sizeScreen!),
                                SizeUtil.getSize(1.0, GlobalData.sizeScreen!),
                                SizeUtil.getSize(1.0, GlobalData.sizeScreen!),
                                SizeUtil.getSize(1.0, GlobalData.sizeScreen!)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Text('Имя',
                                        style: TextStyle(
                                            color: AppColors.textColorItem,
                                            fontSize: SizeUtil.getSize(
                                                1.8, GlobalData.sizeScreen!))),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          height: SizeUtil.getSize(
                                              3.0, GlobalData.sizeScreen!),
                                          child: TextField(
                                            focusNode: _focusNodename,
                                            style: TextStyle(
                                                color: AppColors.textColorPhone,
                                                fontWeight: FontWeight.bold,
                                                fontSize: SizeUtil.getSize(1.8,
                                                    GlobalData.sizeScreen!)),
                                            controller: nameController,
                                            decoration: InputDecoration(
                                                contentPadding: EdgeInsets.all(
                                                    SizeUtil.getSize(
                                                        1.5,
                                                        GlobalData
                                                            .sizeScreen!)),
                                                border: InputBorder.none),
                                            onChanged: (text) {
                                              if (text.isNotEmpty) {
                                                setState(() {
                                                    _isEdit=true;
                                                    _input.sink.add(1);
                                                });
                                              }
                                            },
                                          ),
                                        )),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    _focusNodename.requestFocus();
                                  },
                                  child:
                                  Icon(
                                    Icons.edit,
                                    color: AppColors.colorBackgrondProfile,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(height: 1, color: AppColors.colorLine),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                SizeUtil.getSize(3.0, GlobalData.sizeScreen!),
                                SizeUtil.getSize(1.0, GlobalData.sizeScreen!),
                                SizeUtil.getSize(1.0, GlobalData.sizeScreen!),
                                SizeUtil.getSize(1.0, GlobalData.sizeScreen!)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Text('Отчество',
                                        style: TextStyle(
                                            color: AppColors.textColorItem,
                                            fontSize: SizeUtil.getSize(
                                                1.8, GlobalData.sizeScreen!))),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          height: SizeUtil.getSize(
                                              3.0, GlobalData.sizeScreen!),
                                          child: TextField(
                                            style: TextStyle(
                                                color: AppColors.textColorPhone,
                                                fontWeight: FontWeight.bold,
                                                fontSize: SizeUtil.getSize(1.8,
                                                    GlobalData.sizeScreen!)),
                                            controller: firstnameController,
                                            focusNode: _focusNodefirstname,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.all(
                                                  SizeUtil.getSize(1.5,
                                                      GlobalData.sizeScreen!)),
                                              border: InputBorder.none,
                                            ),
                                            onChanged: (text) {
                                              if (text.isNotEmpty) {
                                                setState(() {
                                                  _isEdit=true;
                                                  _input.sink.add(1);
                                                });
                                              }
                                            },
                                          ),
                                        )),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    _focusNodefirstname.requestFocus();
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: AppColors.colorBackgrondProfile,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(height: 1, color: AppColors.colorLine),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                SizeUtil.getSize(3.0, GlobalData.sizeScreen!),
                                SizeUtil.getSize(1.0, GlobalData.sizeScreen!),
                                SizeUtil.getSize(1.0, GlobalData.sizeScreen!),
                                SizeUtil.getSize(1.0, GlobalData.sizeScreen!)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Text('Фамилия',
                                        style: TextStyle(
                                            color: AppColors.textColorItem,
                                            fontSize: SizeUtil.getSize(
                                                1.8, GlobalData.sizeScreen!))),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          height: SizeUtil.getSize(
                                              3.0, GlobalData.sizeScreen!),
                                          child: TextField(
                                            style: TextStyle(
                                                color: AppColors.textColorPhone,
                                                fontWeight: FontWeight.bold,
                                                fontSize: SizeUtil.getSize(1.8,
                                                    GlobalData.sizeScreen!)),
                                            controller: lastnameController,
                                            focusNode: _focusNodelastname,
                                            decoration: InputDecoration(
                                                contentPadding: EdgeInsets.all(
                                                    SizeUtil.getSize(
                                                        1.5,
                                                        GlobalData
                                                            .sizeScreen!)),
                                                border: InputBorder.none),
                                            onChanged: (text) {
                                              if (text.isNotEmpty) {
                                                setState(() {
                                                  _isEdit = true;
                                                  _input.sink.add(1);
                                                });
                                              }
                                            },
                                          ),
                                        )),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    _focusNodelastname.requestFocus();
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: AppColors.colorBackgrondProfile,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                );
              }
          }));

  }

   _editName(String phone,String lastname,String firstname,String patronymic,String email) async{
     if(await StateNetwork.initConnectivity()==2){
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
         backgroundColor: Colors.red,
         content: Text('Отсутствует подключение к сети...'),));
     }else{
       if(lastname.isNotEmpty&&firstname.isNotEmpty&&patronymic.isNotEmpty){
         setState(() {
           _input.sink.add(2);
         });
         final result=await RepositoryModule.userRepository().uploadDataUser(phone:phone,firstname: firstname, patronymic: patronymic, lastname: lastname, email: email)
             .catchError((error){
           setState(() {
             _input.sink.add(0);
           });
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
             backgroundColor: Colors.red,
             content: Text('Ошибка загрузки...'),));
         });
         if(result){
           setState(() {
             _input.sink.add(0);
             _isEdit=false;
             _isSave=true;
           });
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




