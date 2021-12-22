



 import 'package:car_wash_admin/data/api/model/model_time_free_intervals_api.dart';
import 'package:car_wash_admin/domain/model/model_time_free_intervals.dart';

class MapperIntervalsFree{


   static ModelTimeFreeIntervals fromApi({required ModelTimeFreeIntervalsApi modelTimeFreeIntervalsApi}){

     return ModelTimeFreeIntervals(message: modelTimeFreeIntervalsApi.message, intervals: modelTimeFreeIntervalsApi.intervals);
   }


 }