




 import 'dart:io';

import 'package:car_wash_admin/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../app_colors.dart';
import '../../global_data.dart';

class PagePrivatePolicy extends StatefulWidget{


  static const String URL_PRIVATE_POLICY='https://app.crmstep.ru/api/v1/views/policy';
  static const String URL_INFO_APP='https://app.crmstep.ru/api/v1/views/about';
  final int current;
  PagePrivatePolicy({required this.current});

  @override
  State<PagePrivatePolicy> createState() => _PagePrivatePolicyState();
}

class _PagePrivatePolicyState extends State<PagePrivatePolicy> {
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
                      child: SizedBox(
                        width: SizeUtil.getSize(30,GlobalData.sizeScreen!),
                        child: Text(widget.current==1?'Политика конфиденциальности':'О приложении',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,
                              fontSize: SizeUtil.getSize(2.8,GlobalData.sizeScreen!)),),
                      ),
                    )
                  ],
                ),
              ),
            )

          ],
          backgroundColor: Colors.white),
          body: WebView(
            initialUrl: widget.current==1?PagePrivatePolicy.URL_PRIVATE_POLICY:PagePrivatePolicy.URL_INFO_APP,
          )
    );


  }

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }
}