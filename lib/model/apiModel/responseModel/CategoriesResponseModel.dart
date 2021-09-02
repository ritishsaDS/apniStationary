class CategoriesModel {
  CategoriesModel({
    this.id,
    this.name,
    this.image,
    this.subcategory,
  });

  String id = "", name = "", image = "", subcategory = "";

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
