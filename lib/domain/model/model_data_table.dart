


 class ModelDataTable{


  int posts;
  int startDayHour;
  int startDayMin;
  int endDayHour;
  int endDayMin;
  bool isWorkDay;
  int maxRecordRange;

  ModelDataTable({required this.maxRecordRange,required this.posts, required this.startDayHour, required this.startDayMin,
    required this.endDayHour, required this.endDayMin, required this.isWorkDay});
}