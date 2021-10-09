


 class ResponseUploadAvatarApi{

   bool result;
   String url;

   ResponseUploadAvatarApi.fromApi(Map<String,dynamic> map):
       result=map['result'],
        url=map['avatar'];
}