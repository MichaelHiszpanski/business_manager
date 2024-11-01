import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart' as pdf;
class InvoiceCustomFloatingButton extends StatelessWidget {
  final pw.Document Function() generatePdf;

  const InvoiceCustomFloatingButton({
    Key? key,
    required this.generatePdf,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        try {
          final pdfBytes = await generatePdf().save();
          print("PDF generated successfully with ${pdfBytes.length} bytes");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PdfPreview(
                build: (format) => pdfBytes,
                pdfPreviewPageDecoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  color: Colors.white,
                ),
                scrollViewDecoration: BoxDecoration(
                  color: Colors.grey[100],
                ),
                previewPageMargin: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                padding: const EdgeInsets.only(bottom: 24),
                enableScrollToPage: true,
                actionBarTheme: PdfActionBarTheme(
                  height: 160,
                  backgroundColor: Colors.grey[800],
                  iconColor: Colors.white,
                  elevation: 6.0,
                  actionSpacing: 8.0,
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                ),
              ),
            ),
          );
        } catch (e) {
          print("Error generating PDF: $e");
        }
      },
      child: const Text('Preview PDF'),
    );
  }
}
