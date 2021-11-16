


 import 'package:car_wash_admin/app_colors.dart';
import 'package:car_wash_admin/domain/model/model_brand_car.dart';
import 'package:car_wash_admin/internal/dependencies/repository_module.dart';
import 'package:car_wash_admin/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';


import '../../../global_data.dart';

class SearchBrand extends StatefulWidget{

  int id;
  var onSelected=(int? id,String title)=>id,title;


  @override
  StateSearchBrand createState() {
    // TODO: implement createState
   return StateSearchBrand();
  }

  SearchBrand.brand({required this.id,required this.onSelected});
  SearchBrand.model({required this.id,required this.onSelected});
}


class StateSearchBrand extends State<SearchBrand>{

  TextEditingController _myController = TextEditingController();
  List<ModelBrandCar> _mainList=[];
  List<ModelBrandCar> _searchList=[];
  bool? _isSearching;



  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: AppColors.colorBackgrondProfile,
     body: SingleChildScrollView(
       child: Container(
          padding: EdgeInsets.fromLTRB(SizeUtil.getSize(2.0, GlobalData.sizeScreen!), SizeUtil.getSize(5.0, GlobalData.sizeScreen!),SizeUtil.getSize(2.0, GlobalData.sizeScreen!), 0),
          color: Colors.white,
         child: Wrap(
           children:[
             Column(
             children: [
               Row(
                 children: [
               Expanded(
               child: Container(
                 margin: EdgeInsets.all(SizeUtil.getSize(
                     1.0,
                     GlobalData.sizeScreen!)),
               decoration: BoxDecoration(
                   color: AppColors.colorBackgrondProfile,
                   borderRadius: BorderRadius.circular(SizeUtil.getSize(
                   1.0,
                   GlobalData.sizeScreen!))
               ),
                 child: TextField(
                   onChanged: (value){
                     if (_myController.text.isEmpty) {
                       setState(() {
                         _isSearching = false;
                       });
                     } else {
                       setState(() {
                         _isSearching = true;
                       });
                     }
                     search(value);
                   },
                 decoration: InputDecoration(
                   hintStyle: TextStyle(
                     color: Colors.grey
                   ),
                     hintText: 'Поиск',
                     border: InputBorder.none,
                     icon: Padding(
                       padding: EdgeInsets.all(SizeUtil.getSize(
                           1.0,
                           GlobalData.sizeScreen!)),
                       child: Icon(Icons.search,
                           color: Colors.grey),
                     )
                 ),
                     controller: _myController),
               )),
               GestureDetector(
                 onTap:(){
                    Navigator.pop(context);
                 },
                 child: Text('Отмена',
                   style: TextStyle(
                     color:
                     AppColors.colorIndigo,
                     fontSize: SizeUtil.getSize(
                         2.3,
                         GlobalData.sizeScreen!),
                   ),
                 ),
               )
                 ],
               ),
               FutureBuilder<List<ModelBrandCar>>(
                 future: RepositoryModule.userRepository().getListBrandCar(context:context,id: widget.id),
                 builder: (context,data){
                   if(data.hasData){
                     if(_searchList.length != 0 || _myController.text.isNotEmpty){
                       return Column(
                         children: List.generate(_searchList.length, (index){
                           return  ItemBrand(
                             id: _searchList[index].id,
                             title: _searchList[index].title,
                             onSelect: (id,brand){
                               widget.onSelected(id,brand);
                               Navigator.pop(context);
                             },);
                         }),
                       );
                     }else{
                       return Column(
                         children: List.generate(data.data!.length, (index){
                           _mainList.add(data.data![index]);
                           return  ItemBrand(
                             id: data.data![index].id,
                             title: data.data![index].title,
                             onSelect: (id,brand){
                               widget.onSelected(id,brand);
                               Navigator.pop(context);
                             },);
                         }),
                       );
                     }

                   }else{
                     return Center(
                       child: Padding(
                         padding: EdgeInsets.all(SizeUtil.getSize(
                             2,
                             GlobalData.sizeScreen!)),
                         child: SizedBox(
                           width:  SizeUtil.getSize(
                               2,
                               GlobalData.sizeScreen!),
                           height: SizeUtil.getSize(
                               2,
                               GlobalData.sizeScreen!),
                           child: CircularProgressIndicator(color: AppColors.colorIndigo,strokeWidth:  SizeUtil.getSize(
                               0.3,
                               GlobalData.sizeScreen!),),
                         ),
                       ),
                     );
                   }

                 },
               )

             ],
           ),]
         ),
       ),
     ),
   );
  }

   void search(String text) {
     _searchList.clear();
     if (_isSearching != null) {
       for (int i = 0; i < _mainList.length; i++) {
         ModelBrandCar data = _mainList[i];
         if (data.title.toLowerCase().contains(text.toLowerCase())) {
           _searchList.add(data);
         }
       }
     }
   }

  @override
  void dispose() {
    super.dispose();
    _myController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _isSearching = false;
  }


}


 class ItemBrand extends StatefulWidget{

    int id;
    String title;
    var onSelect=(int? id,String brand)=>id,brand;

    ItemBrand({required this.id, required this.title,required this.onSelect});

  @override
  State<ItemBrand> createState() => _ItemBrandState();
}

class _ItemBrandState extends State<ItemBrand> {

  bool _isSelect=false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          if(_isSelect){
            _isSelect=false;
          }else{
            _isSelect=true;
            widget.onSelect(widget.id,widget.title);
          }
        });

      },
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding:  EdgeInsets.fromLTRB(SizeUtil.getSize(
            5.0,
            GlobalData.sizeScreen!), 0, 0, 0),
                  child: Text(widget.title,
                  style:TextStyle(
                    color: Colors.black
                  ),),
                ),
                Expanded(
                  child: _isSelect?Align(
                      alignment: Alignment.centerRight,
                      child:SvgPicture.asset('assets/frame.svg')
                  ):Container(),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.fromLTRB(SizeUtil.getSize(
                5.0,
                GlobalData.sizeScreen!), 0, 0, 0),
            child: Divider(),)
          ],
        ),
      ),
    );
  }
}