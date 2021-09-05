
class BookDataModel {
 BookDataDetailsModel date;

  BookDataModel(
      {this.date});

  factory BookDataModel.fromJson(Map<String, dynamic> parsedJson) {
    return BookDataModel(
      date: BookDataDetailsModel.fromJson(parsedJson['date']),

    );
  }
}

class BookDataDetailsModel {
  String name, auther_name, edition_detail, price, conditions, description,semester;
  var category_id;

  BookDataDetailsModel(
      {this.name,
      this.auther_name,
      this.edition_detail,
      this.price,
      this.conditions,
      this.category_id,
      this.description,this.semester});

  factory BookDataDetailsModel.fromJson(Map<String, dynamic> parsedJson) {
    return BookDataDetailsModel(
      name: parsedJson['name'],
      auther_name: parsedJson['auther_name'],
      edition_detail: parsedJson['edition_detail'],
      price: parsedJson['price'],
      conditions: parsedJson['conditions'],
      category_id: parsedJson['category_id'],
      description: parsedJson['description'],
      semester: parsedJson['semester'],
    );
  }
}
