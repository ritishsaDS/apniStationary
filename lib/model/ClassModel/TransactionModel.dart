class TransactionModel {
  String status;

  List<TransactionDataModel> date;

  TransactionModel({this.status, this.date});

  factory TransactionModel.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['date'] as List;

    List<TransactionDataModel> dataList =
    list.map((i) => TransactionDataModel.fromJson(i)).toList();

    return TransactionModel(
      status: parsedJson['status'],
      date: dataList,
    );
  }
}

class TransactionDataModel {
  String amount, message, type, created_at;

  TransactionDataModel(
      {this.amount, this.message, this.type, this.created_at});

  factory TransactionDataModel.fromJson(Map<String, dynamic> parsedJson) {
    return TransactionDataModel(
      amount: parsedJson['amount'],
      message: parsedJson['message'],
      type: parsedJson['type'],
      created_at: parsedJson['created_at'],

    );
  }
}
