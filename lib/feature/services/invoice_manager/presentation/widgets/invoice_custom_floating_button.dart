import 'package:business_manager/core/theme/app_font_family.dart';
import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/feature/services/invoice_manager/models/invoice_one_model.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/pdf_template_one.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class InvoiceCustomFloatingButton extends StatelessWidget {
  final InvoiceOneModel Function() createInvoiceData;

  const InvoiceCustomFloatingButton({
    Key? key,
    required this.createInvoiceData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            WidgetStateProperty.all(Pallete.colorSeven.withOpacity(0.99)),
      ),
      onPressed: () async {
        try {
          final pdfData = createInvoiceData();


          final pdfDocument = await PdfTemplateOne(pdfData: pdfData).generatePdf();

          final pdfBytes = await pdfDocument.save();
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
      child: const Padding(
        padding: EdgeInsets.all(Constants.padding4),
        child: Text(
          'Preview PDF',
          style: TextStyle(
            color: Pallete.colorOne,
            fontSize: 24,
            fontWeight: FontWeight.w600,
            fontFamily: AppFontFamily.orbitron,
          ),
        ),
      ),
    );
  }
}
