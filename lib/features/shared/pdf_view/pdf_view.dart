import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/core/tools.dart';
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
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : GradientButtonBuilder(
            text: lang(context).downloadReceipt,
            width: screenWidth(context, 1),
            ontap: () async {
              isLoading = true;
              setState(() {});
              rows.add(
                buildTableRow(cellsHeader, isHeader: true),
              );
              for (var rowData in widget.cells) {
                rows.add(buildTableRow(
                  rowData,
                ));
              }

              await makePdf(
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
              ).then((v) {
                isLoading = false;
                BotToast.showText(text: lang(context).pdfSaved);
                setState(() {});
              });
              // if ((await _requestStoragePermission())) {
              // } else {
              //   isLoading = false;
              //   setState(() {});
              //   _showPermissionDeniedMessage();
              // }
              // setState(() {});
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
              onPressed: () async {
                Navigator.of(context).pop();
                await requestStoragePermission();
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> requestStoragePermission() async {
    PermissionStatus status = await Permission.storage.request();
    log((await Permission.storage.status).toString());
    Permission.storage.onDeniedCallback(() async {});
    return status.isGranted;
  }

  Future<bool> _requestStoragePermission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      // Request permission
      if (await Permission.storage.request().isGranted) {
        // Permission granted
        print("Storage permission granted.");
      } else {
        // Permission denied
        _showPermissionDeniedMessage();
      }
    } else if (status.isPermanentlyDenied) {
      // Open app settings if permission is permanently denied
      await openAppSettings();
    } else {
      // Permission already granted
      print("Storage permission already granted.");
    }
    return status.isGranted;
  }
}
