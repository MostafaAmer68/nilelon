import 'package:flutter/material.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:nilelon/features/shared/pdf_view/build_table_row.dart';
import 'package:nilelon/features/shared/pdf_view/headers_list.dart';
import 'package:nilelon/features/shared/pdf_view/make_pdf.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:permission_handler/permission_handler.dart';

class NilelonPdfView extends StatefulWidget {
  const NilelonPdfView({
    super.key,
    required this.cells,
    required this.netTotal,
    required this.discount,
    required this.total,
    required this.delivery,
    required this.location,
    required this.orderId,
    required this.orderDate,
  });

  final List<List<String>> cells;
  final String netTotal;
  final String discount;
  final String delivery;
  final String total;
  final String location;
  final String orderId;
  final String orderDate;

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
      text: 'Download Receipt',
      width: screenWidth(context, 1),
      ontap: () async {
        if ((await requestStoragePermission())) {
          rows.add(
            buildTableRow(cellsHeader, isHeader: true),
          );
          for (var rowData in widget.cells) {
            rows.add(buildTableRow(
              rowData,
            ));
          }

          await generateOrderPdf(
            cells: widget.cells,
            netTotal: widget.netTotal,
            discount: widget.discount,
            delivery: widget.delivery,
            total: widget.total,
            name: HiveStorage.get<UserModel>(HiveKeys.userModel)
                .getUserData<CustomerModel>()
                .name,
            location: widget.location,
            orderId: widget.orderId,
            orderDate: widget.orderDate,
            phoneNumber: HiveStorage.get<UserModel>(HiveKeys.userModel)
                .getUserData<CustomerModel>()
                .phoneNumber,
          );
        } else {
          _showPermissionDeniedMessage();
        }
      },
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

  Future<bool> requestStoragePermission() async {
    PermissionStatus status = await Permission.storage.request();
    return status.isGranted;
  }
}
