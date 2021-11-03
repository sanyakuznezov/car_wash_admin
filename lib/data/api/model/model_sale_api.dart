





  class ModelSaleApi{

    int id;
    String name;
    String description;
   bool onlySubscribers;
    String forServiceTypeText;
    String saleText;
    String startAt;
    String endAt;
    String itemsText;


    ModelSaleApi.fromApi({required Map<String,dynamic> data}):
        id=data['id'],
    name=data['name'],
          description=data['description'],
          onlySubscribers=data['onlySubscribers'],
          forServiceTypeText=data['forServiceTypeText'],
          saleText=data['saleText'],
          startAt=data['startAt'],
          endAt=data['endAt'],
          itemsText=data['itemsText'];
  }