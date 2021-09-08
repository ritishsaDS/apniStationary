class TransactionModel {
  String status;
  TransactionDataModel date;

  TransactionModel({this.date, this.status});

  factory TransactionModel.fromJson(Map<String, dynamic> parsedJson) {
    return TransactionModel(
      status: parsedJson['status'],
      date: TransactionDataModel.fromJson(parsedJson['date']),
    );
  }
}

class TransactionDataModel {
  String wallet_amount, paid_hold_amount, received_hold_amount;

  TransactionDataModel({
    this.wallet_amount,
    this.paid_hold_amount,
    this.received_hold_amount,
  });

  factory TransactionDataModel.fromJson(Map<String, dynamic> parsedJson) {
    return TransactionDataModel(
      wallet_amount: parsedJson['wallet_amount'],
      paid_hold_amount: parsedJson['paid_hold_amount'],
      received_hold_amount: parsedJson['received_hold_amount'],
    );
  }
}
