



 class ModelDataTableApi{

   int posts;
   int startDayHour;
   int startDayMin;
   int endDayHour;
   int endDayMin;
   bool isWorkDay;
   int maxRecordRange;

  ModelDataTableApi.fromApi({required Map<String,dynamic> map}):
        posts=map['posts'],
    startDayHour=map['startDayHour'],
   startDayMin=map['startDayMin'],
   endDayHour=map['endDayHour'],
   endDayMin=map['endDayMin'],
   isWorkDay=map['isWorkDay'],
   maxRecordRange=map['maxRecordRange'];
 }