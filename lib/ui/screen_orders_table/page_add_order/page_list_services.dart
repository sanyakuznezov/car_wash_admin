


 import 'package:car_wash_admin/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../app_colors.dart';
import '../../../global_data.dart';

class PageListServices extends StatefulWidget{
  @override
  State<PageListServices> createState() => _PageListServicesState();
}

class _PageListServicesState extends State<PageListServices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.colorBackgrondProfile,
        body: Column(
          children: [
            AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              actions: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);

                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.colorIndigo,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Список работ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: SizeUtil.getSize(
                                    2.8, GlobalData.sizeScreen!)),
                          ),
                        ),
                        Align(alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap:(){

                            },
                            child: Icon(Icons.search,color: AppColors.colorIndigo),
                          ),
                        )

                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ) );
  }
}