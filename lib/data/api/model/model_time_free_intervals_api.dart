



 class ModelTimeFreeIntervalsApi{

   String message;
   List<dynamic> intervals;

   ModelTimeFreeIntervalsApi.fromApi({required Map<String,dynamic> map}):
       message=map['message'],
       intervals=map['intervals'];

}