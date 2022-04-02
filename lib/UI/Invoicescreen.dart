import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';



class CreatePdfWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CreatePdfStatefulWidget(title: 'Create PDF document'),
    );
  }
}

class CreatePdfStatefulWidget extends StatefulWidget {
  CreatePdfStatefulWidget({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _CreatePdfState createState() => _CreatePdfState();
}

class _CreatePdfState extends State<CreatePdfStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text(
                'Generate PDF',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              onPressed: _createPDF,
            )
          ],
        ),
      ),
    );
  }

  Future<void> _createPDF() async {
    //Create PDF document.
    PdfDocument document = PdfDocument();

    //Create a header template and draw image/text.
    final PdfPageTemplateElement headerElement =
    PdfPageTemplateElement(const Rect.fromLTWH(0, 0, 515, 50));
    headerElement.graphics.drawString(
        'This is page header', PdfStandardFont(PdfFontFamily.helvetica, 10),
        bounds: const Rect.fromLTWH(0, 0, 515, 50),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    headerElement.graphics.setTransparency(0.6);
    headerElement.graphics.drawString(
        'INVOICE', PdfStandardFont(PdfFontFamily.helvetica, 15),
        bounds: const Rect.fromLTWH(0, 0, 515, 50),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.right,
            lineAlignment: PdfVerticalAlignment.middle));
    headerElement.graphics
        .drawLine(PdfPens.gray, const Offset(0, 49), const Offset(515, 49));
    document.template.top = headerElement;

    //Create a footer template and draw a text.
    final PdfPageTemplateElement footerElement =
    PdfPageTemplateElement(const Rect.fromLTWH(0, 0, 515, 50));
    footerElement.graphics.drawString(
      'This is page footer',
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: const Rect.fromLTWH(0, 35, 515, 50),
    );
    footerElement.graphics.setTransparency(0.6);
    PdfCompositeField(text: 'Page {0} of {1}', fields: <PdfAutomaticField>[
      PdfPageNumberField(brush: PdfBrushes.black),
      PdfPageCountField(brush: PdfBrushes.black)
    ]).draw(footerElement.graphics, const Offset(450, 35));
    document.template.bottom = footerElement;

    //Invoice code here
    document = _createInvoice(document);

    //Save the document
    List<int> bytes = document.save();
    //Dispose the document
    document.dispose();

    //Get external storage directory
    Directory directory = await getExternalStorageDirectory();
    //Get directory path
    String path = directory.path;
    //Create an empty file to write PDF data
    File file = File('$path/Output.pdf');
    //Write PDF data
    await file.writeAsBytes(bytes, flush: true);
    //Open the PDF document in mobile
    OpenFile.open('$path/Output.pdf');
  }

  //Add invoice 
  PdfDocument _createInvoice(PdfDocument document) {
    //Add page and draw text.
    final PdfPage page = document.pages.add();
    //Create font
    final PdfStandardFont h1Font = PdfStandardFont(PdfFontFamily.helvetica, 15,
        style: PdfFontStyle.regular);
    final PdfStandardFont contentFont = PdfStandardFont(
        PdfFontFamily.helvetica, 12,
        style: PdfFontStyle.regular);
    //Get the page client size
    final Size size = page.getClientSize();
    //Create a text element and draw it to the page
    PdfLayoutResult result = PdfTextElement(
        text: 'Bill To',
        font: PdfStandardFont(PdfFontFamily.helvetica, 15,
            style: PdfFontStyle.bold),
        brush: PdfBrushes.red,
        format: PdfStringFormat(alignment: PdfTextAlignment.left))
        .draw(page: page, bounds: Rect.fromLTWH(0, 30, size.width, 30));

    result = PdfTextElement(text: 'Abraham Swearegin,', font: h1Font).draw(
        page: page,
        bounds: Rect.fromLTWH(0, result.bounds.bottom, size.width,
            size.height - result.bounds.bottom));

    result = PdfTextElement(
        text:
        'United States, California, San Mateo,\r\n9920 BridgePointe Parkway,\r\n9365550136',
        font: contentFont)
        .draw(
        page: result.page,
        bounds: Rect.fromLTWH(0, result.bounds.bottom, size.width,
            size.height - result.bounds.bottom));

    result = PdfTextElement(
        text: 'Invoice Number: 2058557939',
        font: h1Font,
        brush: PdfBrushes.red)
        .draw(
        page: result.page,
        bounds: Rect.fromLTWH(0, result.bounds.bottom + 15, size.width,
            size.height - result.bounds.bottom + 15),
        format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate));

    result =
        PdfTextElement(text: 'Date: Monday 04, January 2021', font: contentFont)
            .draw(
            page: result.page,
            bounds: Rect.fromLTWH(0, result.bounds.bottom, size.width,
                size.height - result.bounds.bottom),
            format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate));

    PdfGrid grid = PdfGrid();
    //Add 3 columns
    grid.columns.add(count: 5);
    //Add headers in PDF grid
    grid.headers.add(1);
    //Header row with 90/270 degree rotated text
    final PdfGridRow header1 = grid.headers[0];
    header1.cells[0].value = 'Product Id';
    header1.cells[1].value = 'Product';
    header1.cells[2].value = 'Price';
    header1.cells[3].value = 'Quantity';
    header1.cells[4].value = 'Total';
    //Add rows in PDF grid
    for (int i = 0; i < 1; i++) {
      final PdfGridRow row1 = grid.rows.add();
      row1.cells[0].value = 'CA-1098';
      row1.cells[1].value = 'AWC Logo Cap';
      row1.cells[2].value = '8.99';
      row1.cells[3].value = '2';
      row1.cells[4].value = '17.98';
      final PdfGridRow row2 = grid.rows.add();
      row2.cells[0].value = 'LJ-0192';
      row2.cells[1].value = 'Long-Sleeve Logo Jersey,M';
      row2.cells[2].value = '49.99';
      row2.cells[3].value = '3';
      row2.cells[4].value = '149.97';
      final PdfGridRow row3 = grid.rows.add();
      row3.cells[0].value = 'So-B909-M';
      row3.cells[1].value = 'Mountain Bike Socks,M';
      row3.cells[2].value = '9.5';
      row3.cells[3].value = '2';
      row3.cells[4].value = '19';
      final PdfGridRow row4 = grid.rows.add();
      row4.cells[0].value = 'LJ-0192';
      row4.cells[1].value = 'Long-Sleeve Logo Jersey,M';
      row4.cells[2].value = '49.99';
      row4.cells[3].value = '4';
      row4.cells[4].value = '199.96';
      final PdfGridRow row5 = grid.rows.add();
      row5.cells[0].value = 'FK-5136';
      row5.cells[1].value = 'ML Fork';
      row5.cells[2].value = '175.49';
      row5.cells[3].value = '6';
      row5.cells[4].value = '1052.94';
      final PdfGridRow row6 = grid.rows.add();
      row6.cells[0].value = 'HL-U509';
      row6.cells[1].value = 'Sports-100 Helmet,Black';
      row6.cells[2].value = '34.99';
      row6.cells[3].value = '1';
      row6.cells[4].value = '34.99';
      final PdfGridRow row7 = grid.rows.add();
      row1.cells[0].value = 'CA-1098';
      row1.cells[1].value = 'AWC Logo Cap';
      row1.cells[2].value = '8.99';
      row1.cells[3].value = '2';
      row1.cells[4].value = '17.98';
      final PdfGridRow row8 = grid.rows.add();
      row2.cells[0].value = 'LJ-0192';
      row2.cells[1].value = 'Long-Sleeve Logo Jersey,M';
      row2.cells[2].value = '49.99';
      row2.cells[3].value = '3';
      row2.cells[4].value = '149.97';
      final PdfGridRow row9 = grid.rows.add();
      row3.cells[0].value = 'So-B909-M';
      row3.cells[1].value = 'Mountain Bike Socks,M';
      row3.cells[2].value = '9.5';
      row3.cells[3].value = '2';
      row3.cells[4].value = '19';
      final PdfGridRow row41 = grid.rows.add();
      row4.cells[0].value = 'LJ-0192';
      row4.cells[1].value = 'Long-Sleeve Logo Jersey,M';
      row4.cells[2].value = '49.99';
      row4.cells[3].value = '4';
      row4.cells[4].value = '199.96';
      final PdfGridRow row51 = grid.rows.add();
      row5.cells[0].value = 'FK-5136';
      row5.cells[1].value = 'ML Fork';
      row5.cells[2].value = '175.49';
      row5.cells[3].value = '6';
      row5.cells[4].value = '1052.94';
      final PdfGridRow row61 = grid.rows.add();
      row6.cells[0].value = 'HL-U509';
      row6.cells[1].value = 'Sports-100 Helmet,Black';
      row6.cells[2].value = '34.99';
      row6.cells[3].value = '1';
      row6.cells[4].value = '34.99';
    }
    final PdfGridBuiltInStyleSettings settings = PdfGridBuiltInStyleSettings();
    settings.applyStyleForBandedRows = true;
    settings.applyStyleForHeaderRow = true;
    settings.applyStyleForBandedColumns = true;
    settings.applyStyleForFirstColumn = true;
    settings.applyStyleForLastColumn = true;
    settings.applyStyleForLastRow = true;
    grid.applyBuiltInStyle(PdfGridBuiltInStyle.gridTable4, settings: settings);

    PdfLayoutFormat format = PdfLayoutFormat();
    format.paginateBounds = Rect.fromLTWH(0, 0, size.width, size.height);
    //Draw grid into PDF page
    PdfLayoutResult gridResult = grid.draw(
        page: page,
        bounds: Rect.fromLTWH(0, result.bounds.bottom + 15, size.width,
            size.height - result.bounds.bottom + 15));

    final PdfTextElement element =
    PdfTextElement(text: 'Grand Total: 14740.84', font: h1Font);
    result = element.draw(
        page: gridResult.page,
        bounds: Rect.fromLTWH(0, gridResult.bounds.bottom + 15, size.width,
            size.height - gridResult.bounds.bottom + 15),
        format: PdfLayoutFormat(
            paginateBounds:
            Rect.fromLTWH(0, 15, size.width, size.height - 15)));
    return document;
  }
}
