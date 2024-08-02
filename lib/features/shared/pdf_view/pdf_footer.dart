import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.Column footer(page, totalPages, googlePlay, appStore) {
  return pw.Column(
    children: [
      pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Text(
              (page + 1).toString(),
              style: pw.TextStyle(
                color: const PdfColor.fromInt(0xFF000000),
                fontSize: 8,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              '/${(totalPages).toString()} Page',
              style: const pw.TextStyle(
                color: PdfColor.fromInt(0xFF686868),
                fontSize: 6,
              ),
            )
          ]),
      pw.Divider(),
      pw.Padding(
          padding: const pw.EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'info@nilelon.com',
                style: const pw.TextStyle(
                  color: PdfColor.fromInt(0xFF636664),
                  fontSize: 6,
                ),
              ),
              pw.Text(
                'nilelon.com',
                style: const pw.TextStyle(
                  color: PdfColor.fromInt(0xFF636664),
                  fontSize: 6,
                ),
              ),
              pw.Text(
                '+20 100 888 4285',
                style: const pw.TextStyle(
                  color: PdfColor.fromInt(0xFF636664),
                  fontSize: 6,
                ),
              ),
              pw.Row(
                children: [
                  pw.SizedBox(
                    width: 52.44,
                    height: 15.15,
                    child: pw.Image(appStore),
                  ),
                  pw.SizedBox(
                    width: 6,
                  ),
                  pw.SizedBox(
                    width: 52.44,
                    height: 15.15,
                    child: pw.Image(googlePlay),
                  ),
                ],
              ),
            ],
          ))
    ],
  );
}
