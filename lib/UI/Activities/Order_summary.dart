import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Ordersummary extends StatefulWidget{
  @override
  _OrdersummaryState createState() => _OrdersummaryState();
}

class _OrdersummaryState extends State<Ordersummary> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text("Your Order Summary ")),
      contentPadding: EdgeInsets.all(0),

      content: Container(
        height: 300,
        margin: EdgeInsets.only(top:20),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width*0.15,),
                Container(
                    width: 120,
                    child: Text("Book Name: ")),
                Text("Book Name"),
              ],
            ),
            SizedBox(height: 10,),
            Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width*0.15,),
                Container(
                  width: 120,
                  child:Text("Author Name : "),),
                Text("Book Name"),
              ],
            ),
            SizedBox(height: 10,),
            Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width*0.15,),
                Container(
                  width: 120,
                  child:Text("Category : "),),
                Text("Book Name"),
              ],
            ),
            SizedBox(height: 10,),
            Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width*0.15,),
                Container(
                  width: 120,
                  child: Text("College : "),),
                Text("Book Name"),
              ],
            ),
            SizedBox(height: 10,),
            Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width*0.15,),
                Container(
                  width: 120,
                  child: Text("Price : "),),
                Text("Book Name"),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 5,),

                RaisedButton(onPressed: (){},color: Colors.lightBlue,child: Text("Confirm Order",style: TextStyle(color: Colors.white),),),
                SizedBox(width: 10,),

                RaisedButton(onPressed: (){},child: Text("Cancel Order"),),

              ],
            )
          ],),),

    );

  }
}