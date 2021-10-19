

 import 'package:car_wash_admin/data/api/model/model_worker_api.dart';
import 'package:car_wash_admin/domain/model/model_worker.dart';

class MapperDataWorker{

  static ModelWorker fromApi(ModelWorkerApi modelWorkerApi){
    return ModelWorker(id: modelWorkerApi.id, firstname: modelWorkerApi.firstname, lastname: modelWorkerApi.lastname,
        patronymic: modelWorkerApi.patronymic, avatar: modelWorkerApi.avatar, phone: modelWorkerApi.phone,
        email: modelWorkerApi.email, post: modelWorkerApi.post);

  }


 }