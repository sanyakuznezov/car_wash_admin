import 'package:car_wash_admin/utils/size_util.dart';
import 'package:flutter/material.dart';

import '../../../global_data.dart';
import 'table_cell.dart';

class TableHead extends StatelessWidget {

  final int posts;
  final ScrollController scrollController;

  TableHead({required this.posts,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeUtil.getSize(6.22,GlobalData.sizeScreen!),
      child:
          Container(
            margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
            child: Expanded(
              child: ListView(
                controller: scrollController,
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: List.generate(posts, (index) {
                  return MultiplicationTableCell(posts: posts,
                    value: index + 1,
                  );
                }),
              ),
            ),
          )


      );

  }
}
