


 import 'package:car_wash_admin/data/api/model/model_data_table_api.dart';
import 'package:car_wash_admin/domain/model/model_data_table.dart';

class MapperDataTable{

  static ModelDataTable fromApi({required ModelDataTableApi modelDataTableApi}){

    return ModelDataTable(maxRecordRange:modelDataTableApi.maxRecordRange,posts: modelDataTableApi.posts,
        startDayHour: modelDataTableApi.startDayHour, startDayMin: modelDataTableApi.startDayMin,
        endDayHour: modelDataTableApi.endDayHour, endDayMin: modelDataTableApi.endDayMin, isWorkDay: modelDataTableApi.isWorkDay);
  }


 }