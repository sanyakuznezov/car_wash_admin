


 import 'package:car_wash_admin/app_colors.dart';
import 'package:car_wash_admin/domain/model/model_worker.dart';
import 'package:car_wash_admin/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../../global_data.dart';

class PageListWorkers extends StatefulWidget{

   var onWorker=(ModelWorker? modelWorker)=>modelWorker;
   List<ModelWorker>? list;
   ModelWorker selWorker;


  @override
  State<PageListWorkers> createState() => _PageListWorkersState();

   PageListWorkers({required this.onWorker, required this.list,required this.selWorker});
}

class _PageListWorkersState extends State<PageListWorkers> {

  ModelWorker? _selWorker;
  bool _isSelected=false;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:           AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Container(
            width: MediaQuery.of(context).size.width,
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
                  Center(
                    child: Text(
                      'Список работников',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: SizeUtil.getSize(
                              2.8, GlobalData.sizeScreen!)),
                    ),
                  ),


                ],
              ),
            ),
          )

        ],
      ),
      floatingActionButton: _isSelected?FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.pop(context);
          if(_selWorker!=null){
            widget.onWorker(_selWorker!);
          }else{
            widget.onWorker(null);
          }
        },
        child: const Icon(Icons.check_outlined,color:Colors.indigo),
        backgroundColor: Colors.white,
      ):null,
      backgroundColor: AppColors.colorBackgrondProfile,
      body: Column(
        children: [
          Padding(
            padding:  EdgeInsets.fromLTRB(0, SizeUtil.getSize(4.0,
                GlobalData.sizeScreen!), 0,0),
            child: Column(
              children: List.generate(widget.list!.length, (index){
                return ItemList(modelWorker: widget.list![index],
                    onSelect: (data,selected){
                      setState(() {
                        if(selected){
                          _isSelected=true;
                          _selWorker=data;
                        }else{
                          _selWorker=null;
                          _isSelected=true;
                        }
                      });



                },
                    alreadySelected: widget.selWorker);
              }),
            ),
          )

        ],
      ),
    );
  }
}

 class ItemList extends StatefulWidget{


   var onSelect=(ModelWorker? modelWorker,bool selected)=>modelWorker,selected;
   ModelWorker modelWorker;
   ModelWorker alreadySelected;
   bool isSelect=false;



   ItemList({required this.modelWorker,required this.onSelect,required this.alreadySelected});

   @override
   State<ItemList> createState() => _ItemListState();
 }

 class _ItemListState extends State<ItemList> {


   bool _isAlreadySelected=false;
   bool _isSelect=false;

   @override
   Widget build(BuildContext context) {
     if(!_isAlreadySelected){
       _isAlreadySelected=true;
       if(widget.alreadySelected.id==widget.modelWorker.id){
         _isSelect=true;
       }
     }



     return GestureDetector(
       onTap: (){
           setState(() {
             if(_isSelect){
             _isSelect=false;
               widget.onSelect(widget.modelWorker,_isSelect);
             }else{
               _isSelect=true;
               widget.onSelect(widget.modelWorker,_isSelect);
             }
           });



       },
       child: Container(
         color: Colors.white,
         padding: EdgeInsets.fromLTRB(SizeUtil.getSize(2.0,
             GlobalData.sizeScreen!), SizeUtil.getSize(1.0,
             GlobalData.sizeScreen!), 0,0),
         child: Column(
           children: [
             Row(
               children: [
                CircleAvatar(
                  foregroundImage: NetworkImage(GlobalData.URL_BASE_IMAGE+widget.modelWorker.avatar),
                  backgroundColor: AppColors.colorBackgrondProfile,
                  radius: SizeUtil.getSize(
                      3.0,
                      GlobalData.sizeScreen!),
                  child:CircularProgressIndicator(color: AppColors.colorLine,strokeWidth: 2,),),
                 Padding(
                   padding:  EdgeInsets.fromLTRB(SizeUtil.getSize(
                       1.0,
                       GlobalData.sizeScreen!), 0, 0, 0),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text('${widget.modelWorker.lastname} ${widget.modelWorker.firstname[0]}. ${widget.modelWorker.patronymic[0]}.',
                         textAlign: TextAlign.start,
                         style:TextStyle(
                             fontSize: SizeUtil.getSize(
                                 2.0, GlobalData.sizeScreen!),
                             color: Colors.black
                         ),),
                       Padding(
                         padding:EdgeInsets.fromLTRB(0, SizeUtil.getSize(
                             0.5, GlobalData.sizeScreen!),0,0),
                         child: Row(
                           children: [
                             Icon(Icons.verified_user_outlined,color: Colors.green,size: SizeUtil.getSize(
                                 2.0, GlobalData.sizeScreen!),),
                             Text('${widget.modelWorker.post}',
                               textAlign: TextAlign.start,
                               style:TextStyle(
                                   fontWeight: FontWeight.bold,
                                   fontSize: SizeUtil.getSize(
                                       1.7, GlobalData.sizeScreen!),
                                   color: AppColors.textColorHint
                               ),),
                           ],
                         ),
                       ),

                       Padding(
                         padding:EdgeInsets.fromLTRB(0, SizeUtil.getSize(
                             0.5, GlobalData.sizeScreen!),0,0),
                         child: Row(
                           children: [
                             Icon(Icons.phone,color: Colors.green,size: SizeUtil.getSize(
                                 2.0, GlobalData.sizeScreen!),),
                             Text('${widget.modelWorker.phone}',
                               textAlign: TextAlign.start,
                               style:TextStyle(
                                   fontSize: SizeUtil.getSize(
                                       1.7, GlobalData.sizeScreen!),
                                   color: AppColors.textColorHint
                               ),),
                           ],
                         ),
                       ),
                     ],
                   ),
                 ),
                 Expanded(
                     child: _isSelect? Align(
                           alignment: Alignment.centerRight,
                           child: Container(
                           height: SizeUtil.getSize(3.0, GlobalData.sizeScreen!),
                           width: SizeUtil.getSize(4.0, GlobalData.sizeScreen!),
                           child: SvgPicture.asset('assets/frame.svg')),
                         )
                         : Container(
                       height: SizeUtil.getSize(3.0, GlobalData.sizeScreen!),
                       width: SizeUtil.getSize(4.0, GlobalData.sizeScreen!),
                     )),
               ],
             ),
             Padding(padding: EdgeInsets.fromLTRB(SizeUtil.getSize(
                 5.0,
                 GlobalData.sizeScreen!), SizeUtil.getSize(
                 1.0,
                 GlobalData.sizeScreen!), 0, 0),
               child: Container(
                 height: 1,
                 color: AppColors.colorLine,
               ),)
           ],
         ),
       ),
     );
   }
 }