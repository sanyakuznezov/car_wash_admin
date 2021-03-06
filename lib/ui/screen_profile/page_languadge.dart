


import 'dart:async';

import 'package:car_wash_admin/app_colors.dart';
import 'package:car_wash_admin/data/local_data_base/app_data_base.dart';
import 'package:car_wash_admin/domain/model/user_data.dart';
import 'package:car_wash_admin/internal/dependencies/repository_module.dart';
import 'package:car_wash_admin/utils/size_util.dart';
import 'package:car_wash_admin/utils/state_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../global_data.dart';

class PageLanguadge extends StatefulWidget{

  int langId;
  var onLangId=(int? id)=>id;

  PageLanguadge({required this.langId,required this.onLangId});

  @override
  StatePageLanguage createState() {
    // TODO: implement createState
   return StatePageLanguage();
  }


}

 class StatePageLanguage extends State<PageLanguadge>{

  int? langId;
  bool _isEdit=false;
  bool _isSave=false;


  final _input=StreamController<int>();
  final _output=StreamController<int>();


  void _onStateLoad(int state){
    _output.sink.add(state);
  }


  @override
  void dispose() {
    _input.close();
    _output.close();
  }

  @override
  void initState() {
    langId=widget.langId;
    _input.stream.listen(_onStateLoad);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        if(_isSave){
          widget.onLangId(langId!);
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
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                          if(_isSave){
                            widget.onLangId(langId!);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.colorIndigo,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text('????????',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,
                              fontSize: SizeUtil.getSize(2.8,GlobalData.sizeScreen!)),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: StreamBuilder(
                            stream: _output.stream,
                            builder: (BuildContext context, AsyncSnapshot<int> snapshot){
                              if(snapshot.hasData){
                                if(snapshot.data==1){
                                  return GestureDetector(
                                    onTap:(){
                                      if (_isEdit) {
                                        _editIdLAng(langId!);
                                      }
                                    },
                                    child: Text(
                                      '????????.',
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
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0,SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(0.8,GlobalData.sizeScreen!)),
              color: Colors.white,
              child: Column(
                  children: [
                    Padding(
                      padding:EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            _isEdit=true;
                            langId=1;
                            _input.sink.add(1);
                          });
                        },
                        child: Container(
                          color: Colors.transparent,
                          height: SizeUtil.getSize(3.5,GlobalData.sizeScreen!),
                          child: Row(
                              children: [
                                Text('??????????????',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                                    )),
                                Expanded(
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: langId==1?SvgPicture.asset('assets/frame.svg'):Container()
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ),
                    Container(height: 1,
                        color: AppColors.colorLine),
                    Padding(
                      padding:EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isEdit=true;
                            langId = 2;
                            _input.sink.add(1);
                          });
                        },
                        child: Container(
                          color: Colors.transparent,
                          height: SizeUtil.getSize(3.5,GlobalData.sizeScreen!),
                          child: Row(
                            children: [
                              Text('???????? 2',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                                  )),

                              Expanded(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: langId==2?SvgPicture.asset('assets/frame.svg'):Container()
                                ),
                              )],
                          ),
                        ),
                      ),
                    ),
                    Container(height: 1,
                        color: AppColors.colorLine),

                    Padding(
                      padding:EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            _isEdit=true;
                            langId = 3;
                            _input.sink.add(1);
                          });
                        },
                        child: Container(
                          color: Colors.transparent,
                          height: SizeUtil.getSize(3.5,GlobalData.sizeScreen!),
                          child: Row(
                            children: [
                              Text('???????? 3',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                                  )),
                              Expanded(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: langId==3?SvgPicture.asset('assets/frame.svg'):Container()
                                ),
                              )],
                          ),
                        ),
                      ),
                    ),

                  ]),
            ),


          ],
        )
            ),
    );
  }


  _editIdLAng(int idlang) async{
    if(await StateNetwork.initConnectivity()==2){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('?????????????????????? ?????????????????????? ?? ????????...'),));
    }else{
      if(idlang!=null){
        setState(() {
          _input.sink.add(2);
        });
        final result=await RepositoryModule.userRepository().updateIdLang(idLang: idlang)
            .catchError((error){
          setState(() {
            _input.sink.add(0);
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text('???????????? ????????????????...'),));
        });
        if(result){
          setState(() {
            _input.sink.add(0);
            _isEdit=false;
          });
          _isSave=true;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black,
            content: Text('???????????? ?????????????? ????????????????'),));
        }
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.black,
          content: Text('???????? ???? ?????????? ???????? ??????????????'),));
      }

    }


  }




 }