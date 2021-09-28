




import 'package:car_wash_admin/domain/state/bloc_table_order.dart';

class AppModule{
    static BlocTableOrder? _blocTableOrder;

    static BlocTableOrder blocTableInstance(){
      _blocTableOrder=BlocTableOrder();
      return _blocTableOrder!;
    }

    static get blocTable =>_blocTableOrder;

}