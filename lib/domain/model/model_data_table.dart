


 class ModelDataTable{


  int posts;
  int startDayHour;
  int startDayMin;
  int endDayHour;
  int endDayMin;
  bool isWorkDay;

  ModelDataTable({required this.posts, required this.startDayHour, required this.startDayMin,
    required this.endDayHour, required this.endDayMin, required this.isWorkDay});
}