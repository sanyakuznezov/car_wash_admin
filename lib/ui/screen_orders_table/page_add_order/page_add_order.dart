


  import 'package:car_wash_admin/app_colors.dart';
import 'package:car_wash_admin/domain/state/bloc_page_route.dart';
import 'package:car_wash_admin/ui/screen_orders_table/page_add_order/page_search_brand.dart';
import 'package:car_wash_admin/utils/size_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../global_data.dart';

class PageAddOrder extends StatefulWidget{


  int? post;
  String? date;
  String? time;


  @override
  StatePageAddOrder createState() {
    // TODO: implement createState
    return StatePageAddOrder();
  }

  PageAddOrder({required this.post,required this.date,required this.time});
}

  class StatePageAddOrder extends State<PageAddOrder>{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.colorBackgrondProfile,
      body: SingleChildScrollView(
        child: Column(
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
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.colorIndigo,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text('Просмотр записи',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,
                                fontSize: SizeUtil.getSize(2.8,GlobalData.sizeScreen!)),),
                        ),

                        Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            height: SizeUtil.getSize(3.0,GlobalData.sizeScreen!),
                              child: SvgPicture.asset('assets/flag_1.svg'))
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
             ItemDate(date:widget.date,time: widget.time,post: widget.post),
            ItemCar(),
            ItemClient(),
            ItemListWork(),
            ItemPrice(),
            ItemComment(),
            ItemReview()

          ],
        ),
      ),
    );

  }

  }

   class ItemReview extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
     return Container(
         margin:  EdgeInsets.fromLTRB(0,SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(0.8,GlobalData.sizeScreen!)),
         child: Column(
             children: [
               Container(
                 height: SizeUtil.getSize(5,GlobalData.sizeScreen!),
                 margin: EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0),
                 child: Row(
                   children: [
                     SizedBox(
                       child: SvgPicture.asset('assets/ic_review.svg'),
                       height: SizeUtil.getSize(2.5,GlobalData.sizeScreen!),),
                     Expanded(
                       child: Padding(
                         padding: EdgeInsets.fromLTRB(SizeUtil.getSize(2.0,GlobalData.sizeScreen!), 0, 0, 0),
                         child: Text('Отзывы',
                           style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!),
                               color: AppColors.textColorTitle
                           ),),
                       ),
                     ),
                   ],
                 ),
               ),
               Container(
                   color: AppColors.color120,
                   child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Padding(
                           padding: EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),SizeUtil.getSize(2.0,GlobalData.sizeScreen!), 0, 0),
                           child: Text('.....',
                             style: TextStyle(
                                 fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!),
                                 color: AppColors.textColorPhone
                             ),),
                         ),
                         Padding(
                           padding: EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.5,GlobalData.sizeScreen!), 0, SizeUtil.getSize(2.0,GlobalData.sizeScreen!)),
                           child: Text('Комментарий клиента',
                             style: TextStyle(
                                 fontSize: SizeUtil.getSize(1.5,GlobalData.sizeScreen!),
                                 color: AppColors.textColorItem_50
                             ),),
                         ),
                         Container(height: 1, color: AppColors.colorLine),
                       ])),

               Container(
                   alignment: Alignment.centerLeft,
                   width: MediaQuery.of(context).size.width,
                   color: Colors.white,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Padding(
                           padding: EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),SizeUtil.getSize(2.0,GlobalData.sizeScreen!), 0, 0),
                           child: Text('.....',
                             style: TextStyle(
                                 fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!),
                                 color: AppColors.textColorPhone
                             ),),
                         ),
                         Padding(
                           padding: EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.5,GlobalData.sizeScreen!), 0, SizeUtil.getSize(2.0,GlobalData.sizeScreen!)),
                           child: Text('Ответный отзыв персонала',
                             style: TextStyle(
                                 fontSize: SizeUtil.getSize(1.5,GlobalData.sizeScreen!),
                                 color: AppColors.textColorItem_50
                             ),),
                         ),
                       ]))


             ]));
  }

   }


  class ItemComment extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.fromLTRB(0,SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(0.8,GlobalData.sizeScreen!)),
      child: Column(
        children: [
          Container(
            height: SizeUtil.getSize(5,GlobalData.sizeScreen!),
            margin: EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0),
            child: Row(
              children: [
                SizedBox(
                  child: SvgPicture.asset('assets/ic_coment.svg'),
                  height: SizeUtil.getSize(2.5,GlobalData.sizeScreen!),),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(SizeUtil.getSize(2.0,GlobalData.sizeScreen!), 0, 0, 0),
                    child: Text('Комментарии',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!),
                          color: AppColors.textColorTitle
                      ),),
                  ),
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(0, SizeUtil.getSize(1.0, GlobalData.sizeScreen!), 0, 0),
              color: AppColors.color120,
              child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),SizeUtil.getSize(2.0,GlobalData.sizeScreen!), 0, 0),
                  child: Text('.....',
                    style: TextStyle(
                        fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!),
                        color: AppColors.textColorPhone
                    ),),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.5,GlobalData.sizeScreen!), 0, SizeUtil.getSize(2.0,GlobalData.sizeScreen!)),
                  child: Text('Комментарий клиента',
                    style: TextStyle(
                        fontSize: SizeUtil.getSize(1.5,GlobalData.sizeScreen!),
                        color: AppColors.textColorItem_50
                    ),),
                ),
                Container(height: 1, color: AppColors.colorLine),
              ])),
          Container(
            alignment: Alignment.centerLeft,
            width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),SizeUtil.getSize(2.0,GlobalData.sizeScreen!), 0, 0),
                      child: Text('.....',
                        style: TextStyle(
                            fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!),
                            color: AppColors.textColorPhone
                        ),),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.5,GlobalData.sizeScreen!), 0, SizeUtil.getSize(2.0,GlobalData.sizeScreen!)),
                      child: Text('Комментарий персонала',
                        style: TextStyle(
                            fontSize: SizeUtil.getSize(1.5,GlobalData.sizeScreen!),
                            color: AppColors.textColorItem_50
                        ),),
                    ),
                  ]))
        ]));
  }

  }



  class ItemPrice extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Container(
     margin:  EdgeInsets.fromLTRB(0,SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(0.8,GlobalData.sizeScreen!)),
     child: Column(
       children: [
         Container(
           height: SizeUtil.getSize(5,GlobalData.sizeScreen!),
           margin: EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0),
           child: Row(
             children: [
               SizedBox(
                 child: SvgPicture.asset('assets/ic_price.svg'),
                 height: SizeUtil.getSize(2.5,GlobalData.sizeScreen!),),
               Expanded(
                 child: Padding(
                   padding: EdgeInsets.fromLTRB(SizeUtil.getSize(2.0,GlobalData.sizeScreen!), 0, 0, 0),
                   child: Text('Стоимость',
                     style: TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!),
                         color: AppColors.textColorTitle
                     ),),
                 ),
               ),
               Align(
                 alignment: Alignment.bottomCenter,
                 child: Expanded(
                   child: Text('Править',
                     textAlign: TextAlign.right,
                     style: TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!),
                         color: AppColors.colorIndigo
                     ),),
                 ),
               ),

             ],
           ),
         ),
         Container(
           margin: EdgeInsets.fromLTRB(0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0, 0),
           color: Colors.white,
           child: Column(
             children: [
               Padding(
                 padding:EdgeInsets.fromLTRB(SizeUtil.getSize(7.5,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                 child: Row(
                   children: [
                     Text('Всего',
                         style: TextStyle(
                             color: AppColors.textColorItem,
                             fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                         )),
                     Expanded(
                       child: Padding(
                         padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                         child: Text('3000 ₽',
                             textAlign: TextAlign.end,
                             style: TextStyle(
                                 color: AppColors.textColorPhone,
                                 fontWeight: FontWeight.bold,
                                 fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                             )),
                       ),
                     ),
                   ],
                 ),
               ),
               Container(
                   height: 1,
                   color: AppColors.colorLine),
               Padding(
                 padding:EdgeInsets.fromLTRB(SizeUtil.getSize(7.5,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                 child: Row(
                   children: [
                     Text('Скидка',
                         style: TextStyle(
                             color: AppColors.textColorItem,
                             fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                         )),
                     Expanded(
                       child: Padding(
                         padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                         child: Text('1000 ₽',
                             textAlign: TextAlign.end,
                             style: TextStyle(
                                 color: AppColors.textColorPhone,
                                 fontWeight: FontWeight.bold,
                                 fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                             )),
                       ),
                     ),

                   ],
                 ),
               ),
               Container(
                   height: 1,
                   color: AppColors.colorLine),

               Padding(
                 padding:EdgeInsets.fromLTRB(SizeUtil.getSize(7.5,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                 child: Row(
                   children: [
                     Text('Итого',
                         style: TextStyle(
                             color: Colors.black,
                             fontWeight: FontWeight.bold,
                             fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                         )),
                     Expanded(
                       child: Padding(
                         padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                         child: Text('2000 ₽',
                             textAlign: TextAlign.end,
                             style: TextStyle(
                                 color: AppColors.textColorPhone,
                                 fontWeight: FontWeight.bold,
                                 fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                             )),
                       ),
                     ),

                   ],
                 ),
               ),
               Container(
                   height: 1,
                   color: AppColors.colorLine),

               Padding(
                 padding:EdgeInsets.fromLTRB(SizeUtil.getSize(7.5,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                 child: Row(
                   children: [
                     Text('Исполнитель',
                         style: TextStyle(
                             color: AppColors.textColorItem,
                             fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                         )),
                     Expanded(
                       child: Padding(
                         padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                         child: Text('Сидоров А.С.',
                             textAlign: TextAlign.end,
                             style: TextStyle(
                                 color: AppColors.textColorPhone,
                                 fontWeight: FontWeight.bold,
                                 fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                             )),
                       ),
                     ),
                     Align(
                       alignment: Alignment.centerRight,
                       child: GestureDetector(
                         onTap: (){
                           //Navigator.push(context, SlideTransitionLift(PageNumberEdit(widget._userData)));
                         },
                         child: Icon(
                           Icons.arrow_forward_ios,
                           color: AppColors.colorIndigo,
                         ),
                       ),
                     ),

                   ],
                 ),
               ),

             ],
           ),
         ),
       ],
     ),
   );
  }


  }

   class ItemListWork extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Container(
     margin:  EdgeInsets.fromLTRB(0,SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(0.8,GlobalData.sizeScreen!)),
     child: Column(
       children: [
         Container(
           height: SizeUtil.getSize(5,GlobalData.sizeScreen!),
           margin: EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0),
           child: Row(
             children: [
               SizedBox(
                 child: SvgPicture.asset('assets/ic_list_work.svg'),
                 height: SizeUtil.getSize(2.5,GlobalData.sizeScreen!),),
               Expanded(
                 child: Padding(
                   padding: EdgeInsets.fromLTRB(SizeUtil.getSize(2.0,GlobalData.sizeScreen!), 0, 0, 0),
                   child: Text('Список работ',
                     style: TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!),
                         color: AppColors.textColorTitle
                     ),),
                 ),
               ),
               Align(
                 alignment: Alignment.bottomCenter,
                 child: Expanded(
                   child: Text('Править',
                     textAlign: TextAlign.right,
                     style: TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!),
                         color: AppColors.colorIndigo
                     ),),
                 ),
               ),

             ],
           ),
         ),
         Container(
           margin: EdgeInsets.fromLTRB(0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0, 0),
           color: Colors.white,
           child: Column(
             children: [
               Padding(
                 padding:EdgeInsets.fromLTRB(SizeUtil.getSize(7.5,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                 child: Row(
                   children: [
                     Text('Добавить',
                         style: TextStyle(
                             color: AppColors.textColorItem,
                             fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                         )),
                     Expanded(
                       child: Align(
                         alignment: Alignment.centerRight,
                         child: GestureDetector(
                           onTap: (){
                           //  Navigator.push(context, SlideTransitionLift(PageNumberEdit(widget._userData)));
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
               Container(
                   margin: EdgeInsets.fromLTRB(SizeUtil.getSize(7.3,GlobalData.sizeScreen!), 0, 0, 0),
                   height: 1,
                   color: AppColors.colorLine),
                Column(
                  children:
                    List.generate(5, (index){
                      return index==1?Work('1'):Work('');
                    })

                )


             ],
           ),
         ),
       ],
     ),
   );
  }

   }

  class ItemClient extends StatefulWidget{
  @override
  State<ItemClient> createState() => _ItemClientState();
}

class _ItemClientState extends State<ItemClient> {

  TextEditingController? telController;
  TextEditingController? nameController;
  TextEditingController? surnameController;
  TextEditingController? patronymicControler;
  late FocusNode myFocusNodeTel;
  late FocusNode myFocusNodeName;
  late FocusNode myFocusNodeSurname;
  late FocusNode myFocusNodePatronymic;
  final _UsNumberTextInputFormatter _inputFormatter=_UsNumberTextInputFormatter();

  @override
  void initState() {
    super.initState();
    telController=TextEditingController();
    nameController=TextEditingController();
    surnameController=TextEditingController();
    patronymicControler=TextEditingController();
    myFocusNodeTel = FocusNode();
    myFocusNodeName=FocusNode();
    myFocusNodeSurname=FocusNode();
    myFocusNodePatronymic=FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    myFocusNodeTel.dispose();
    myFocusNodePatronymic.dispose();
    myFocusNodeName.dispose();
    myFocusNodeSurname.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.fromLTRB(0,SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(0.8,GlobalData.sizeScreen!)),
      child: Column(
        children: [
          Container(
            height: SizeUtil.getSize(5,GlobalData.sizeScreen!),
            margin: EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0),
            child: Row(
              children: [
                SizedBox(
                  child: SvgPicture.asset('assets/ic_client.svg'),
                  height: SizeUtil.getSize(2.5,GlobalData.sizeScreen!),),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(SizeUtil.getSize(2.0,GlobalData.sizeScreen!), 0, 0, 0),
                    child: Text('Клиент',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!),
                          color: AppColors.textColorTitle
                      ),),
                  ),
                ),

              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0, 0),
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding:EdgeInsets.fromLTRB(SizeUtil.getSize(7.5,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Телефон',
                          style: TextStyle(
                              color: AppColors.textColorItem,
                              fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                          )),

                      Expanded(
                        child: Padding(
                          padding:EdgeInsets.fromLTRB(SizeUtil.getSize(7.0,GlobalData.sizeScreen!), 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                          child: SizedBox(
                            height:
                                SizeUtil.getSize(6.0, GlobalData.sizeScreen!),
                            child: TextFormField(
                              validator: (value){
                                _validatePhoneNumber(value!);
                              },
                              onSaved: (value){

                              },
                                maxLength: 13,
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
                                filled: true,
                                  hintText: '....',
                                  prefixText: '+7 ',
                                  contentPadding: EdgeInsets.all(
                                      SizeUtil.getSize(
                                          1.5,
                                          GlobalData
                                              .sizeScreen!)),
                                  border: InputBorder.none),
                              onChanged: (text) {

                                }

                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          myFocusNodeTel.requestFocus();
                        },
                        child: Icon(
                          Icons.edit,
                          color: AppColors.colorBackgrondProfile,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(SizeUtil.getSize(7.3,GlobalData.sizeScreen!), 0, 0, 0),
                    height: 1,
                    color: AppColors.colorLine),
                Padding(
                  padding:EdgeInsets.fromLTRB(SizeUtil.getSize(7.5,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                  child: Row(
                    children: [
                      Text('Фамилия',
                          style: TextStyle(
                              color: AppColors.textColorItem,
                              fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                          )),
                      Expanded(
                        child: Padding(
                          padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                          child: SizedBox(
                            height:
                            SizeUtil.getSize(3.0, GlobalData.sizeScreen!),
                            child: TextField(
                                textAlign: TextAlign.end,
                                focusNode: myFocusNodeSurname,
                                style: TextStyle(
                                    color: AppColors.textColorPhone,
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeUtil.getSize(1.8,
                                        GlobalData.sizeScreen!)),
                                controller: surnameController,
                                decoration: InputDecoration(
                                    hintText: '....',
                                    contentPadding: EdgeInsets.all(
                                        SizeUtil.getSize(
                                            1.5,
                                            GlobalData
                                                .sizeScreen!)),
                                    border: InputBorder.none),
                                onChanged: (text) {

                                }

                            ),
                          )
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          myFocusNodeSurname.requestFocus();
                        },
                        child: Icon(
                          Icons.edit,
                          color: AppColors.colorBackgrondProfile,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(SizeUtil.getSize(7.3,GlobalData.sizeScreen!), 0, 0, 0),
                    height: 1,
                    color: AppColors.colorLine),

                Padding(
                  padding:EdgeInsets.fromLTRB(SizeUtil.getSize(7.5,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                  child: Row(
                    children: [
                      Text('Имя',
                          style: TextStyle(
                              color: AppColors.textColorItem,
                              fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                          )),
                      Expanded(
                        child: Padding(
                          padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                          child: SizedBox(
                            height:
                            SizeUtil.getSize(3.0, GlobalData.sizeScreen!),
                            child: TextField(
                                textAlign: TextAlign.end,
                                focusNode: myFocusNodeName,
                                style: TextStyle(
                                    color: AppColors.textColorPhone,
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeUtil.getSize(1.8,
                                        GlobalData.sizeScreen!)),
                                controller: nameController,
                                decoration: InputDecoration(
                                    hintText: '....',
                                    contentPadding: EdgeInsets.all(
                                        SizeUtil.getSize(
                                            1.5,
                                            GlobalData
                                                .sizeScreen!)),
                                    border: InputBorder.none),
                                onChanged: (text) {

                                }

                            ),
                          )
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          myFocusNodeName.requestFocus();
                        },
                        child: Icon(
                          Icons.edit,
                          color: AppColors.colorBackgrondProfile,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(SizeUtil.getSize(7.3,GlobalData.sizeScreen!), 0, 0, 0),
                    height: 1,
                    color: AppColors.colorLine),

                Padding(
                  padding:EdgeInsets.fromLTRB(SizeUtil.getSize(7.5,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                  child: Row(
                    children: [
                      Text('Отчество',
                          style: TextStyle(
                              color: AppColors.textColorItem,
                              fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                          )),
                      Expanded(
                        child: Padding(
                          padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                          child:SizedBox(
                            height:
                            SizeUtil.getSize(3.0, GlobalData.sizeScreen!),
                            child: TextField(
                                textAlign: TextAlign.end,
                                focusNode: myFocusNodePatronymic,
                                style: TextStyle(
                                    color: AppColors.textColorPhone,
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeUtil.getSize(1.8,
                                        GlobalData.sizeScreen!)),
                                controller: patronymicControler,
                                decoration: InputDecoration(
                                    hintText: '....',
                                    contentPadding: EdgeInsets.all(
                                        SizeUtil.getSize(
                                            1.5,
                                            GlobalData
                                                .sizeScreen!)),
                                    border: InputBorder.none),
                                onChanged: (text) {

                                }

                            ),
                          )
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          myFocusNodePatronymic.requestFocus();
                        },
                        child: Icon(
                          Icons.edit,
                          color: AppColors.colorBackgrondProfile,
                        ),
                      ),

                    ],
                  ),
                ),

              ],
                  ),
                ),
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
      // if (newTextLength >= 7) {
      //   newText.write(newValue.text.substring(3, usedSubstringIndex = 6) + '-');
      //   if (newValue.selection.end >= 6) selectionIndex++;
      // }

      // if (newTextLength >= 11) {
      //   newText.write(newValue.text.substring(6, usedSubstringIndex = 10) + ' ');
      //   if (newValue.selection.end >= 10) selectionIndex++;
      // }
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



   class ItemCar extends StatefulWidget{

  @override
  State<ItemCar> createState() => _ItemCarState();
}

class _ItemCarState extends State<ItemCar> {
     String _typeCar = 'Седан';
     String _brandCar='.....';
     String _modelCar='.....';
     TextEditingController? numCarController;
     TextEditingController? regionCarController;
     Color _colorCar=Color.fromRGBO(77,77,77, 1.0);
     int? _index;
     int? _idBrand;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Container(
     margin:  EdgeInsets.fromLTRB(0,SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(0.8,GlobalData.sizeScreen!)),
     child: Column(
       children: [
         Container(
           height: SizeUtil.getSize(5,GlobalData.sizeScreen!),
           margin: EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0),
           child: Row(
             children: [
               SizedBox(
                 child: SvgPicture.asset('assets/ic_car.svg'),
                 height: SizeUtil.getSize(2.5,GlobalData.sizeScreen!),),
               Expanded(
                 child: Padding(
                   padding: EdgeInsets.fromLTRB(SizeUtil.getSize(2.0,GlobalData.sizeScreen!), 0, 0, 0),
                   child: Text('Автомобиль',
                     style: TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!),
                         color: AppColors.textColorTitle
                     ),),
                 ),
               ),

             ],
           ),
         ),
         Container(
           margin: EdgeInsets.fromLTRB(0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0, 0),
           color: Colors.white,
           child: Column(
             children: [
               Padding(
                 padding:EdgeInsets.fromLTRB(SizeUtil.getSize(7.5,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                 child: Row(
                   children: [
                     Text('Тип ТС',
                         style: TextStyle(
                             color: AppColors.textColorItem,
                             fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                         )),
                     Expanded(
                       child: Padding(
                         padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                         child:Align(
                           alignment: Alignment.centerRight,
                           child: DropdownButton<String>(
                             value: _typeCar,
                             icon: const Icon(Icons.arrow_drop_down,
                               color: Colors.black,),
                             iconSize: 24,
                             elevation: 16,
                             alignment: Alignment.centerRight,
                             style: TextStyle(color: AppColors.textColorPhone,
                                 fontWeight: FontWeight.bold,
                                 fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)),
                             underline: Container(
                               height: 2,
                               color: Colors.transparent,
                             ),
                             onChanged: (String? newValue) {
                               setState(() {
                                 _typeCar = newValue!;
                               });
                             },
                             items: <String>['Седан', 'Кроссовер', 'Внедорожник', 'Микроавтобус','Иное']
                                 .map<DropdownMenuItem<String>>((String value) {
                               return DropdownMenuItem<String>(
                                 value: value,
                                 child: Text(value),
                               );
                             }).toList(),
                           ),
                         ),

                       ),
                     ),
                   ],
                 ),
               ),
               Container(
                   margin: EdgeInsets.fromLTRB(SizeUtil.getSize(7.3,GlobalData.sizeScreen!), 0, 0, 0),
                   height: 1,
                   color: AppColors.colorLine),
               Padding(
                 padding:EdgeInsets.fromLTRB(SizeUtil.getSize(7.5,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                 child: Row(
                   children: [
                     Text('Номер ТС',
                         style: TextStyle(
                             color: AppColors.textColorItem,
                             fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                         )),
                     Expanded(
                       child: Padding(
                         padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                         child: Align(
                           alignment: Alignment.centerRight,
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.end,
                             children: [
                               Container(
                                 height: SizeUtil.getSize(6.0,GlobalData.sizeScreen!),
                                 width: SizeUtil.getSize(13,GlobalData.sizeScreen!),
                                 child: TextField(
                                   maxLength: 6,
                                   controller: numCarController,
                                   textAlign: TextAlign.center,
                                   decoration: InputDecoration(
                                     contentPadding: EdgeInsets.all(SizeUtil.getSize(0.5,GlobalData.sizeScreen!)),
                                     border: OutlineInputBorder(borderRadius: BorderRadius.only(topLeft:Radius.circular(10),bottomLeft: Radius.circular(10))),

                                   ),
                                 ),
                               ),
                               Container(
                                 height: SizeUtil.getSize(6.0,GlobalData.sizeScreen!),
                                 width: SizeUtil.getSize(8,GlobalData.sizeScreen!),
                                 child: TextField(
                                   maxLength: 3,
                                   controller: regionCarController,
                                   keyboardType: TextInputType.number,
                                   textAlign: TextAlign.center,
                                   decoration: InputDecoration(
                                     contentPadding: EdgeInsets.all(SizeUtil.getSize(0.5,GlobalData.sizeScreen!)),
                                       border: OutlineInputBorder(borderRadius: BorderRadius.only(topRight:Radius.circular(10),bottomRight: Radius.circular(10))),

                                   ),
                                 ),
                               ),
                             ],
                           ),
                         )
                       ),
                     ),

                   ],
                 ),
               ),
               Container(
                   margin: EdgeInsets.fromLTRB(SizeUtil.getSize(7.3,GlobalData.sizeScreen!), 0, 0, 0),
                   height: 1,
                   color: AppColors.colorLine),

               Padding(
                 padding:EdgeInsets.fromLTRB(SizeUtil.getSize(7.5,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                 child: Row(
                   children: [
                     Text('Марка ТС',
                         style: TextStyle(
                             color: AppColors.textColorItem,
                             fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                         )),
                     Expanded(
                       child: Padding(
                         padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                         child: Text(_brandCar,
                             textAlign: TextAlign.end,
                             style: TextStyle(
                                 color: AppColors.textColorPhone,
                                 fontWeight: FontWeight.bold,
                                 fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                             )),
                       ),
                     ),
                     Align(
                       alignment: Alignment.centerRight,
                       child: GestureDetector(
                         onTap: (){
                           _modelCar='.....';
                            Navigator.push(context, SlideTransitionLift(SearchBrand.brand(id: 0,
                              onSelected: (id,brand){
                                 setState(() {
                                   _idBrand=id;
                                   _brandCar=brand;
                                 });
                            },)));
                         },
                         child: Icon(
                           Icons.arrow_forward_ios,
                           color: AppColors.colorIndigo,
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
               Container(
                   margin: EdgeInsets.fromLTRB(SizeUtil.getSize(7.3,GlobalData.sizeScreen!), 0, 0, 0),
                   height: 1,
                   color: AppColors.colorLine),

               Padding(
                 padding:EdgeInsets.fromLTRB(SizeUtil.getSize(7.5,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                 child: Row(
                   children: [
                     Text('Модель ТС',
                         style: TextStyle(
                             color: AppColors.textColorItem,
                             fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                         )),
                     Expanded(
                       child: Padding(
                         padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                         child: Text(_modelCar,
                             textAlign: TextAlign.end,
                             style: TextStyle(
                                 color: AppColors.textColorPhone,
                                 fontWeight: FontWeight.bold,
                                 fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                             )),
                       ),
                     ),
                     Align(
                       alignment: Alignment.centerRight,
                       child: GestureDetector(
                         onTap: (){
                           if(_brandCar!='.....'){
                             Navigator.push(context, SlideTransitionLift(SearchBrand.model(id:_idBrand!,onSelected: (id,model){
                               setState(() {
                                 _modelCar=model;
                               });
                             })));
                           }else{
                             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                               content: Text('Выбери марку'),));
                           }
                         },
                         child: Icon(
                           Icons.arrow_forward_ios,
                           color: AppColors.colorIndigo,
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
               Container(
                   margin: EdgeInsets.fromLTRB(SizeUtil.getSize(7.3,GlobalData.sizeScreen!), 0, 0, 0),
                   height: 1,
                   color: AppColors.colorLine),

               Padding(
                 padding:EdgeInsets.fromLTRB(SizeUtil.getSize(7.5,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                 child: Row(
                   children: [
                     Text('Цвет',
                         style: TextStyle(
                             color: AppColors.textColorItem,
                             fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                         )),
                     Expanded(
                       child: Padding(
                         padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                         child: Align(
                           alignment: Alignment.centerRight,
                           child: Container(
                             width: SizeUtil.getSize(5,GlobalData.sizeScreen!),
                             height: SizeUtil.getSize(2.5,GlobalData.sizeScreen!),
                             decoration: BoxDecoration(
                                 border: _index==1?Border.all(
                                   color: AppColors.colorsCar[0],
                                   width: 0.5,
                                 ):null,
                               color: _colorCar,
                               borderRadius: BorderRadius.all(Radius.circular(10))
                             ),
                           ),
                         )
                       ),
                     ),
                     Align(
                       alignment: Alignment.centerRight,
                       child: GestureDetector(
                         onTap: (){
                           showMaterialModalBottomSheet(
                             backgroundColor: Colors.transparent,
                               context: context,
                               builder: (context) => BottomSheetColorContent(
                                 onColorCar: (color,index){
                                    setState(() {
                                      _index=index;
                                      _colorCar=color!;
                                    });
                               },));
                         },
                         child: Icon(
                           Icons.arrow_forward_ios,
                           color: AppColors.colorIndigo,
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
   );
  }

     @override
  void initState() {
        numCarController=TextEditingController();
        regionCarController=TextEditingController();
        numCarController!.text='A000AA';
        regionCarController!.text='000';
     }
}




    class ItemDate extends StatelessWidget{

      String? date;
      String? time;
      int? post;

      ItemDate({required this.date,required this.post, required this.time});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin:  EdgeInsets.fromLTRB(0,SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(0.8,GlobalData.sizeScreen!)),
      child: Column(
        children: [
          Container(
            height: SizeUtil.getSize(5,GlobalData.sizeScreen!),
            margin: EdgeInsets.fromLTRB(SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0,SizeUtil.getSize(3.0,GlobalData.sizeScreen!),0),
            child: Row(
              children: [
                SizedBox(
                  child: SvgPicture.asset('assets/ic_calendar.svg'),
                  height: SizeUtil.getSize(2.5,GlobalData.sizeScreen!),),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(SizeUtil.getSize(2.0,GlobalData.sizeScreen!), 0, 0, 0),
                    child: Text('Дата и время',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!),
                          color: AppColors.textColorTitle
                      ),),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Expanded(
                    child: Text('Править',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!),
                          color: AppColors.colorIndigo
                      ),),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0, 0),
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding:EdgeInsets.fromLTRB(SizeUtil.getSize(7.5,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                  child: Row(
                    children: [
                      Text('Дата',
                          style: TextStyle(
                              color: AppColors.textColorItem,
                              fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                          )),
                      Expanded(
                        child: Padding(
                          padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                          child: Text('$date',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: AppColors.textColorPhone,
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(SizeUtil.getSize(7.3,GlobalData.sizeScreen!), 0, 0, 0),
                    height: 1,
                    color: AppColors.colorLine),
                Padding(
                  padding:EdgeInsets.fromLTRB(SizeUtil.getSize(7.5,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                  child: Row(
                    children: [
                      Text('Время',
                          style: TextStyle(
                              color: AppColors.textColorItem,
                              fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                          )),
                      Expanded(
                        child: Padding(
                          padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                          child: Text('$time',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: AppColors.textColorPhone,
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                              )),
                        ),
                      ),

                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(SizeUtil.getSize(7.3,GlobalData.sizeScreen!), 0, 0, 0),
                    height: 1,
                    color: AppColors.colorLine),

                Padding(
                  padding:EdgeInsets.fromLTRB(SizeUtil.getSize(7.5,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
                  child: Row(
                    children: [
                      Text('№ поста',
                          style: TextStyle(
                              color: AppColors.textColorItem,
                              fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                          )),
                      Expanded(
                        child: Padding(
                          padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                          child: Text('$post',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: AppColors.textColorPhone,
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                              )),
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
    );


  }

}

    class Work extends StatelessWidget{

   String details;
   Work(this.details);

  @override
  Widget build(BuildContext context) {
   return  Column(
     children: [
       Padding(
         padding:EdgeInsets.fromLTRB(SizeUtil.getSize(7.5,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!),SizeUtil.getSize(1.0,GlobalData.sizeScreen!)),
         child: Row(
           children: [
             Text('Люкс',
                 style: TextStyle(
                     color: AppColors.textColorItem,
                     fontSize: SizeUtil.getSize(1.8,GlobalData.sizeScreen!)
                 )),
             Expanded(
               child: Padding(
                 padding:EdgeInsets.fromLTRB(0, 0, SizeUtil.getSize(1.0,GlobalData.sizeScreen!), 0),
                 child: Text('3000 ₽',
                     textAlign: TextAlign.end,
                     style: TextStyle(
                         color: AppColors.textColorPhone,
                         fontWeight: FontWeight.bold,
                         fontSize: SizeUtil.getSize(2.0,GlobalData.sizeScreen!)
                     )),
               ),
             ),

           ],
         ),
       ),
       details.isEmpty?Container(
           margin: EdgeInsets.fromLTRB(SizeUtil.getSize(7.3,GlobalData.sizeScreen!), 0, 0, 0),
           height: 1,
           color: AppColors.colorLine):Container(),

       details.isNotEmpty?Container(
         color: AppColors.colorBackgrondProfile,
         child: Padding(
           padding: EdgeInsets.all(SizeUtil.getSize(1.5,GlobalData.sizeScreen!)),
           child: Text('Мойка ковриков, чистка передних сидений, полировка панели, чистка задних сидений',
             textAlign: TextAlign.center,
             style: TextStyle(
             color: AppColors.textColorDark_100
           ),),
         ),
       ):Container()
     ],
   );

  }


}

  class BottomSheetColorContent extends StatefulWidget{

   var onColorCar=(Color? color,int? index)=>color,index;

  @override
  StateBottomSheetColorContent createState() {
    // TODO: implement createState
    return StateBottomSheetColorContent();
  }

   BottomSheetColorContent({required this.onColorCar});
}

  class StateBottomSheetColorContent extends State<BottomSheetColorContent>{

   int? _selected;

  @override
  Widget build(BuildContext context) {
   return Container(
     height: MediaQuery.of(context).size.height/4.0,
     decoration: BoxDecoration(
       color: Colors.white,
       borderRadius: BorderRadius.only(topLeft: Radius.circular(SizeUtil.getSize(4.0,GlobalData.sizeScreen!)),topRight: Radius.circular(SizeUtil.getSize(4.0,GlobalData.sizeScreen!))),
     ),
     child: GridView(
         gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
             maxCrossAxisExtent: 80,
             childAspectRatio: 3 / 2,
             crossAxisSpacing: 10,
             mainAxisSpacing: 10
         ),
            children:
         List.generate(10, (index){
               return Container(
                 alignment: Alignment.center,
                   width: SizeUtil.getSize(10.0,GlobalData.sizeScreen!),
                   height: SizeUtil.getSize(10.0,GlobalData.sizeScreen!),
                   decoration: BoxDecoration(
                       border: _selected==index?Border.all(
                         color: AppColors.colorsCar[0],
                         width: 2,
                       ):null,
                       shape: BoxShape.circle,
                       color: Colors.transparent),
               child: GestureDetector(
                 onTap: (){
                     setState(() {
                       _selected=index;
                       widget.onColorCar(AppColors.colorsCar[index],index);
                       Navigator.pop(context);
                     });
                 },
                 child: Container(
                     width: SizeUtil.getSize(5.0,GlobalData.sizeScreen!),
                     height: SizeUtil.getSize(5.0,GlobalData.sizeScreen!),
                     decoration: BoxDecoration(
                         border: index==1?Border.all(
                           color: AppColors.colorsCar[0],
                           width: 0.5,
                         ):null,
                         shape: BoxShape.circle,
                         color: AppColors.colorsCar[index])),
               ),);
     })
    ,
   ));
  }

  }