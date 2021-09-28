class MyBooksModel {
  MyBooksModel({
    this.id,
    this.name,
    this.image,
    this.price,
    this.autherName,
    this.edition_detail,
    this.semester,
    this.condition,
    this.description,
  });

  String name = "", image = "", price = "", autherName = "", edition_detail = "", semester = "", condition = "",description = "";
  int id = 0;

  factory MyBooksModel.fromJson(Map<String, dynamic> json) =>
      MyBooksModel(
          id: json["id"],
          name: json["name"],
          image: json["image1"],
          autherName: json["auther_name"],
          edition_detail: json["edition_detail"],
          semester: json["semester"],
          condition: json["conditions"],
          description:json['description'],
          price: json["price"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "auther_name": autherName,
        "edition_detail": edition_detail,
        "semester": semester,
        "condition": condition,
        "price": price,
    "description":description
      };
}
