

 class GlobalData{


   static bool edit_mode=false;
   static int? numBoxes;
   static bool accept=false;
   static int stateTime=0;
   static double? sizeScreen;
   static double bodyHeightFeedBackWidget=0;
   static String? timeStart;
   static String? timeEnd;
   static int? endDayMin;
   static int? startDayMin;
   static int? post;
   static int? id;
   static int? idOrder;
   static int? maxRecordRange;
   static bool? isCollision=false;
   static const String URL_BASE_IMAGE='';
   static String? date;
   static const int EDIT_MODE=0;
   static const int VIEW_MODE=1;
   static const int ADD_ORDER_MODE=2;
   static List<List> times=[time_1,time_2,time_3,time_4];

   static List<Map> timeSelect = [
     {'time':'00','index':0},
     {'time':'01','index':1},
     {'time':'02','index':2},
     {'time':'03','index':3},
     {'time':'04','index':4},
     {'time':'05','index':5},
     {'time':'06','index':6},
     {'time':'07','index':7},
     {'time':'08','index':8},
     {'time':'09','index':9},
     {'time':'10','index':10},
     {'time':'11','index':11},
     {'time':'12','index':12},
     {'time':'13','index':13},
     {'time':'14','index':14},
     {'time':'15','index':15},
     {'time':'16','index':16},
     {'time':'17','index':17},
     {'time':'18','index':18},
     {'time':'19','index':19},
     {'time':'20','index':20},
     {'time':'21','index':21},
     {'time':'22','index':22},
     {'time':'23','index':23},

   ];

   static List<String> time_1 = [
     '00:00',
     '01:00',
     '02:00',
     '03:00',
     '04:00',
     '05:00',
     '06:00',
     '07:00',
     '08:00',
     '09:00',
     '10:00',
     '11:00',
     '12:00',
     '13:00',
     '14:00',
     '15:00',
     '16:00',
     '17:00',
     '18:00',
     '19:00',
     '20:00',
     '21:00',
     '22:00',
     '23:00',
     '24:00',

   ];
   static List<String> time_2=[
     '00:00',
     '00:30',
     '01:00',
     '01:30',
     '02:00',
     '02:30',
     '03:00',
     '03:30',
     '04:00',
     '04:30',
     '05:00',
     '05:30',
     '06:00',
     '06:30',
     '07:00',
     '07:30',
     '08:00',
     '08:30',
     '09:00',
     '09:30',
     '10:00',
     '10:30',
     '11:00',
     '11:30',
     '12:00',
     '12:30',
     '13:00',
     '13:30',
     '14:00',
     '14:30',
     '15:00',
     '15:30',
     '16:00',
     '16:30',
     '17:00',
     '17:30',
     '18:00',
     '18:30',
     '19:00',
     '19:30',
     '20:00',
     '20:30',
     '21:00',
     '21:30',
     '22:00',
     '22:30',
     '23:00',
     '23:30',
     '24:00',
   ];

   static List<String> time_3=[
     '00:00',
     '00:15',
     '00:30',
     '00:45',
     '01:00',
     '01:15',
     '01:30',
     '01:45',
     '02:00',
     '02:15',
     '02:30',
     '02:45',
     '03:00',
     '03:15',
     '03:30',
     '03:45',
     '04:00',
     '04:15',
     '04:30',
     '04:45',
     '05:00',
     '05:15',
     '05:30',
     '05:45',
     '06:00',
     '06:15',
     '06:30',
     '06:45',
     '07:00',
     '07:15',
     '07:30',
     '07:45',
     '08:00',
     '08:15',
     '08:30',
     '08:45',
     '09:00',
     '09:15',
     '09:30',
     '09:45',
     '10:00',
     '10:15',
     '10:30',
     '10:45',
     '11:00',
     '11:15',
     '11:30',
     '11:45',
     '12:00',
     '12:15',
     '12:30',
     '12:45',
     '13:00',
     '13:15',
     '13:30',
     '13:45',
     '14:00',
     '14:15',
     '14:30',
     '14:45',
     '15:00',
     '15:15',
     '15:30',
     '15:45',
     '16:00',
     '16:15',
     '16:30',
     '16:45',
     '17:00',
     '17:15',
     '17:30',
     '17:45',
     '18:00',
     '18:15',
     '18:30',
     '18:45',
     '19:00',
     '19:15',
     '19:30',
     '19:45',
     '20:00',
     '20:15',
     '20:30',
     '20:45',
     '21:00',
     '21:15',
     '21:30',
     '21:45',
     '22:00',
     '22:15',
     '22:30',
     '22:45',
     '23:00',
     '23:15',
     '23:30',
     '23:45',
     '24:00',
   ];

   static List<String> time_4=[
     '00:00',
     '00:05',
     '00:10',
     '00:15',
     '00:20',
     '00:25',
     '00:30',
     '00:35',
     '00:40',
     '00:45',
     '00:50',
     '00:55',
     '01:00',
     '01:05',
     '01:10',
     '01:15',
     '01:20',
     '01:25',
     '01:30',
     '01:35',
     '01:40',
     '01:45',
     '01:50',
     '01:55',
     '02:00',
     '02:05',
     '02:10',
     '02:15',
     '02:20',
     '02:25',
     '02:30',
     '02:35',
     '02:40',
     '02:45',
     '02:50',
     '02:55',
     '03:00',
     '03:05',
     '03:10',
     '03:15',
     '03:20',
     '03:25',
     '03:30',
     '03:35',
     '03:40',
     '03:45',
     '03:50',
     '03:55',
     '04:00',
     '04:05',
     '04:10',
     '04:15',
     '04:20',
     '04:25',
     '04:30',
     '04:35',
     '04:40',
     '04:45',
     '04:50',
     '04:55',
     '05:00',
     '05:05',
     '05:10',
     '05:15',
     '05:20',
     '05:25',
     '05:30',
     '05:35',
     '05:40',
     '05:45',
     '05:50',
     '05:55',
     '06:00',
     '06:05',
     '06:10',
     '06:15',
     '06:20',
     '06:25',
     '06:30',
     '06:35',
     '06:40',
     '06:45',
     '06:50',
     '06:55',
     '07:00',
     '07:05',
     '07:10',
     '07:15',
     '07:20',
     '07:25',
     '07:30',
     '07:35',
     '07:40',
     '07:45',
     '07:50',
     '07:55',
     '08:00',
     '08:05',
     '08:10',
     '08:15',
     '08:20',
     '08:25',
     '08:30',
     '08:35',
     '08:40',
     '08:45',
     '08:50',
     '08:55',
     '09:00',
     '09:05',
     '09:10',
     '09:15',
     '09:20',
     '09:25',
     '09:30',
     '09:35',
     '09:40',
     '09:45',
     '09:50',
     '09:55',
     '10:00',
     '10:05',
     '10:10',
     '10:15',
     '10:20',
     '10:25',
     '10:30',
     '10:35',
     '10:40',
     '10:45',
     '10:50',
     '10:55',
     '11:00',
     '11:05',
     '11:10',
     '11:15',
     '11:20',
     '11:25',
     '11:30',
     '11:35',
     '11:40',
     '11:45',
     '11:50',
     '11:55',
     '12:00',
     '12:05',
     '12:10',
     '12:15',
     '12:20',
     '12:25',
     '12:30',
     '12:35',
     '12:40',
     '12:45',
     '12:50',
     '12:55',
     '13:00',
     '13:05',
     '13:10',
     '13:15',
     '13:20',
     '13:25',
     '13:30',
     '13:35',
     '13:40',
     '13:45',
     '13:50',
     '13:55',
     '14:00',
     '14:05',
     '14:10',
     '14:15',
     '14:20',
     '14:25',
     '14:30',
     '14:35',
     '14:40',
     '14:45',
     '14:50',
     '14:55',
     '15:00',
     '15:05',
     '15:10',
     '15:15',
     '15:20',
     '15:25',
     '15:30',
     '15:35',
     '15:40',
     '15:45',
     '15:50',
     '15:55',
     '16:00',
     '16:05',
     '16:10',
     '16:15',
     '16:20',
     '16:25',
     '16:30',
     '16:35',
     '16:40',
     '16:45',
     '16:50',
     '16:55',
     '17:00',
     '17:05',
     '17:10',
     '17:15',
     '17:20',
     '17:25',
     '17:30',
     '17:35',
     '17:40',
     '17:45',
     '17:50',
     '17:55',
     '18:00',
     '18:05',
     '18:10',
     '18:15',
     '18:20',
     '18:25',
     '18:30',
     '18:35',
     '18:40',
     '18:45',
     '18:50',
     '18:55',
     '19:00',
     '19:05',
     '19:10',
     '19:15',
     '19:20',
     '19:25',
     '19:30',
     '19:35',
     '19:40',
     '19:45',
     '19:50',
     '19:55',
     '20:00',
     '20:05',
     '20:10',
     '20:15',
     '20:20',
     '20:25',
     '20:30',
     '20:35',
     '20:40',
     '20:45',
     '20:50',
     '20:55',
     '21:00',
     '21:05',
     '21:10',
     '21:15',
     '21:20',
     '21:25',
     '21:30',
     '21:35',
     '21:40',
     '21:45',
     '21:50',
     '21:55',
     '22:00',
     '22:05',
     '22:10',
     '22:15',
     '22:20',
     '22:25',
     '22:30',
     '22:35',
     '22:40',
     '22:45',
     '22:50',
     '22:55',
     '23:00',
     '23:05',
     '23:10',
     '23:15',
     '23:20',
     '23:25',
     '23:30',
     '23:35',
     '23:40',
     '23:45',
     '23:50',
     '23:55',
     '00:00',
     '00:05',
     '00:10',
     '00:15',
     '00:20',
     '00:25',
     '00:30',
     '00:35',
     '00:40',
     '00:45',
     '00:50',
     '00:55',
     '24:00'
   ];

   //???????????? ????????. ???????????? ???? ?????? Y ?? ?????????????????????? ???? ???????? ??????????????
   static List<Map> timeStepsConstant=[
     {'coof':1.33, 'time':60,'shift':102},
     {'coof':2.66, 'time':30,'shift':52},
     {'coof':5.32,'time':15,'shift':27},
     {'coof':15.962, 'time':5,'shift':12.2}];

   //???????????? ????????. ?????? ?????????????? ???????????????????????????????? ???????? ????????????
   static List<Map> timeConstantReverse=[
     {'coof':1.33, 'time':60,'shift':102},
     {'coof':2.66, 'time':30,'shift':52},
     {'coof':5.32,'time':15,'shift':27},
     {'coof':16.0 , 'time':5,'shift':12.2}];

   //???????????? ????????. ?????? ?????????????? ???????? ???????????? ?? ?????????????????????? ???? ???????? ??????????????
   static List<Map> constantForBody=[
     {'coof':1.323, 'time':60,'shift':102},
     {'coof':2.66, 'time':30,'shift':52},
     {'coof':5.33,'time':15,'shift':27},
     {'coof':16.0, 'time':5,'shift':12.2}];

//???????????? ????????. ?????????????? ?????? ?????????????????????????? ??????????????
   //todo edit configuration for all step time
   static List<Map> constantForCollision=[
     {'coof':1.328, 'coof_start':1.327,'coof_end':1.332,'time':60,'shift':102},
     {'coof':2.62222,'coof_start':2.65,'coof_end':2.662, 'time':30,'shift':52},
     {'coof':5.3,'coof_start':5.314,'coof_end':5.3267,'time':15,'shift':27},
     {'coof':16.0, 'coof_start':15.89,'coof_end':16.07,'time':5,'shift':12.2}];

   //???????????? ????????. ?????? ???????????????????? ?????????????? ?????? ???????????????????????? ??????????????
   static List<Map> constantForYPosition=[
     {'coof':1.33333, 'time':60,'shift':102},
     {'coof':2.66666, 'time':30,'shift':52},
     {'coof':5.32,'time':15,'shift':27},
     {'coof':16.0, 'time':5,'shift':12.2}];

   //???????????? ????????. ?????? ???????????????????? ?????????? ?????????????? ?????? ???????????????????????? ??????????????
   static List<Map> constantForTimeLine=[
     {'coof':1.33333, 'time':60,'shift':102},
     {'coof':2.6666, 'time':30,'shift':52},
     {'coof':5.335,'time':15,'shift':27},
     {'coof':16.0, 'time':5,'shift':12.2}];

   //???????????? ????????. ?????? ?????????? ???? ?????????????? ?????????? ?????????????? ?????? ???????????????????????? ??????????????
   static List<Map> constantForTimeTapTable=[
     {'coof':1.35, 'time':60},
     {'coof':2.67, 'time':30},
     {'coof':5.335,'time':15},
     {'coof':16.0, 'time':5}];



 }
