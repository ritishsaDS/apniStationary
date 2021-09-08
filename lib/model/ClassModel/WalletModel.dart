class WalletModel {
  String status;
  WalletDataModel date;

  WalletModel({this.date, this.status});

  factory WalletModel.fromJson(Map<String, dynamic> parsedJson) {
    return WalletModel(
      status: parsedJson['status'],
      date: WalletDataModel.fromJson(parsedJson['date']),
    );
  }
}

class WalletDataModel {
  String wallet_amount, paid_hold_amount, received_hold_amount;

  WalletDataModel({
    this.wallet_amount,
    this.paid_hold_amount,
    this.received_hold_amount,
  });

  factory WalletDataModel.fromJson(Map<String, dynamic> parsedJson) {
    return WalletDataModel(
      wallet_amount: parsedJson['wallet_amount'],
      paid_hold_amount: parsedJson['paid_hold_amount'],
      received_hold_amount: parsedJson['received_hold_amount'],
    );
  }
}
