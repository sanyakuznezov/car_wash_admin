




import 'package:car_wash_admin/domain/state/bloc_table_order.dart';
import 'package:car_wash_admin/global_data.dart';

class AppModule{
    static BlocTableOrder? _blocTableOrder;

    static BlocTableOrder blocTableInstance(){
      GlobalData.date=DateTime.now().toString().split(' ')[0];
      _blocTableOrder=BlocTableOrder();
      return _blocTableOrder!;
    }

    static get blocTable =>_blocTableOrder;


    

}