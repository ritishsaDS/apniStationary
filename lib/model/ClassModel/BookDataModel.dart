
class BookDataModel {
 String image_url;
 BookDataDetailsModel date;

  BookDataModel(
      {this.date,this.image_url});

  factory BookDataModel.fromJson(Map<String, dynamic> parsedJson) {
    return BookDataModel(
      image_url: parsedJson['image_url'],
      date: BookDataDetailsModel.fromJson(parsedJson['date']),
    );
  }
}

class BookDataDetailsModel {
  String name, auther_name, edition_detail, price, conditions, description,semester,image1,image2,image3,image4;
  var category_id;

  BookDataDetailsModel(
      {this.name,
      this.auther_name,
      this.edition_detail,
      this.price,
      this.conditions,
      this.category_id,
      this.description,this.semester,this.image1,this.image2,this.image3,this.image4});

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
      image1: parsedJson['image1'],
      image2: parsedJson['image2'],
      image3: parsedJson['image3'],
      image4: parsedJson['image4'],
    );
  }

  @override
  String toString() {
    return 'BookDataDetailsModel{name: $name, auther_name: $auther_name, edition_detail: $edition_detail, price: $price, conditions: $conditions, description: $description, semester: $semester, image1: $image1, image2: $image2, image3: $image3, image4: $image4, category_id: $category_id}';
  }
}
