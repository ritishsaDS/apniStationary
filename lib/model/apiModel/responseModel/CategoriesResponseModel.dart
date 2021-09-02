class CategoriesModel {
  CategoriesModel({
    this.id,
    this.name,
    this.image,
    this.subcategory,
  });

  String name = "", image = "", subcategory = "";
  int id = 0;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
          id: json["id"],
          name: json["name"],
          image: json["image"],
          subcategory: json["subcategory"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "subcategory": subcategory,
      };
}
