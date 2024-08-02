import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:nilelon/features/shared/pdf_view/build_table_row.dart';
import 'package:nilelon/features/shared/pdf_view/headers_list.dart';
import 'package:nilelon/features/shared/pdf_view/make_pdf.dart';
import 'package:nilelon/resources/const_functions.dart';
import 'package:nilelon/widgets/button/gradient_button_builder.dart';
import 'package:permission_handler/permission_handler.dart';

class NilelonPdfView extends StatefulWidget {
  const NilelonPdfView({
    super.key,
    required this.cells,
    required this.netTotal,
    required this.discount,
    required this.total,
    required this.delivery,
  });

  final List<List<String>> cells;
  final String netTotal;
  final String discount;
  final String delivery;
  final String total;

  @override
  State<NilelonPdfView> createState() => _NilelonPdfViewState();
}

class _NilelonPdfViewState extends State<NilelonPdfView> {
  List<pw.TableRow> rows = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GradientButtonBuilder(
      text: 'Download Receipt ',
      width: screenWidth(context, 1),
      ontap: () => requestStoragePermission(
        rows,
        widget.cells,
        widget.netTotal,
        widget.discount,
        widget.delivery,
        widget.total,
      ),
    );
  }

  void _showPermissionDeniedMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permission Denied'),
          content:
              const Text('Storage permission is required to save the PDF.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> requestStoragePermission(
      rows, cells, netTotal, discount, delivery, total) async {
    PermissionStatus status = await Permission.storage.request();

    if (status.isGranted) {
      print('helllo');
      rows.add(
        buildTableRow(cellsHeader, isHeader: true),
      );
      for (var rowData in cells) {
        rows.add(buildTableRow(
          rowData,
        ));
      }
      await makePdf(
        cells: cells,
        netTotal: netTotal,
        discount: discount,
        delivery: delivery,
        total: total,
        name: 'Mostafa Amer',
        location:
            '2 Abi Rabiea Suleiman Street, Next to Waraq Al-Tout for Grilled Foods, Al-Hofuf',
        orderId: '223556481123887',
        orderDate: '25/12/2024',
        phoneNumber: '+20 100 123 4567',
      );
    } else {
      print('helllo2');
      _showPermissionDeniedMessage();
      print(status);
      // Handle the case when the user denies the permission.
    }
  }
}
