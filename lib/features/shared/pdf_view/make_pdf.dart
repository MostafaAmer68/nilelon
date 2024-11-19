import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:nilelon/features/shared/pdf_view/build_table_row.dart';
import 'package:nilelon/features/shared/pdf_view/build_table_row_header.dart';
import 'package:nilelon/features/shared/pdf_view/headers_list.dart';
import 'package:nilelon/features/shared/pdf_view/pdf_footer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';
// import 'package:flutter/services.dart';

Future<String> makePdf({
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
  if (orderId.isEmpty) {
    return '';
  }
  const int maxRowsPerPage = 18;

  final pdf = pw.Document();
  final image = pw.MemoryImage(
    (await rootBundle.load('assets/images/log.png')).buffer.asUint8List(),
  );

  final googlePlay = pw.MemoryImage(
    (await rootBundle.load('assets/images/googleplay.png'))
        .buffer
        .asUint8List(),
  );
  final appStore = pw.MemoryImage(
    (await rootBundle.load('assets/images/appstore.png')).buffer.asUint8List(),
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
          pageContent.add(
            pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 20.0),
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  // logo
                  pw.Row(
                    children: [
                      pw.Container(
                        width: 158,
                        height: 40,
                        decoration: pw.BoxDecoration(
                            image: pw.DecorationImage(
                                image: image, fit: pw.BoxFit.cover)),
                      ),
                    ],
                  ),
                  // Top Details
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(bottom: 8, top: 16),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        // Name and location
                        pw.Column(
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
                        ),
                        pw.SizedBox(
                          width: 12,
                        ),
                        pw.Row(
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
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );

          // Calculate the start and end indices for the current page
          int startIndex = page * maxRowsPerPage;
          int endIndex = (page + 1) * maxRowsPerPage;

          // Add the rows for the current page
          for (int i = startIndex; i < endIndex && i < cells.length; i++) {
            // Add the header row
            if (i == startIndex) {
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
          pageContent.add(pw.Table(
              children: tableCell.map(
            (cell) {
              return cell as pw.TableRow;
            },
          ).toList()));
          // Footer

          if (page == totalPages - 1) {
            pageContent.add(
              // Your footer content here
              pw.Column(
                children: [
                  pw.Divider(),
                  pw.SizedBox(
                    height: 12,
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
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
                      ),
                      pw.SizedBox(
                        width: PdfPageFormat.standard.width * 0.33,
                        child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            pw.Padding(
                              padding:
                                  const pw.EdgeInsets.symmetric(horizontal: 2),
                              child: pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
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
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      'TOTAL',
                                      style: pw.TextStyle(
                                        color:
                                            const PdfColor.fromInt(0xFFFFFFFF),
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
                      ),
                    ],
                  ),
                  pw.SizedBox(
                    height: PdfPageFormat.standard.marginBottom,
                  ),
                  footer(page, totalPages, googlePlay, appStore),
                ],
              ),
            );
          } else {
            pageContent.add(footer(page, totalPages, googlePlay, appStore));
          }

          return pageContent;
        },
      ),
    );
  }

  Directory? directory = await getExternalStorageDirectory();
  if (directory != null) {
    String newPath = "";

    // Get the "Documents" folder by modifying the path
    List<String> paths = directory.path.split("/");
    for (int i = 1; i < paths.length; i++) {
      String folder = paths[i];
      if (folder == "Android") break;
      newPath += "/$folder";
    }
    newPath += "/Download";

    final documentsDirectory = Directory(newPath);

    // Create the directory if it doesn't exist
    if (!documentsDirectory.existsSync()) {
      documentsDirectory.createSync(recursive: true);
    }

    String path =
        '${documentsDirectory.path}/Nilelon Invoice(${orderId.substring(15)}).pdf';
    log(path);
    final file = File(path);
    final result = await file.writeAsBytes(await pdf.save());
    return result.path;
  }
  return '';
}
