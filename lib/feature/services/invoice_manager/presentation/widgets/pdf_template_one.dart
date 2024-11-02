import 'package:business_manager/feature/services/invoice_manager/models/invoice_one_model.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart' as pdf;

class PdfTemplateOne {
  final InvoiceOneModel pdfData;

  PdfTemplateOne({required this.pdfData});

  pw.Document generatePdf() {
    final invoiceOne = pw.Document();

    invoiceOne.addPage(
      pw.Page(
        pageFormat: pdf.PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(pdfData.businessName,
                          style: pw.TextStyle(
                              fontSize: 24, fontWeight: pw.FontWeight.bold)),
                      pw.Text(pdfData.businessOwnerStreet),
                      pw.Text(pdfData.clientCity),
                      pw.Text(pdfData.businessOwnerMobile),
                      pw.Text(pdfData.businessOwnerEmail),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text("Invoice",
                          style: pw.TextStyle(
                              fontSize: 24, fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: 8),
                      pw.Text(
                          // "Date: ${DateTime.now().toString().split(' ')[0]}"
                          "Date: ${pdfData.invoiceDateTimeCreated}"),
                      pw.Text("Invoice #: ${pdfData.invoiceNumber}"),
                    ],
                  ),
                ],
              ),
              pw.Divider(height: 32),
              pw.Text(
                "Bill To:",
                style:
                    pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(pdfData.clientName),
              pw.Text(pdfData.clientStreet),
              pw.Text(pdfData.clientCity),
              pw.Text(pdfData.clientMobile),
              pw.Text(pdfData.clientEmail),
              pw.SizedBox(height: 32),
              pw.TableHelper.fromTextArray(
                border: pw.TableBorder.all(),
                headers: ['Description', 'Quantity', 'Unit Price', 'Total'],
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                cellAlignment: pw.Alignment.centerLeft,
                cellHeight: 30,
                columnWidths: {
                  0: pw.FlexColumnWidth(4),
                  1: pw.FlexColumnWidth(1),
                  2: pw.FlexColumnWidth(2),
                  3: pw.FlexColumnWidth(2),
                },
                cellStyle: pw.TextStyle(fontSize: 12),
                data: pdfData.invoiceItemsList
                    .map((item) => [
                          item.description,
                          item.quantity,
                          item.itemPrice,
                          item.totalItems,
                        ])
                    .toList(),
              ),
              pw.Divider(height: 32),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Container(
                    width: 200,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text("Subtotal:",
                                style: pw.TextStyle(fontSize: 14)),
                            pw.Text("\$275.00",
                                style: pw.TextStyle(fontSize: 14)),
                          ],
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text("Tax (10%):",
                                style: pw.TextStyle(fontSize: 14)),
                            pw.Text("\$27.50",
                                style: pw.TextStyle(fontSize: 14)),
                          ],
                        ),
                        pw.Divider(),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              "Total Due:",
                              style: pw.TextStyle(
                                  fontSize: 16, fontWeight: pw.FontWeight.bold),
                            ),
                            pw.Text(
                              "\$302.50",
                              style: pw.TextStyle(
                                  fontSize: 16, fontWeight: pw.FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 32),
              pw.Text(
                "Thank you for your business!",
                style: pw.TextStyle(fontSize: 16),
              ),
              pw.Text(
                "Payment is due within 15 days.",
                style: pw.TextStyle(
                  fontSize: 12,
                  fontStyle: pw.FontStyle.italic,
                ),
              ),
            ],
          );
        },
      ),
    );

    return invoiceOne;
  }
}
