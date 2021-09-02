import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommonLV extends StatelessWidget {
  Future<Widget> dataCallingMethod;

  CommonLV({this.dataCallingMethod});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
        future: dataCallingMethod,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.connectionState == ConnectionState.active) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                return snapshot.data;
              } else {
                return Text("No Data found");
              }
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text("Something went Wrong");
            } else {
              return Text("Something went Wrong");
            }
          } else {
            return Text("No Data found");
          }
        });
  }
}
