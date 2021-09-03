class SliderModel {
  String status;
  List<SliderDataModel> SliderData;

  SliderModel({this.status, this.SliderData});

  factory SliderModel.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['SliderData'] as List;
    List<SliderDataModel> dataList =
        list.map((i) => SliderDataModel.fromJson(i)).toList();

    return SliderModel(
      status: parsedJson['status'],
      SliderData: dataList,
    );
  }
}

class SliderDataModel {
  String image;

  SliderDataModel({this.image});

  factory SliderDataModel.fromJson(Map<String, dynamic> parsedJson) {
    return SliderDataModel(
      image: parsedJson['image'],
    );
  }
}
