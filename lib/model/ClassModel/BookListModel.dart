class BookListModel {
  String status;
  List<BookListDataModel> date;

  BookListModel({this.status, this.date});

  factory BookListModel.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['date'] as List;

    List<BookListDataModel> dataList =
        list.map((i) => BookListDataModel.fromJson(i)).toList();

    return BookListModel(
      status: parsedJson['status'],
      date: dataList,
    );
  }
}

class BookListDataModel {
  String name, auther_name, edition_detail, price,conditions;

  BookListDataModel(
      {this.name, this.auther_name, this.edition_detail, this.price,this.conditions});

  factory BookListDataModel.fromJson(Map<String, dynamic> parsedJson) {
    return BookListDataModel(
      name: parsedJson['name'],
      auther_name: parsedJson['auther_name'],
      edition_detail: parsedJson['edition_detail'],
      price: parsedJson['price'],
      conditions: parsedJson['conditions'],

    );
  }
}
