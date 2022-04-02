class BookListModel {
  String status, image_url;

  List<BookListDataModel> date;

  BookListModel({this.status,this.image_url, this.date});

  factory BookListModel.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['date'] as List;

    List<BookListDataModel> dataList =
        list.map((i) => BookListDataModel.fromJson(i)).toList();

    return BookListModel(
      status: parsedJson['status'],
      image_url: parsedJson['image_url'],
      date: dataList,
    );
  }
}

class BookListDataModel {
  String name, auther_name,college_name, edition_detail, price,conditions,image1;
  var category_id,id;

  BookListDataModel(
      {this.name,this.college_name, this.auther_name, this.edition_detail, this.price,this.conditions,this.category_id,this.id,this.image1});

  factory BookListDataModel.fromJson(Map<String, dynamic> parsedJson) {
    return BookListDataModel(
      name: parsedJson['name'],
      auther_name: parsedJson['auther_name'],
      edition_detail: parsedJson['edition_detail'],
      price: parsedJson['price'].toString(),
      conditions: parsedJson['conditions'],
      category_id: parsedJson['category_id'],
      id: parsedJson['id'],
      college_name: parsedJson['college_name'],
      image1: parsedJson['image1'],
    );
  }
}
