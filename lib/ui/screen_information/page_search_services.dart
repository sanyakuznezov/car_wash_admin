


  import 'package:car_wash_admin/domain/model/model_service.dart';
import 'package:car_wash_admin/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../app_colors.dart';
import '../../global_data.dart';

class PageSearchServices extends StatefulWidget{

  List<ModelService> mainList=[];

  @override
  State<PageSearchServices> createState() => _PageSearchServicesState();

  PageSearchServices({required this.mainList});
}

class _PageSearchServicesState extends State<PageSearchServices> {

  TextEditingController _myController = TextEditingController();
  List<ModelService> _searchList=[];
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
                _searchList.length != 0 || _myController.text.isNotEmpty
                    ? Column(
                        children: List.generate(_searchList.length, (index) {
                          return _ItemList(
                            modelService: _searchList[index],
                            listServices: widget.mainList,
                          );
                        }),
                      )
                    :Column(
                        children:
                            List.generate(widget.mainList.length, (index) {
                          return _ItemList(
                              modelService: widget.mainList[index],
                              listServices: widget.mainList);
                        }),
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
      for (int i = 0; i < widget.mainList.length; i++) {
        ModelService data = widget.mainList[i];
        if (data.name.toLowerCase().contains(text.toLowerCase())) {
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

  class _ItemList extends StatefulWidget{


    var onSelect=(ModelService? modelService,bool isRemove)=>modelService,isRemove;
    ModelService modelService;
    List<ModelService> listServices;



    _ItemList({required this.modelService,required this.listServices});

    @override
    State<_ItemList> createState() => _ItemListState();
  }

  class _ItemListState extends State<_ItemList>{


    bool _isSelect=false;
    double _turns = 0.0;


    @override
    void initState() {
      super.initState();

    }

    @override
    void dispose() {
      super.dispose();

    }

    @override
    Widget build(BuildContext context) {
      return GestureDetector(
        onTap: (){
          setState(() {
            if(_isSelect){
              _isSelect=false;
              _turns=0.0;
            }else{
              _isSelect=true;
              _turns=0.5;

            }
          });
        },
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(0, SizeUtil.getSize(1.0,
              GlobalData.sizeScreen!), 0,0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding:  EdgeInsets.fromLTRB(SizeUtil.getSize(
                        5.0,
                        GlobalData.sizeScreen!), 0, 0, 0),
                    child: Text(widget.modelService.name,
                      style:TextStyle(
                          fontSize: SizeUtil.getSize(
                              2.0, GlobalData.sizeScreen!),
                          color: Colors.black
                      ),),
                  ),
                  Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('${widget.modelService.price} RUB',
                              style: TextStyle(
                                  color: AppColors.colorText22,
                                  fontSize:
                                  SizeUtil.getSize(2.0, GlobalData.sizeScreen!))),
                          widget.modelService.type=='complex'
                              ? Container(
                              height: SizeUtil.getSize(3.0, GlobalData.sizeScreen!),
                              width: SizeUtil.getSize(4.0, GlobalData.sizeScreen!),
                              child:   AnimatedRotation(
                                  duration: Duration(milliseconds: 600),
                                  turns: _turns,
                                  child: Icon(Icons.arrow_drop_down,color: AppColors.colorIndigo,)))
                              : Container(
                            height: SizeUtil.getSize(3.0, GlobalData.sizeScreen!),
                            width: SizeUtil.getSize(4.0, GlobalData.sizeScreen!),
                          ),
                        ],
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
                ),),
              widget.modelService.type=='complex'&&_isSelect?Container(
                width: MediaQuery.of(context).size.width,
                color: AppColors.colorBackgrondProfile,
                child: Padding(
                  padding: EdgeInsets.all(SizeUtil.getSize(1.5,GlobalData.sizeScreen!)),
                  child: Text('${getTextDetails(widget.listServices,widget.modelService.id)}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.textColorDark_100
                    ),),
                ),
              ):Container(),
            ],
          ),
        ),
      );
    }

    String getTextDetails(List<ModelService> list,int id){
      String tetx='';
      list.forEach((element) {
        if(element.id==id){
          element.listServices.forEach((el) {
            tetx+='${el.name}; ';
          });


        }
      });

      return tetx;
    }

  }