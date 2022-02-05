



import 'package:badges/badges.dart';
import 'package:car_wash_admin/app_colors.dart';
import 'package:car_wash_admin/data/local_data_base/app_data_base.dart';
import 'package:car_wash_admin/domain/model/response_upload_avatar.dart';
import 'package:car_wash_admin/domain/model/user_data.dart';
import 'package:car_wash_admin/domain/state/bloc_page_route.dart';
import 'package:car_wash_admin/domain/state/bloc_verify_user.dart';
import 'package:car_wash_admin/internal/dependencies/repository_module.dart';
import 'package:car_wash_admin/ui/screen_auth/page_auth.dart';
import 'package:car_wash_admin/ui/screen_profile/page_languadge.dart';
import 'package:car_wash_admin/ui/screen_profile/page_name_edit.dart';
import 'package:car_wash_admin/ui/screen_profile/page_notifi.dart';
import 'package:car_wash_admin/ui/screen_profile/page_number_edit.dart';
import 'package:car_wash_admin/ui/screen_profile/page_private_policy.dart';
import 'package:car_wash_admin/utils/size_util.dart';
import 'package:car_wash_admin/utils/state_network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../global_data.dart';

class PageProfile extends StatefulWidget{



  @override
  State<PageProfile> createState() => _PageProfileState();

}

class _PageProfileState extends State<PageProfile> {

  bool _isError=false;
  double radius=SizeUtil.getSize(6.0,GlobalData.sizeScreen!);
  double radius2=SizeUtil.getSize(2.0,GlobalData.sizeScreen!);
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  bool _isLoadAva=false;
  bool _imgPiker=false;
  bool _isName=false;
  bool _isPhone=false;
  String? _avatar;
  String? _name;
  String? _phone;
  int _langId=0;
 late BlocVerifyUser _blocVerifyUser=BlocVerifyUser();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          actions: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
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
                      child: Text('Профиль',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,
                            fontSize: SizeUtil.getSize(2.8,GlobalData.sizeScreen!)),),
                    )
                  ],
                ),
              ),
            )

          ],
          backgroundColor: Colors.white),
       backgroundColor: AppColors.colorBackgrondProfile,
       body: SingleChildScrollView(
         child: FutureBuilder<UserData?>(
           future: getDataUserLocal(),
           builder: (context,data){
             if(data.data==null){
               return Center(child: CircularProgressIndicator(color: AppColors.colorIndigo,strokeWidth: SizeUtil.getSize(0.5,GlobalData.sizeScreen!),));
             }else{
               if(!_imgPiker){
                 _avatar=GlobalData.URL_BASE_IMAGE+data.data!.avatar;
               }
               if(!_isName){
                 _name='${data.data!.firstname} ${data.data!.patronymic} ${data.data!.lastname}';
               }
               if(!_isPhone){
                 _phone='${data.data!.phone}';
               }
               if(_langId==0){
                 _langId=data.data!.lang_id;
               }
              return Column(
                 children: [
                   Column(
                     children: [
                       Container(
                         width: MediaQuery.of(context).size.width,
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Container(
                               margin: EdgeInsets.all(SizeUtil.getSize(5.0,GlobalData.sizeScreen!)),
                               child: Center(
                                 child: GestureDetector(
                                   onTap: (){
                                     _showPicker(context);
                                   },
                                   child: Badge(
                                     elevation: 1.0,
                                     badgeColor: AppColors.colorIndigo,
                                     badgeContent: Container(
                                       margin: EdgeInsets.all(SizeUtil.getSize(0.8,GlobalData.sizeScreen!)),
                                       child: Icon(
                                         Icons.edit,
                                         color: Colors.white,
                                         size: SizeUtil.getSize(2.0,GlobalData.sizeScreen!),
                                       ),
                                     ),
                                     child: !_isLoadAva?CircleAvatar(
                                       backgroundImage: NetworkImage(_avatar!),
                                       onBackgroundImageError: (a,r){
                                         setState(() {
                                           this._isError = true;
                                         });

                                       },
                                       backgroundColor: Colors.white,
                                       radius: radius,
                                       child: _isError?Icon(
                                         Icons.image_not_supported_rounded,
                                         color: AppColors.colorBackgrondProfile,
                                         size: SizeUtil.getSize(4.0,GlobalData.sizeScreen!),
                                       ):Container(),
                                     ):Container(
                                       width: SizeUtil.getSize(12.0,GlobalData.sizeScreen!),
                                       height: SizeUtil.getSize(12.0,GlobalData.sizeScreen!),
                                       decoration: BoxDecoration(
                                           shape: BoxShape.circle,
                                           color: Colors.white),
                                       child: CircularProgressIndicator(strokeWidth: 4,color: AppColors.colorIndigo,),
                                     ),
                                   ),
                                 ),
                               ),
                             ),
                             Text(_name!,
                               style: TextStyle(
                                   color: AppColors.textColorDark,
                                   fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                               ),),
                             Text('${data.data!.email}',
                               style: TextStyle(
                                   color: AppColors.textColorHint,
                                   fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                               ),),




                             Container(
                               margin: EdgeInsets.fromLTRB(0,SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(0.8,GlobalData.sizeScreen!)),
                               child:
                               Column(
                                 children: [
                                   Align(
                                     child: Padding(
                                       padding: EdgeInsets.fromLTRB(SizeUtil.getSize(4.0,GlobalData.sizeScreen!),SizeUtil.getSize(2.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(2.0,GlobalData.sizeScreen!)),
                                       child: Text('Контактная информация',
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
                                             children: [
                                               Text('ФИО',
                                                   style: TextStyle(
                                                       color: AppColors.textColorItem,
                                                       fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                                                   )),
                                               Expanded(
                                                 child: Align(
                                                   alignment: Alignment.centerRight,
                                                   child: GestureDetector(
                                                     onTap: (){
                                                       Navigator.push(context, SlideTransitionLift(PageNameEdit(
                                                         onNewName: (name){
                                                            setState(() {
                                                              _isName=true;
                                                              _name=name;
                                                            });
                                                         },
                                                       )));
                                                     },
                                                     child: Icon(
                                                       Icons.arrow_forward_ios,
                                                       color: AppColors.colorIndigo,
                                                     ),
                                                   ),
                                                 ),
                                               ),
                                             ],
                                           ),
                                         ),
                                         Container(height: 1,
                                             color: AppColors.colorLine),
                                         Padding(
                                           padding:EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                                           child: Row(
                                             children: [
                                               Text(_phone!.isNotEmpty?'$_phone':'Номер телефона',
                                                   style: TextStyle(
                                                       color: AppColors.textColorItem,
                                                       fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                                                   )),
                                               Expanded(
                                                 child: Align(
                                                   alignment: Alignment.centerRight,
                                                   child: GestureDetector(
                                                     onTap: (){
                                                       Navigator.push(context, SlideTransitionLift(
                                                           PageNumberEdit(data.data!,
                                                           onNewNumber: (numberPhone){
                                                             setState(() {
                                                               _isPhone=true;
                                                               _phone=numberPhone;
                                                             });
                                                           },
                                                           )));
                                                     },
                                                     child: Icon(
                                                       Icons.arrow_forward_ios,
                                                       color: AppColors.colorIndigo,
                                                     ),
                                                   ),
                                                 ),
                                               ),
                                             ],
                                           ),
                                         ),
                                         Container(height: 1,
                                             color: AppColors.colorLine),

                                         Padding(
                                           padding:EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                                           child: Row(
                                             children: [
                                               Text('Whatsapp',
                                                   style: TextStyle(
                                                       color: AppColors.textColorItem,
                                                       fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                                                   )),
                                               Expanded(
                                                 child: Align(
                                                   alignment: Alignment.centerRight,
                                                   child: Icon(
                                                     Icons.arrow_forward_ios,
                                                     color: AppColors.colorIndigo,
                                                   ),
                                                 ),
                                               ),
                                             ],
                                           ),
                                         ),
                                         Container(height: 1,
                                             color: AppColors.colorLine),
                                         Padding(
                                           padding:EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                                           child: Row(
                                             children: [
                                               Text('Telegram',
                                                   style: TextStyle(
                                                       color: AppColors.textColorItem,
                                                       fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                                                   )),
                                               Expanded(
                                                 child: Align(
                                                   alignment: Alignment.centerRight,
                                                   child: Icon(
                                                     Icons.arrow_forward_ios,
                                                     color: AppColors.colorIndigo,
                                                   ),
                                                 ),
                                               ),
                                             ],
                                           ),
                                         ),
                                         Container(height: 1,
                                             color: AppColors.colorLine),

                                       ],
                                     ),
                                   ),
                                   Align(
                                     child: Padding(
                                       padding: EdgeInsets.fromLTRB(SizeUtil.getSize(4.0,GlobalData.sizeScreen!),SizeUtil.getSize(2.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(2.0,GlobalData.sizeScreen!)),
                                       child: Text('Уведомления',
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
                                         Container(height: 1,
                                             color: AppColors.colorLine),
                                         Padding(
                                           padding:EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                                           child: Row(
                                             children: [
                                               Text('Настроить',
                                                   style: TextStyle(
                                                       color: AppColors.textColorItem,
                                                       fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                                                   )),
                                               Expanded(
                                                 child: Align(
                                                   alignment: Alignment.centerRight,
                                                   child: GestureDetector(
                                                     onTap: (){
                                                       Navigator.push(context, SlideTransitionLift(PageNotifi()));
                                                     },
                                                     child: Icon(
                                                       Icons.arrow_forward_ios,
                                                       color: AppColors.colorIndigo,
                                                     ),
                                                   ),
                                                 ),
                                               ),
                                             ],
                                           ),
                                         )],
                                     ),
                                   ),

                                   Align(
                                     child: Padding(
                                       padding: EdgeInsets.fromLTRB(SizeUtil.getSize(4.0,GlobalData.sizeScreen!),SizeUtil.getSize(2.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(2.0,GlobalData.sizeScreen!)),
                                       child: Text('Язык',
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
                                         Container(height: 1,
                                             color: AppColors.colorLine),
                                         Padding(
                                           padding:EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                                           child: Row(
                                             children: [
                                               Text('${_getNameLanguage(_langId)}',
                                                   style: TextStyle(
                                                       color: AppColors.textColorItem,
                                                       fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                                                   )),
                                               Expanded(
                                                 child: Align(
                                                   alignment: Alignment.centerRight,
                                                   child: GestureDetector(
                                                     onTap: (){
                                                       Navigator.push(context, SlideTransitionLift(PageLanguadge(
                                                           langId: _langId,
                                                       onLangId: (id){
                                                             setState(() {
                                                                 _langId=id!;
                                                             });
                                                       },)));
                                                     },
                                                     child: Icon(
                                                       Icons.arrow_forward_ios,
                                                       color: AppColors.colorIndigo,
                                                     ),
                                                   ),
                                                 ),
                                               ),
                                             ],
                                           ),
                                         )],
                                     ),
                                   ),
                                   SizedBox(
                                     height: SizeUtil.getSize(3.0,GlobalData.sizeScreen!),
                                     width: 2,
                                   ),
                                   Container(
                                     color: Colors.white,
                                     child: Column(
                                       children: [
                                         Padding(
                                           padding:EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                                           child: Row(
                                             children: [
                                               Text('Политика конфиденциальности',
                                                   style: TextStyle(
                                                       color: AppColors.textColorItem,
                                                       fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                                                   )),
                                               Expanded(
                                                 child: Align(
                                                   alignment: Alignment.centerRight,
                                                   child: GestureDetector(
                                                     onTap: (){
                                                       Navigator.push(context, SlideTransitionLift(PagePrivatePolicy(
                                                         current: 1,
                                                       )));
                                                     },
                                                     child: Icon(
                                                       Icons.arrow_forward_ios,
                                                       color: AppColors.colorIndigo,
                                                     ),
                                                   ),
                                                 ),
                                               ),
                                             ],
                                           ),
                                         ),
                                         Container(height: 1,
                                             color: AppColors.colorLine),
                                         Padding(
                                           padding:EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                                           child: Row(
                                             children: [
                                               Text('О приложении',
                                                   style: TextStyle(
                                                       color: AppColors.textColorItem,
                                                       fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                                                   )),
                                               Expanded(
                                                 child: Align(
                                                   alignment: Alignment.centerRight,
                                                   child: GestureDetector(
                                                     onTap: (){
                                                       Navigator.push(context, SlideTransitionLift(
                                                           PagePrivatePolicy(
                                                             current: 2,
                                                           )));
                                                     },
                                                     child: Icon(
                                                       Icons.arrow_forward_ios,
                                                       color: AppColors.colorIndigo,
                                                     ),
                                                   ),
                                                 ),
                                               ),
                                             ],
                                           ),
                                         ),
                                         Container(height: 1,
                                             color: AppColors.colorLine),
                                         Container(
                                           color: Colors.white,
                                           child: Padding(
                                             padding:EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.5,GlobalData.sizeScreen!),SizeUtil.getSize(1.5,GlobalData.sizeScreen!),SizeUtil.getSize(1.5,GlobalData.sizeScreen!)),
                                             child: Row(
                                               children: [
                                                 GestureDetector(
                                                   onTap: (){
                                                    _showDialogSingOut();

                                                   },
                                                   child: Text('Выйти',
                                                       style: TextStyle(
                                                           color:  AppColors.textColorTitle,
                                                           fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                                                       )),
                                                 ),

                                               ],
                                             ),
                                           )
                                         )

                                       ],
                                     ),
                                   )
                                 ],
                               ),
                             )
                           ],
                         ),
                       )
                     ],
                   )
                 ],
               );
             }
           }
         ),
       ),
    );
  }

  @override
  void initState() {
    super.initState();
  }


   _getNameLanguage(int id){
      if(id==1){
        return 'Русский';
      }else if(id==2){
        return 'Язык 2';
      }else if(id==3){
        return 'Язык 3';
      }
   }

    //загрузка фото из камеры
  _imgFromCamera() async {
     _image = await _picker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );
     setState(() {
       _isLoadAva=true;
     });
     final result=  await uploadAvatar(_image!);
     setState(() {
       _imgPiker=true;
       _isLoadAva=false;
       _avatar=GlobalData.URL_BASE_IMAGE+result!.url;
     });

  }

   //загрузка фото из алереи
  _imgFromGallery() async {
    _image = await  _picker.pickImage(source: ImageSource.gallery, imageQuality: 50
    ).catchError((error){
      print('Error $error');
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('Ошибка загрузки'),));
        _isLoadAva=false;
      });
    });
    if(_image!=null){
      setState(() {
        _isLoadAva=true;
      });
      final result= await uploadAvatar(_image!).catchError((onError){
        setState(() {
          _isLoadAva=false;
        });
      });
      setState(() {
        _imgPiker=true;
        _isLoadAva=false;
        _avatar=GlobalData.URL_BASE_IMAGE+result!.url;
      });
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('Ошибка обработки файла...'),));
    }

  }

   Future<ResponseUploadAvatar?> uploadAvatar(XFile image)async{
    if(await StateNetwork.initConnectivity()==2){
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
         backgroundColor: Colors.red,
         content: Text('Отсутствует подключение к сети...'),));
     }else{
     final result=  await RepositoryModule.userRepository().uploadImageAvatar(file: image)
           .catchError((error){
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
           backgroundColor: Colors.red,
           content: Text('Ошибка загрузки...'),));
         setState(() {
           _imgPiker=true;
           _isLoadAva=false;
         });
       });
      return result;
     }
     return null;
   }

   Future<UserData?> getDataUserLocal() async{
     final database = await $FloorAppDataBase.databaseBuilder('app_database.db').build();
     final userDao = database.userataDao;
    final result=await userDao.getDataUser();
    return result;
   }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Выбрать фото',
                        style: TextStyle(
                            color: AppColors.textColorDark,
                            fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                        ),),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Сделать фото',
                      style: TextStyle(
                          color: AppColors.textColorDark,
                          fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                      ),),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  void _showDialogSingOut() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Выйти из профиля?'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    _blocVerifyUser.singOutUser();
                    // Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (BuildContext context)=>PageAuth()),(Route<dynamic> route) => false);

                  },
                  child: Text('Выйти')),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Отмена'),
              )
            ],
          );
        });
  }
}