class BookOrderModel {
  String status, image_url;

  List<BookOrderDataModel> date;

  BookOrderModel({this.status,this.image_url, this.date});

  factory BookOrderModel.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['date'] as List;

    List<BookOrderDataModel> dataList =
    list.map((i) => BookOrderDataModel.fromJson(i)).toList();

    return BookOrderModel(
      status: parsedJson['status'],
      image_url: parsedJson['image_url'],
      date: dataList,
    );
  }
}

class BookOrderDataModel {
  String product_price, discount, pay_amount, order_status,book_name,book_image;
  var order_id;

  BookOrderDataModel(
      {this.product_price, this.discount, this.pay_amount, this.order_status,this.book_name,this.book_image,this.order_id});

  factory BookOrderDataModel.fromJson(Map<String, dynamic> parsedJson) {
    return BookOrderDataModel(
      product_price: parsedJson['product_price'],
      discount: parsedJson['discount'],
      pay_amount: parsedJson['pay_amount'],
      order_status: parsedJson['order_status'],
      book_name: parsedJson['book_name'],
      book_image: parsedJson['book_image'],
      order_id: parsedJson['order_id'],
    );
  }
}
