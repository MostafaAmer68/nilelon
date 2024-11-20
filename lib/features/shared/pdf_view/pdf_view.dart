import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:nilelon/core/data/hive_stroage.dart';
import 'package:nilelon/core/tools.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:open_filex/open_filex.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:nilelon/features/shared/pdf_view/build_table_row.dart';
import 'package:nilelon/features/shared/pdf_view/headers_list.dart';
import 'package:nilelon/features/shared/pdf_view/make_pdf.dart';
import 'package:nilelon/core/resources/const_functions.dart';
import 'package:nilelon/core/widgets/button/gradient_button_builder.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../generated/l10n.dart';

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
    // Listen for notification taps
    AwesomeNotifications().setListeners(onActionReceivedMethod: (r) async {
      // Check if the action button key is 'open'
      if (r.buttonKeyPressed == 'open') {
        String? filePath = r.payload?['file_path'];
        if (filePath != null) {
          // Open the folder containing the file
          String folderPath = filePath.substring(0, filePath.lastIndexOf('/'));
          await OpenFilex.open(folderPath);
        }
      }
    });
  }

  Future<void> _openFolder(String filePath) async {
    // Open the folder containing the file
    if (Platform.isAndroid) {
      // Open the folder containing the file
      String folderPath = filePath.substring(0, filePath.lastIndexOf('/'));
      await OpenFilex.open('/storage/emulated/0/Download/');
    } else if (Platform.isIOS) {
      // Handle iOS-specific behavior (e.g., display a custom dialog)
      // iOS doesn't support directly opening file explorer; you can navigate in-app.
      print("Folder opening not directly supported on iOS.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : GradientButtonBuilder(
            text: lang(context).downloadReceipt,
            width: screenWidth(context, 1),
            ontap: () async {
              // requestStoragePermission();

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

              final result = await makePdf(
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
              if (result.isNotEmpty) {
                isLoading = false;
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return PDFView(
                        filePath: result,
                      );
                    });
                _showNotification(result);
              } else {
                BotToast.showText(text: lang(context).smothingWent);
                isLoading = false;
              }
              setState(() {});
              // if ((await _requestStoragePermission())) {
              // } else {
              //   isLoading = false;
              //   setState(() {});
              //   // _showPermissionDeniedMessage();
              // }
              setState(() {});
            },
          );
  }

  Future<void> _showNotification(String filePath) async {
    AwesomeNotifications().createNotification(
      actionButtons: [
        NotificationActionButton(
          key: 'open',
          label: 'Show in Folder',
        ),
      ],
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: 'basic_channel',
        title: 'File Saved',
        actionType: ActionType.KeepOnTop,
        notificationLayout: NotificationLayout.Inbox,
        badge: 1,
        body:
            'Your file has been saved successfully!\n${filePath.split('/').last}',
        payload: {'file_path': filePath},
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
              child: Text(lang(context).confirm),
              onPressed: () async {
                Navigator.of(context).pop();
                await _requestStoragePermission();
              },
            ),
            TextButton(
              child: Text(lang(context).cancel),
              onPressed: () async {
                Navigator.of(context).pop();
                // await _requestStoragePermission();
              },
            ),
          ],
        );
      },
    );
  }

  // Future<bool> requestStoragePermission() async {
  //   PermissionStatus status = await Permission.storage.request();
  //   log((await Permission.storage.status).toString());
  //   Permission.storage.onDeniedCallback(() async {});
  //   return status.isGranted;
  // }

  Future<bool> _requestStoragePermission() async {
    await Permission.storage.request().then((_) async {});
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
