class CartListModel {
  String status, image_url;

  List<CartListDataModel> date;

  CartListModel({this.status, this.image_url, this.date});

  factory CartListModel.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['date'] as List;

    List<CartListDataModel> dataList =
        list.map((i) => CartListDataModel.fromJson(i)).toList();

    return CartListModel(
      status: parsedJson['status'],
      image_url: parsedJson['image_url'],
      date: dataList,
    );
  }
}

class CartListDataModel {
  String name,
      auther_name,
      edition_detail,
      price,
      conditions,
      image1,
      created_at,
      orderId;
  var category_id, id;

  CartListDataModel(
      {this.name,
      this.auther_name,
      this.edition_detail,
      this.price,
      this.conditions,
      this.category_id,
      this.id,
      this.orderId,
      this.image1,
      this.created_at});

  factory CartListDataModel.fromJson(Map<String, dynamic> parsedJson) {
    return CartListDataModel(
      name: parsedJson['name'],
      auther_name: parsedJson['auther_name'],
      edition_detail: parsedJson['edition_detail'],
      price: parsedJson['price'],
      conditions: parsedJson['conditions'],
      category_id: parsedJson['category_id'],
      id: parsedJson['id'],
      orderId: parsedJson['order_id'],
      image1: parsedJson['image1'],
      created_at: parsedJson['created_at'],
    );
  }
}
