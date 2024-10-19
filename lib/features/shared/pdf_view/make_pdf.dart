import 'dart:io';
import 'package:flutter/services.dart';
import 'package:nilelon/core/constants/assets.dart';
import 'package:nilelon/features/shared/pdf_view/build_table_row.dart';
import 'package:nilelon/features/shared/pdf_view/build_table_row_header.dart';
import 'package:nilelon/features/shared/pdf_view/headers_list.dart';
import 'package:nilelon/features/shared/pdf_view/pdf_footer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<void> generateOrderPdf({
  required List<List<String>> cells,
  required String netTotal,
  required String discount,
  required String delivery,
  required String total,
  required String name,
  required String location,
  required String orderId,
  required String orderDate,
  required String phoneNumber,
}) async {
  const int maxRowsPerPage = 18;

  final pdf = pw.Document();
  final image = pw.MemoryImage(
    (await rootBundle.load(Assets.assetsImagesLog)).buffer.asUint8List(),
  );

  final googlePlay = pw.MemoryImage(
    (await rootBundle.load(Assets.assetsImagesGoogleplay)).buffer.asUint8List(),
  );
  final appStore = pw.MemoryImage(
    (await rootBundle.load(Assets.assetsImagesAppstore)).buffer.asUint8List(),
  );

  // Calculate the number of pages required
  final int totalPages = (cells.length / maxRowsPerPage).ceil();

  for (int page = 0; page < totalPages; page++) {
    List tableCell = [];

    // Add a new page to the PDF
    pdf.addPage(
      pw.MultiPage(
        build: (context) {
          List<pw.Widget> pageContent = [];

          // Header
          writeHeader(pageContent, image, name, location, orderId, orderDate,
              phoneNumber);

          // Calculate the start and end indices for the current page
          int startIndex = page * maxRowsPerPage;
          int endIndex = (page + 1) * maxRowsPerPage;

          // Add the rows for the current page
          for (int i = startIndex; i < endIndex && i < cells.length; i++) {
            // Add the header row
            if (i == startIndex) {
              writeTableHeader(tableCell);
            }
            writeRowItems(tableCell, cells, i);
          }
          createTable(pageContent, tableCell);
          // Footer

          if (page == totalPages - 1) {
            pageContent.add(
              // Your footer content here
              writeFooter(netTotal, discount, delivery, total, page, totalPages,
                  googlePlay, appStore),
            );
          } else {
            pageContent.add(footer(page, totalPages, googlePlay, appStore));
          }

          return pageContent;
        },
      ),
    );
  }
  Future<Directory> getDownloadDirectory() async {
    Directory directory;
    if (Platform.isAndroid) {
      directory = Directory('/storage/emulated/0/Download');
      if (!(await directory.exists())) {
        directory = (await getExternalStorageDirectory())!;
      }
    } else if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    } else {
      throw UnsupportedError("Unsupported platform");
    }
    return directory;
  }

  Directory? root = await getDownloadDirectory();
  String path = '${root.path}/Nilelon Invoice.pdf';
  final file = File(path);
  await file.writeAsBytes(await pdf.save());
}

pw.Column writeFooter(
    String netTotal,
    String discount,
    String delivery,
    String total,
    int page,
    int totalPages,
    pw.MemoryImage googlePlay,
    pw.MemoryImage appStore) {
  return pw.Column(
    children: [
      pw.Divider(),
      pw.SizedBox(
        height: 12,
      ),
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          writeTerms(),
          writeOrderOverview(netTotal, discount, delivery, total),
        ],
      ),
      pw.SizedBox(
        height: PdfPageFormat.standard.marginBottom,
      ),
      footer(page, totalPages, googlePlay, appStore),
    ],
  );
}

pw.Column writeTerms() {
  return pw.Column(
    mainAxisAlignment: pw.MainAxisAlignment.start,
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        'TERMS',
        style: const pw.TextStyle(
          color: PdfColor.fromInt(0xFFF59022),
          fontSize: 8,
        ),
      ),
      pw.SizedBox(
        height: 8,
      ),
      pw.SizedBox(
        width: PdfPageFormat.standard.width * 0.50,
        child: pw.Text(
          'The invoice due date - the date by which the payment is due should be clearly shown on the invoice.\nThis ensures that the customer\'s accounts payable team knows when to action payment.\nThe payment method and account details - specify how you accept payment. \nWith other payment types (e.g. bank transfer, card payment, or digital wallet) you may have to provide additional information.\nAlternatively, use invoicing and accounting software that supports one-click payment buttons within e-invoices.',
          style: const pw.TextStyle(
            color: PdfColor.fromInt(0xFF636664),
            fontSize: 5,
          ),
        ),
      ),
    ],
  );
}

pw.SizedBox writeOrderOverview(
    String netTotal, String discount, String delivery, String total) {
  return pw.SizedBox(
    width: PdfPageFormat.standard.width * 0.33,
    child: pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.start,
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(horizontal: 2),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'SUBTOTAL',
                style: pw.TextStyle(
                  color: const PdfColor.fromInt(0xFFF59022),
                  fontSize: 8,
                  fontWeight: pw.FontWeight.normal,
                ),
              ),
              pw.Text(
                netTotal,
                style: const pw.TextStyle(
                  color: PdfColor.fromInt(0xFF303331),
                  fontSize: 8,
                ),
              ),
            ],
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'DISCOUNT',
                style: pw.TextStyle(
                  color: const PdfColor.fromInt(0xFFF59022),
                  fontSize: 8,
                  fontWeight: pw.FontWeight.normal,
                ),
              ),
              pw.Text(
                discount,
                style: const pw.TextStyle(
                  color: PdfColor.fromInt(0xFF303331),
                  fontSize: 8,
                ),
              ),
            ],
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(2.0),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'DELIVERY',
                style: pw.TextStyle(
                  color: const PdfColor.fromInt(0xFFF59022),
                  fontSize: 8,
                  fontWeight: pw.FontWeight.normal,
                ),
              ),
              pw.Text(
                delivery,
                style: const pw.TextStyle(
                  color: PdfColor.fromInt(0xFF303331),
                  fontSize: 8,
                ),
              ),
            ],
          ),
        ),
        pw.SizedBox(
          height: 4,
        ),
        pw.Container(
          color: const PdfColor.fromInt(0xFFF59022),
          child: pw.Padding(
            padding: const pw.EdgeInsets.all(2.0),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'TOTAL',
                  style: pw.TextStyle(
                    color: const PdfColor.fromInt(0xFFFFFFFF),
                    fontSize: 8,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  total,
                  style: const pw.TextStyle(
                    color: PdfColor.fromInt(0xFFFFFFFF),
                    fontSize: 8,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

void createTable(List<pw.Widget> pageContent, List<dynamic> tableCell) {
  pageContent.add(
    pw.Table(
      children: tableCell.map(
        (cell) {
          return cell as pw.TableRow;
        },
      ).toList(),
    ),
  );
}

void writeRowItems(List<dynamic> tableCell, List<List<String>> cells, int i) {
  tableCell.add(buildTableRow(
    cells[i],
    isEven: i % 2 == 0,
    textStyles: [
      pw.TextStyle(
        color: const PdfColor.fromInt(0xFF303331),
        fontSize: 9,
        fontWeight: pw.FontWeight.bold,
      ),
      pw.TextStyle(
        color: const PdfColor.fromInt(0xFF636664),
        fontSize: 8,
        fontWeight: pw.FontWeight.normal,
      ),
      pw.TextStyle(
        color: const PdfColor.fromInt(0xFF636664),
        fontSize: 8,
        fontWeight: pw.FontWeight.normal,
      ),
      pw.TextStyle(
        color: const PdfColor.fromInt(0xFF636664),
        fontSize: 8,
        fontWeight: pw.FontWeight.normal,
      ),
      pw.TextStyle(
        color: const PdfColor.fromInt(0xFF636664),
        fontSize: 8,
        fontWeight: pw.FontWeight.normal,
      ),
      pw.TextStyle(
        color: const PdfColor.fromInt(0xFF636664),
        fontSize: 8,
        fontWeight: pw.FontWeight.normal,
      ),
    ],
  ));
}

void writeTableHeader(List<dynamic> tableCell) {
  tableCell.add(buildTableRowHeader(
    cellsHeader,
    isHeader: true,
    textStyles: [
      pw.TextStyle(
        color: const PdfColor.fromInt(0xFFFFFFFF),
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      pw.TextStyle(
        color: const PdfColor.fromInt(0xFFFFFFFF),
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      pw.TextStyle(
        color: const PdfColor.fromInt(0xFFFFFFFF),
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      pw.TextStyle(
        color: const PdfColor.fromInt(0xFFFFFFFF),
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      pw.TextStyle(
        color: const PdfColor.fromInt(0xFFFFFFFF),
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      pw.TextStyle(
        color: const PdfColor.fromInt(0xFFFFFFFF),
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
    ],
  ));
}

void writeHeader(List<pw.Widget> pageContent, pw.MemoryImage image, String name,
    String location, String orderId, String orderDate, String phoneNumber) {
  // Header
  pageContent.add(
    pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 20.0),
      child: pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          // create logo
          drawLogo(image),
          // Top Details
          writeTopDetails(name, location, orderId, orderDate, phoneNumber),
        ],
      ),
    ),
  );
}

pw.Row drawLogo(pw.MemoryImage image) {
  return pw.Row(
    children: [
      pw.Container(
        width: 158,
        height: 40,
        decoration: pw.BoxDecoration(
          image: pw.DecorationImage(image: image, fit: pw.BoxFit.cover),
        ),
      ),
    ],
  );
}

pw.Padding writeTopDetails(String name, String location, String orderId,
    String orderDate, String phoneNumber) {
  return pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 8, top: 16),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        // Name and location
        writeNameAndLocation(name, location),
        pw.SizedBox(
          width: 12,
        ),
        writeOrderDetails(orderId, orderDate, phoneNumber)
      ],
    ),
  );
}

pw.Row writeOrderDetails(String orderId, String orderDate, String phoneNumber) {
  return pw.Row(
    children: [
      // column 2
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // invoice number
          pw.Text(
            'Order ID ',
            style: const pw.TextStyle(
              color: PdfColor.fromInt(0xFF636664),
              fontSize: 10,
            ),
          ),
          pw.SizedBox(
            height: 7,
          ),
          // invoice date
          pw.Text(
            'Order Date ',
            style: const pw.TextStyle(
              color: PdfColor.fromInt(0xFF636664),
              fontSize: 10,
            ),
          ),
          pw.SizedBox(
            height: 7,
          ),
          // due date
          pw.Text(
            'Phone Number ',
            style: const pw.TextStyle(
              color: PdfColor.fromInt(0xFF636664),
              fontSize: 10,
            ),
          ),
        ],
      ),
      pw.SizedBox(
        width: 2,
      ),
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // invoice number
          pw.Text(
            ':',
            style: const pw.TextStyle(
              color: PdfColor.fromInt(0xFF636664),
              fontSize: 10,
            ),
          ),
          pw.SizedBox(
            height: 7,
          ),
          // invoice date
          pw.Text(
            ':',
            style: const pw.TextStyle(
              color: PdfColor.fromInt(0xFF636664),
              fontSize: 10,
            ),
          ),
          pw.SizedBox(
            height: 7,
          ),
          // due date
          pw.Text(
            ':',
            style: const pw.TextStyle(
              color: PdfColor.fromInt(0xFF636664),
              fontSize: 10,
            ),
          ),
        ],
      ),
      pw.SizedBox(
        width: 12,
      ),
      //column 3
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.end,
        children: [
          // invoice number
          pw.Text(
            orderId,
            style: pw.TextStyle(
              color: const PdfColor.fromInt(0xFFF59022),
              fontSize: 8,
              fontWeight: pw.FontWeight.normal,
            ),
          ),
          pw.SizedBox(
            height: 10,
          ),
          // invoice date
          pw.Text(
            orderDate,
            style: pw.TextStyle(
              color: const PdfColor.fromInt(0xFF0A1214),
              fontSize: 8,
              fontWeight: pw.FontWeight.normal,
            ),
          ),
          pw.SizedBox(
            height: 10,
          ),
          // due date
          pw.Text(
            phoneNumber,
            style: pw.TextStyle(
              color: const PdfColor.fromInt(0xFF0A1214),
              fontSize: 8,
              fontWeight: pw.FontWeight.normal,
            ),
          ),
        ],
      ),
    ],
  );
}

pw.Column writeNameAndLocation(String name, String location) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      // name
      pw.Text(
        name,
        style: pw.TextStyle(
          color: const PdfColor.fromInt(0xFF121914),
          fontSize: 12,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
      pw.SizedBox(
        height: 8,
      ),
      // location
      pw.SizedBox(
        width: 180,
        child: pw.Text(
          location,
          style: pw.TextStyle(
            color: const PdfColor.fromInt(0xFF636664),
            fontSize: 8,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      )
    ],
  );
}
