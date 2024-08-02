import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.TableRow buildTableRowHeader(
  List<String> cells, {
  bool isHeader = false,
  bool isEven = false,
  List<pw.TextStyle?>? textStyles,
}) {
  return pw.TableRow(
    verticalAlignment: pw.TableCellVerticalAlignment.bottom,
    decoration: isHeader
        ? const pw.BoxDecoration(color: PdfColor.fromInt(0xFFF59022))
        : isEven
            ? const pw.BoxDecoration()
            : const pw.BoxDecoration(color: PdfColor.fromInt(0xFFF2F2F2)),
    children: List.generate(
      cells.length,
      (index) {
        return pw.Padding(
          padding: const pw.EdgeInsets.all(8.0),
          child: pw.Text(
            cells[index],
            textAlign: pw.TextAlign.center,
            style: textStyles == null
                ? pw.TextStyle(
                    fontSize: isHeader ? 28 : 16,
                    fontWeight:
                        isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
                    color: isHeader
                        ? const PdfColor.fromInt(0xFFFFFFFF)
                        : const PdfColor.fromInt(0xFF303331),
                  )
                : textStyles[index],
          ),
        );
      },
    ),
  );
}
