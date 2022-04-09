import 'package:flutter/material.dart';

void onLoading(BuildContext context, String msg) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image.asset(loader, height: 30, width: 30),
              CircularProgressIndicator(),
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(msg),
              ),
            ],
          ),
        ),
      );
    },
  );
}
