// To parse this JSON data, do
//
//     final orderedbooks = orderedbooksFromJson(jsonString);

import 'dart:convert';

Orderedbooks orderedbooksFromJson(String str) => Orderedbooks.fromJson(json.decode(str));

String orderedbooksToJson(Orderedbooks data) => json.encode(data.toJson());

class Orderedbooks {
  Orderedbooks({
    this.status,
    this.message,
    this.imageUrl,
    this.date,
  });

  String status;
  String message;
  String imageUrl;
  List<Date> date;

  factory Orderedbooks.fromJson(Map<String, dynamic> json) => Orderedbooks(
    status: json["status"],
    message: json["message"],
    imageUrl: json["image_url"],
    date: List<Date>.from(json["date"].map((x) => Date.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "image_url": imageUrl,
    "date": List<dynamic>.from(date.map((x) => x.toJson())),
  };
}

class Date {
  Date({
    this.orderId,
    this.orderStatus,
    this.productPrice,
    this.discount,
    this.payAmount,
    this.dateOrderStatus,
    this.bookName,
    this.bookImage,
    this.bookId,
    this.isBuy,
    this.price,
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.number,
    this.dob,
    this.image,
    this.gender,
    this.collegeName,
    this.walletAmount,
    this.paidHoldAmount,
    this.receivedHoldAmount,
    this.lat,
    this.longs,
    this.gst,
    this.deviceId,
    this.deviceType,
    this.status,
    this.confirmationCode,
    this.confirmed,
    this.isTermAccept,
    this.rememberToken,
    this.userFirebaseId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int orderId;
  int orderStatus;
  String productPrice;
  String discount;
  String payAmount;
  String dateOrderStatus;
  String bookName;
  String bookImage;
  int bookId;
  String isBuy;
  double price;
  int id;
  String firstName;
  String lastName;
  String email;
  String password;
  String number;
  String dob;
  String image;
  String gender;
  String collegeName;
  String walletAmount;
  String paidHoldAmount;
  String receivedHoldAmount;
  String lat;
  String longs;
  String gst;
  String deviceId;
  String deviceType;
  int status;
  dynamic confirmationCode;
  int confirmed;
  int isTermAccept;
  dynamic rememberToken;
  String userFirebaseId;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  factory Date.fromJson(Map<String, dynamic> json) => Date(
    orderId: json["order_id"],
    orderStatus: json["orderStatus"],
    productPrice: json["product_price"],
    discount: json["discount"],
    payAmount: json["pay_amount"],
    dateOrderStatus: json["order_status"],
    bookName: json["book_name"],
    bookImage: json["book_image"],
    bookId: json["book_id"],
    isBuy: json["is_buy"],
    price: json["price"].toDouble(),
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    password: json["password"],
    number: json["number"],
    dob: json["dob"],
    image: json["image"],
    gender: json["gender"],
    collegeName: json["college_name"],
    walletAmount: json["wallet_amount"],
    paidHoldAmount: json["paid_hold_amount"],
    receivedHoldAmount: json["received_hold_amount"],
    lat: json["lat"],
    longs: json["longs"],
    gst: json["gst"],
    deviceId: json["deviceID"],
    deviceType: json["deviceType"],
    status: json["status"],
    confirmationCode: json["confirmation_code"],
    confirmed: json["confirmed"],
    isTermAccept: json["is_term_accept"],
    rememberToken: json["remember_token"],
    userFirebaseId: json["user_firebase_id"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "orderStatus": orderStatus,
    "product_price": productPrice,
    "discount": discount,
    "pay_amount": payAmount,
    "order_status": dateOrderStatus,
    "book_name": bookName,
    "book_image": bookImage,
    "book_id": bookId,
    "is_buy": isBuy,
    "price": price,
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "password": password,
    "number": number,
    "dob": dob,
    "image": image,
    "gender": gender,
    "college_name": collegeName,
    "wallet_amount": walletAmount,
    "paid_hold_amount": paidHoldAmount,
    "received_hold_amount": receivedHoldAmount,
    "lat": lat,
    "longs": longs,
    "gst": gst,
    "deviceID": deviceId,
    "deviceType": deviceType,
    "status": status,
    "confirmation_code": confirmationCode,
    "confirmed": confirmed,
    "is_term_accept": isTermAccept,
    "remember_token": rememberToken,
    "user_firebase_id": userFirebaseId,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
  };
}
