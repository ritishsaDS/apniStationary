import 'dart:convert';
import 'dart:typed_data';
import 'package:book_buy_and_sell/Utils/Dialog.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import 'Activities/mobile.dart';
import 'package:get_storage/get_storage.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:book_buy_and_sell/Constants/Colors.dart';
import 'package:book_buy_and_sell/Constants/StringConstants.dart';
import 'package:book_buy_and_sell/Utils/ApiCall.dart';
import 'package:book_buy_and_sell/Utils/SizeConfig.dart';
import 'package:book_buy_and_sell/Utils/constantString.dart';
import 'package:book_buy_and_sell/common/preference_manager.dart';
import 'package:book_buy_and_sell/model/ClassModel/BuyerOrderModel.dart';
import 'package:flutter/material.dart';

class buylist extends StatefulWidget{
  @override
  _buylistState createState() => _buylistState();
}

class _buylistState extends State<buylist> {
  bool  isLoading=false;
  final GlobalKey<State> loginLoader = new GlobalKey<State>();
var ourcomission;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return SafeArea(child: _getBuyerOrdersList());
  }
  Widget _getBuyerOrdersList() {
    return FutureBuilder<BookOrderModel>(
        future: _callBuyerAPI(),
        builder: (context, AsyncSnapshot<BookOrderModel> snapshot) {
          if (snapshot.hasData) {
            return Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.05,
                  vertical: SizeConfig.blockSizeVertical),
              child: ListView.builder(
                itemBuilder: (context, int index) {
                  return InkWell(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) {
                      //   return BookDetail("");
                      // }));
                    },
                    child: Container(
                      width: SizeConfig.screenWidth,
                      margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[200],
                                spreadRadius: 3.0,
                                blurRadius: 2.0),
                          ]),
                      child: Row(
                        children: [
                          Container(
                            width: SizeConfig.screenWidth * 0.2,
                            height: SizeConfig.screenHeight * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(snapshot.data.image_url +
                                  "/" +
                                  snapshot.data.date[index].book_image),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 4),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data.date[index].book_name,
                                  style: TextStyle(
                                      color: Color(0XFF06070D),
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 10,),
                                Text(
                                  "$rs ${snapshot.data.date[index].price}",
                                  style: TextStyle(
                                      color: Color(colorBlue),
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: SizeConfig.screenWidth * 0.15,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Status :",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Color(0XFF656565),
                                                fontSize:
                                                SizeConfig.blockSizeVertical *
                                                    1.5),
                                          ),

                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: SizeConfig.screenWidth * 0.18,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data.date[index].order_status,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Color(0XFF656565),
                                                fontSize:
                                                SizeConfig.blockSizeVertical *
                                                    1.5),
                                          ),

                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        getbookdetail(snapshot.data.date[index].order_id);

                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius
                                                .circular(10),
                                            color: (Colors.lightBlue)
                                        ),
                                        child: Text(
                                          "View Invoice",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize:
                                              SizeConfig.blockSizeVertical *
                                                  1.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                /* Container(
                              width: SizeConfig.screenWidth * 0.6,
                              alignment: Alignment.centerRight,
                              child: Text(
                                "More Info",
                                style: TextStyle(
                                    color: Color(colorBlue),
                                    fontWeight: FontWeight.w500,
                                    fontSize:
                                        SizeConfig.blockSizeVertical * 1.35),
                              ),
                            ),*/
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                shrinkWrap: true,
                itemCount: snapshot.data.date.length,
                primary: false,
              ),
            );
          } else {
            return getNotDataWidget(

            );
          }
        });
  }

  Widget getNotDataWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.info_outline,size: 100,color: Colors.blue.withOpacity(0.6),),
          SizedBox(height: 10,),
          Text("No Data Found",style: TextStyle(fontSize: 20),),
        ],
      ),
    );
  }
  Future<BookOrderModel> _callBuyerAPI() async {
    Map<String, dynamic> body = {
      "user_id": "${PreferenceManager.getUserId()}",
      "session_key": PreferenceManager.getSessionKey(),
    };

    var res = await ApiCall.post(buyerOrderListURL, body);
    var jsonResponse = json.decode(json.encode(res).toString());

    try {
      var data = new BookOrderModel.fromJson(jsonResponse);
      return data;
    } catch (e) {
      return null;
    }
  }
  dynamic bookdetail=new List();
  void getbookdetail(orderid) async {

    setState(() {
      isLoading=true;
      Dialogs.showLoadingDialog(context, loginLoader);
    });
    Map<String, dynamic> data = {
      "user_id": "${PreferenceManager.getUserId()}",
      "session_key": PreferenceManager.getSessionKey(),
      "order_id":orderid.toString()

    };


    try {
      final response = await post(

          Uri.parse(ApiCall.baseURL+"invoice"),
          body: data

      );
      print(response.statusCode.toString());

      if (response.statusCode == 256) {


        final responseJson = json.decode(response.body);

        print(responseJson);
        setState(() {
          isLoading=false;
          bookdetail=responseJson;
          ourcomission=bookdetail['bookData']['price']-double.parse(bookdetail['data']['pay_amount']);
        });
        
        Navigator.of(loginLoader.currentContext,
            rootNavigator: true) .pop();
        _createPDF(

        );

      } else {


      }
    } catch (e) {
      print(e);
      setState(() {
        Navigator.of(loginLoader.currentContext,
            rootNavigator: true) .pop();

      });
    }
  }
  Future<void> _createPDF() async{final PdfDocument document = PdfDocument();
  //Add page to the PDF
  final PdfPage page = document.pages.add();
  final PdfPage page2 = document.pages.add();
  //Get page client size
  final Size pageSize = page.getClientSize();
  //Draw rectangle
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
      pen: PdfPen(PdfColor(142, 170, 219, 255)));
  page2.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
      pen: PdfPen(PdfColor(142, 170, 219, 255)));
  //Generate PDF grid.
  final PdfGrid grid = getGrid();
  final PdfGrid grid2 = getGrid2();
  //Draw the header section by creating text element
  final PdfLayoutResult result = drawHeader(page, pageSize, grid);
  final PdfLayoutResult result2 = drawHeader2(page2, pageSize, grid2);

  //Draw grid
  drawGrid(page, grid, result);
  drawGrid2(page2, grid2, result2);
  //Add invoice footer
  drawFooter(page, pageSize);
  drawLine(page2, pageSize);
  // drawsLine(page2, pageSize);
  // drawlogoline(page2, pageSize);
  // drawdownLine(page2, pageSize);
  //Save the PDF document
  final List<int> bytes = document.save();
  //Dispose the document.
  document.dispose();
  //Save and launch the file.
  await saveAndLaunchFile(bytes, 'Invoice.pdf');
  }

  //Draws the invoice header
  PdfLayoutResult drawHeader(PdfPage page, Size pageSize, PdfGrid grid) {
    //Draw rectangle
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(91, 126, 215, 255)),
        bounds: Rect.fromLTWH(0, 0, pageSize.width , 100));
    //Draw string
    page.graphics.drawString(
        'Pillers Of Everest Technology', PdfStandardFont(PdfFontFamily.helvetica, 20),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(25, 0, pageSize.width , 100),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawString(
        'Apni Stationary', PdfStandardFont(PdfFontFamily.helvetica, 20),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(22, 30, pageSize.width , 100),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

    // page.graphics.drawImage(
    //     PdfBitmap( await _readImageData('icons/applogo.png')),
    // Rect.fromLTWH(0, 100, 440, 550));
    page.graphics.drawString("Rs." + bookdetail['bookData']['price'].toString(),
        PdfStandardFont(PdfFontFamily.helvetica, 18),
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 100),
        brush: PdfBrushes.white,
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawString("Rs." + bookdetail['bookData']['price'].toString(),
        PdfStandardFont(PdfFontFamily.helvetica, 18),
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 100),
        brush: PdfBrushes.white,
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.middle));

    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
    //Draw string
    page.graphics.drawString('Amount', contentFont,
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.bottom));
    //Create data foramt and convert it to text.
    final DateFormat format = DateFormat.yMMMMd('en_US');
    final String invoiceNumber = 'Invoice Number: ${bookdetail['data']['id']}\r\n\r\nDate: ' +
        "${bookdetail['data']['created_at']}\r\n\r\n${bookdetail['data']['address']}\r\n\r\n${PreferenceManager.getName()}";
    final Size contentSize = contentFont.measureString(invoiceNumber);
    // ignore: leading_newlines_in_multiline_strings
    String address = '''Bill To: \r\n\r\n${PreferenceManager.getName()}, 
        \r\n${PreferenceManager.getcollge().toString()}, 
        \r\n${bookdetail['data']['address']}, 
        \r\n${"GST Registration No: 27AAQCS4259Q1ZA"}, 
       ''';

    PdfTextElement(text: invoiceNumber, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30), 120,
            contentSize.width + 30, pageSize.height - 120));

    return PdfTextElement(text: address, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(30, 120,
            pageSize.width - (contentSize.width + 30), pageSize.height - 120));
  }
  PdfLayoutResult drawHeader2(PdfPage page, Size pageSize, PdfGrid grid) {
    //Draw rectangle
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(91, 126, 215, 255)),
        bounds: Rect.fromLTWH(0, 0, pageSize.width, 90));
    //Draw string
    page.graphics.drawString(
        'Pillers Of Everest Technology', PdfStandardFont(PdfFontFamily.helvetica, 20),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(150, 0, pageSize.width , 90),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));




    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
    //Draw string

    //Create data foramt and convert it to text.
    final DateFormat format = DateFormat.yMMMMd('en_US');
    final String invoiceNumber = 'Invoice Number: ${bookdetail['data']['id']}\r\n\r\nSAC Code :48484484 ' +
        "${bookdetail['data']['created_at']}\r\n\r\nSTATE GSTIN :848494044\r\n\r\n${PreferenceManager.getName()}";
    final Size contentSize = contentFont.measureString(invoiceNumber);
    // ignore: leading_newlines_in_multiline_strings
    String address = '''Apni Stationary \r\n\r\n800 Interchange Blvd.\r\n\r\nUttrakhand , Haldwani, 
       
        \r\n${"GST Registration No: 27AAQCS4259Q1ZA"}, 
       ''';

    PdfTextElement(text: invoiceNumber, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30), 120,
            contentSize.width + 30, pageSize.height - 120));

    return PdfTextElement(text: address, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(30, 120,
            pageSize.width - (contentSize.width + 30), pageSize.height - 120));
  }

  //Draws the grid
  void drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
    Rect totalPriceCellBounds;
    Rect quantityCellBounds;
    //Invoke the beginCellLayout event.
    grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
      final PdfGrid grid = sender as PdfGrid;
      if (args.cellIndex == grid.columns.count - 1) {
        totalPriceCellBounds = args.bounds;
      } else if (args.cellIndex == grid.columns.count - 2) {
        quantityCellBounds = args.bounds;
      }
    };
    //Draw the PDF grid and get the result.
    result = grid.draw(
        page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0));

    //Draw grand total.
    // page.graphics.drawString('Total Taxes',
    //     PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
    //     bounds: Rect.fromLTWH(
    //         quantityCellBounds.right,
    //         result.bounds.bottom + 60,
    //         quantityCellBounds.width-400,
    //         quantityCellBounds.height));
    // page.graphics.drawString('                                     ',
    //     PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
    //     bounds: Rect.fromLTWH(
    //         quantityCellBounds.right,
    //         result.bounds.bottom + 60,
    //         quantityCellBounds.width-400,
    //         quantityCellBounds.height));
    //
    // page.graphics.drawString('Grand Total',
    //     PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
    //     bounds: Rect.fromLTWH(
    //         quantityCellBounds.left,
    //         result.bounds.bottom + 140,
    //         quantityCellBounds.left,
    //         quantityCellBounds.height));
    // page.graphics.drawString(bookdetail['bookData']['price'].toString(),
    //     PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
    //     bounds: Rect.fromLTWH(
    //         totalPriceCellBounds.left,
    //         result.bounds.bottom + 140,
    //         totalPriceCellBounds.width,
    //         totalPriceCellBounds.height));
    // page.graphics.drawString('Original Price',
    //     PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
    //     bounds: Rect.fromLTWH(
    //         quantityCellBounds.left,
    //         result.bounds.bottom + 10,
    //         quantityCellBounds.width,
    //         quantityCellBounds.height));
    // page.graphics.drawString(bookdetail['data']['pay_amount'].toString(),
    //     PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
    //     bounds: Rect.fromLTWH(
    //         totalPriceCellBounds.left,
    //         result.bounds.bottom + 10,
    //         totalPriceCellBounds.width,
    //         totalPriceCellBounds.height));
    //
    // page.graphics.drawString('Service Charge',
    //     PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
    //     bounds: Rect.fromLTWH(
    //         quantityCellBounds.left,
    //         result.bounds.bottom + 30,
    //         quantityCellBounds.width,
    //         quantityCellBounds.height));
    // page.graphics.drawString(((ourcomission)).toString(),
    //     PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
    //     bounds: Rect.fromLTWH(
    //         totalPriceCellBounds.left,
    //         result.bounds.bottom + 30,
    //         totalPriceCellBounds.width,
    //         totalPriceCellBounds.height));
    // page.graphics.drawString('CGST(9.0%)',
    //     PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
    //     bounds: Rect.fromLTWH(
    //         quantityCellBounds.left,
    //         result.bounds.bottom + 80,
    //         quantityCellBounds.width,
    //         quantityCellBounds.height));
    // page.graphics.drawString(((ourcomission)).toString(),
    //     PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
    //     bounds: Rect.fromLTWH(
    //         totalPriceCellBounds.left,
    //         result.bounds.bottom + 80,
    //         totalPriceCellBounds.width,
    //         totalPriceCellBounds.height));
    // page.graphics.drawString('SGST(9.0%)',
    //     PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
    //     bounds: Rect.fromLTWH(
    //         quantityCellBounds.left,
    //         result.bounds.bottom + 100,
    //         quantityCellBounds.width,
    //         quantityCellBounds.height));
    // page.graphics.drawString(((ourcomission)).toString(),
    //     PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
    //     bounds: Rect.fromLTWH(
    //         totalPriceCellBounds.left,
    //         result.bounds.bottom + 100,
    //         totalPriceCellBounds.width,
    //         totalPriceCellBounds.height));
    // page.graphics.drawString('Asset Fee',
    //     PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
    //     bounds: Rect.fromLTWH(
    //         quantityCellBounds.left,
    //         result.bounds.bottom + 120,
    //         quantityCellBounds.width,
    //         quantityCellBounds.height));
    // page.graphics.drawString(((ourcomission)).toString(),
    //     PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
    //     bounds: Rect.fromLTWH(
    //         totalPriceCellBounds.left,
    //         result.bounds.bottom + 120,
    //         totalPriceCellBounds.width,
    //         totalPriceCellBounds.height));

  }
  void drawGrid2(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
    Rect totalPriceCellBounds;
    Rect quantityCellBounds;
    //Invoke the beginCellLayout event.
    grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
      final PdfGrid grid = sender as PdfGrid;
      if (args.cellIndex == grid.columns.count - 1) {
        totalPriceCellBounds = args.bounds;
      } else if (args.cellIndex == grid.columns.count - 2) {
        quantityCellBounds = args.bounds;
      }
    };
    //Draw the PDF grid and get the result.
    result = grid.draw(
        page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0));

    //Draw grand total.
    // page.graphics.drawString('         Access Fee',
    //     PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
    //     bounds: Rect.fromLTWH(
    //         quantityCellBounds.left,
    //         result.bounds.bottom + 60,
    //         quantityCellBounds.width,
    //         quantityCellBounds.height));
    // page.graphics.drawString('                                     ',
    //     PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
    //     bounds: Rect.fromLTWH(
    //         quantityCellBounds.right,
    //         result.bounds.bottom + 60,
    //         quantityCellBounds.width,
    //         quantityCellBounds.height));
    //
    // page.graphics.drawString('         Grand Total',
    //     PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
    //     bounds: Rect.fromLTWH(
    //         quantityCellBounds.left,
    //         result.bounds.bottom + 140,
    //         quantityCellBounds.left,
    //         quantityCellBounds.height));
    // page.graphics.drawString(bookdetail['bookData']['price'].toString(),
    //     PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
    //     bounds: Rect.fromLTWH(
    //         totalPriceCellBounds.left,
    //         result.bounds.bottom + 140,
    //         totalPriceCellBounds.width,
    //         totalPriceCellBounds.height));
    // page.graphics.drawString('         Access Fee',
    //     PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
    //     bounds: Rect.fromLTWH(
    //         quantityCellBounds.left,
    //         result.bounds.bottom + 10,
    //         quantityCellBounds.width,
    //         quantityCellBounds.height));
    // page.graphics.drawString(bookdetail['data']['pay_amount'].toString(),
    //     PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
    //     bounds: Rect.fromLTWH(
    //         totalPriceCellBounds.left,
    //         result.bounds.bottom + 10,
    //         totalPriceCellBounds.width,
    //         totalPriceCellBounds.height));
    //
    // page.graphics.drawString('         Discount',
    //     PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
    //     bounds: Rect.fromLTWH(
    //         quantityCellBounds.left,
    //         result.bounds.bottom + 30,
    //         quantityCellBounds.width,
    //         quantityCellBounds.height));
    // page.graphics.drawString(((ourcomission)).toString(),
    //     PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
    //     bounds: Rect.fromLTWH(
    //         totalPriceCellBounds.left,
    //         result.bounds.bottom + 30,
    //         totalPriceCellBounds.width,
    //         totalPriceCellBounds.height));
    // page.graphics.drawString('         CGST(9.0%)',
    //     PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
    //     bounds: Rect.fromLTWH(
    //         quantityCellBounds.left,
    //         result.bounds.bottom + 80,
    //         quantityCellBounds.width,
    //         quantityCellBounds.height));
    // page.graphics.drawString(((ourcomission)).toString(),
    //     PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
    //     bounds: Rect.fromLTWH(
    //         totalPriceCellBounds.left,
    //         result.bounds.bottom + 80,
    //         totalPriceCellBounds.width,
    //         totalPriceCellBounds.height));
    // page.graphics.drawString('         SGST(9.0%)',
    //     PdfStandardFont(PdfFontFamily.helvetica, 19, style: PdfFontStyle.bold),
    //     bounds: Rect.fromLTWH(
    //         quantityCellBounds.left,
    //         result.bounds.bottom + 100,
    //         quantityCellBounds.width,
    //         quantityCellBounds.height));
    // page.graphics.drawString(((ourcomission)).toString(),
    //     PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
    //     bounds: Rect.fromLTWH(
    //         totalPriceCellBounds.left,
    //         result.bounds.bottom + 100,
    //         totalPriceCellBounds.width,
    //         totalPriceCellBounds.height));
    // page.graphics.drawString('         Asset Fee',
    //     PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
    //     bounds: Rect.fromLTWH(
    //         quantityCellBounds.left,
    //         result.bounds.bottom + 120,
    //         quantityCellBounds.width,
    //         quantityCellBounds.height));
    // page.graphics.drawString(((ourcomission)).toString(),
    //     PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
    //     bounds: Rect.fromLTWH(
    //         totalPriceCellBounds.left,
    //         result.bounds.bottom + 120,
    //         totalPriceCellBounds.width,
    //         totalPriceCellBounds.height));

  }

  //Draw the invoice footer data.
  void drawFooter(PdfPage page, Size pageSize) {
    final PdfPen linePen =
    PdfPen(PdfColor(142, 170, 219, 255), dashStyle: PdfDashStyle.custom);
    linePen.dashPattern = <double>[3, 3];
    //Draw line
    page.graphics.drawLine(linePen, Offset(0, pageSize.height - 100),
        Offset(pageSize.width, pageSize.height - 100));

    const String footerContent =
    // ignore: leading_newlines_in_multiline_strings
    '''800 Interchange Blvd.\r\n\r\nUttrakhand , Haldwani,
         TX 78721\r\n\r\nAny Questions? support@apnistationary.com''';

    //Added 30 as a margin for the layout
    page.graphics.drawString(
        footerContent, PdfStandardFont(PdfFontFamily.helvetica, 9),
        format: PdfStringFormat(alignment: PdfTextAlignment.right),
        bounds: Rect.fromLTWH(pageSize.width - 30, pageSize.height - 70, 0, 0));
  }
  void drawLine(PdfPage page, Size pageSize) {
    final PdfPen linePen =
    PdfPen(PdfColor(142, 170, 219, 255), dashStyle: PdfDashStyle.custom);
    linePen.dashPattern = <double>[3, 3];
    //Draw line
    page.graphics.drawLine(linePen, Offset(0, pageSize.height - 370),
        Offset(pageSize.width, pageSize.height - 370));

    // const String footerContent =
    // // ignore: leading_newlines_in_multiline_strings
    // '''800 Interchange Blvd.\r\n\r\nUttrakhand , Haldwani,
    //      TX 78721\r\n\r\nAny Questions? support@apnistationary.com''';
    //
    // //Added 30 as a margin for the layout
    // page.graphics.drawString(
    //     footerContent, PdfStandardFont(PdfFontFamily.helvetica, 9),
    //     format: PdfStringFormat(alignment: PdfTextAlignment.right),
    //     bounds: Rect.fromLTWH(pageSize.width - 30, pageSize.height - 70, 0, 0));
  }
  void drawsLine(PdfPage page, Size pageSize) {
    final PdfPen linePen =
    PdfPen(PdfColor(142, 170, 219, 255), dashStyle: PdfDashStyle.custom);
    linePen.dashPattern = <double>[3, 3];
    //Draw line
    page.graphics.drawLine(linePen, Offset(0, pageSize.height - 360),
        Offset(pageSize.width, pageSize.height - 360));

    // const String footerContent =
    // // ignore: leading_newlines_in_multiline_strings
    // '''800 Interchange Blvd.\r\n\r\nUttrakhand , Haldwani,
    //      TX 78721\r\n\r\nAny Questions? support@apnistationary.com''';
    //
    // //Added 30 as a margin for the layout
    // page.graphics.drawString(
    //     footerContent, PdfStandardFont(PdfFontFamily.helvetica, 9),
    //     format: PdfStringFormat(alignment: PdfTextAlignment.right),
    //     bounds: Rect.fromLTWH(pageSize.width - 30, pageSize.height - 70, 0, 0));
  }
  void drawlogoline(PdfPage page2, Size pageSize) {
    final PdfPen linePen =
    PdfPen(PdfColor(255,250,250, 255), dashStyle: PdfDashStyle.custom);
    linePen.dashPattern = <double>[3, 3];
    //Draw line
    page2.graphics.drawLine(linePen, Offset(0, pageSize.height - 100),
        Offset(pageSize.width, pageSize.height - 100));

    // const String footerContent =
    // // ignore: leading_newlines_in_multiline_strings
    // '''800 Interchange Blvd.\r\n\r\nUttrakhand , Haldwani,
    //      TX 78721\r\n\r\nAny Questions? support@apnistationary.com''';
    //
    // //Added 30 as a margin for the layout
    // page.graphics.drawString(
    //     footerContent, PdfStandardFont(PdfFontFamily.helvetica, 9),
    //     format: PdfStringFormat(alignment: PdfTextAlignment.right),
    //     bounds: Rect.fromLTWH(pageSize.width - 30, pageSize.height - 70, 0, 0));
  }
  void drawdownLine(PdfPage page, Size pageSize) {
    final PdfPen linePen =
    PdfPen(PdfColor(142, 170, 219, 255), dashStyle: PdfDashStyle.custom);
    linePen.dashPattern = <double>[3, 3];
    //Draw line
    page.graphics.drawLine(linePen, Offset(0, pageSize.height - 330),
        Offset(pageSize.width, pageSize.height - 330));

    // const String footerContent =
    // // ignore: leading_newlines_in_multiline_strings
    // '''800 Interchange Blvd.\r\n\r\nUttrakhand , Haldwani,
    //      TX 78721\r\n\r\nAny Questions? support@apnistationary.com''';
    //
    // //Added 30 as a margin for the layout
    // page.graphics.drawString(
    //     footerContent, PdfStandardFont(PdfFontFamily.helvetica, 9),
    //     format: PdfStringFormat(alignment: PdfTextAlignment.right),
    //     bounds: Rect.fromLTWH(pageSize.width - 30, pageSize.height - 70, 0, 0));
  }

  //Create PDF grid and return
  PdfGrid getGrid() {
    //Create a PDF grid
    final PdfGrid grid = PdfGrid();
    //Secify the columns count to the grid.
    grid.columns.add(count: 5);
    //Create the header row of the grid.
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    //Set style
    headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
    headerRow.style.textBrush = PdfBrushes.white;
    headerRow.cells[0].value = 'Product Id';
    headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[1].value = 'Product Name';
    headerRow.cells[2].value = 'Price';
    headerRow.cells[3].value = 'Quantity';
    headerRow.cells[4].value = 'Total';
    //Add rows
    for(int i=0; i<1;i++){
      addProducts(bookdetail['data']['book_id'].toString(), bookdetail['bookData']['name'].toString(),double.parse(bookdetail['data']['pay_amount']), 1,double.parse(bookdetail['data']['pay_amount']), grid);
    }
    // addProducts('CA-1098', 'AWC Logo Cap', 8.99, 2, 17.98, grid);
    // addProducts('LJ-0192', 'Long-Sleeve Logo Jersey,M', 49.99, 3, 149.97, grid);
    // addProducts('So-B909-M', 'Mountain Bike Socks,M', 9.5, 2, 19, grid);
    // addProducts('LJ-0192', 'Long-Sleeve Logo Jersey,M', 49.99, 4, 199.96, grid);
    // addProducts('FK-5136', 'ML Fork', 175.49, 6, 1052.94, grid);
    // addProducts('HL-U509', 'Sports-100 Helmet,Black', 34.99, 1, 34.99, grid);
    //Apply the table built-in style
    grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
    //Set gird columns width
    grid.columns[1].width = 200;
    for (int i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        if (j == 0) {
          cell.stringFormat.alignment = PdfTextAlignment.center;
        }
        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      }
    }
    return grid;
  }
  PdfGrid getGrid2() {
    //Create a PDF grid
    final PdfGrid grid = PdfGrid();
    //Secify the columns count to the grid.
    grid.columns.add(count: 2);
    //Create the header row of the grid.
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    //Set style
    headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
    headerRow.style.textBrush = PdfBrushes.white;
    headerRow.cells[0].value = 'Taxes';
    headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[1].value = 'Price (in Rs.)';

    //Add rows
    for(int i=0; i<5;i++){
      if(i==0){
        addtax("Access Fee","2.04", grid);
      }
      else if(i==1){
        addtax("Discount",bookdetail['data']['discount'].toString(), grid);
      }
       else if(i==2){
        addtax("CGST",bookdetail['data']['cgst_val'].toString(), grid);
      }
      else if(i==3){
        addtax("SGST",bookdetail['data']['sgst_val'].toString(), grid);


      }
      else if(i==4){
        addtax("Total",bookdetail['data']['price_with_gst'].toString(), grid);


      }

    }
    // addProducts('CA-1098', 'AWC Logo Cap', 8.99, 2, 17.98, grid);
    // addProducts('LJ-0192', 'Long-Sleeve Logo Jersey,M', 49.99, 3, 149.97, grid);
    // addProducts('So-B909-M', 'Mountain Bike Socks,M', 9.5, 2, 19, grid);
    // addProducts('LJ-0192', 'Long-Sleeve Logo Jersey,M', 49.99, 4, 199.96, grid);
    // addProducts('FK-5136', 'ML Fork', 175.49, 6, 1052.94, grid);
    // addProducts('HL-U509', 'Sports-100 Helmet,Black', 34.99, 1, 34.99, grid);
    //Apply the table built-in style
    grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
    //Set gird columns width
    grid.columns[1].width = 200;
    for (int i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        if (j == 0) {
          cell.stringFormat.alignment = PdfTextAlignment.center;
        }
        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      }
    }
    return grid;
  }

  //Create and row for the grid.


  void addProducts(String productId, String productName, double price,
      int quantity, double total, PdfGrid grid) {
    final PdfGridRow row = grid.rows.add();
    for(int i=0;i<4;i++){


      row.cells[0].value = productId;
      row.cells[1].value = productName;
      row.cells[2].value ="${price}";
      row.cells[3].value = "1";
      row.cells[4].value = "${total}";
    }}
  void addtax(String productId, String productName , PdfGrid grid) {
    final PdfGridRow row = grid.rows.add();
    for(int i=0;i<4;i++){


      row.cells[0].value = productId;
      row.cells[1].value = productName;

    }}



  //Get the total amount.
  double getTotalAmount(PdfGrid grid) {
    double total = 0;
    for (int i = 0; i < grid.rows.count; i++) {
      final String value =
      grid.rows[i].cells[grid.columns.count - 1].value as String;
      total += double.parse(value);
    }
    return total;
  }
  Future<Uint8List> _readImageData(String name) async {
    final data = await rootBundle.load('images/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }
}