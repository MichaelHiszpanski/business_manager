import 'package:business_manager/core/helpers/date_format_helper.dart';
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
                      pw.Text(
                        pdfData.businessDetailsModel.businessName,
                        style: pw.TextStyle(
                          fontSize: 22,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                          "${pdfData.businessDetailsModel.businessFirstName} ${pdfData.businessDetailsModel.businessLastName}"),
                      pw.Text(pdfData.businessDetailsModel.businessOwnerStreet),
                      pw.Text(pdfData.businessDetailsModel.businessOwnerCity),
                      pw.Text(
                          "Mobile: ${pdfData.businessDetailsModel.businessOwnerMobile}"),
                      pw.Text(
                          "Email: ${pdfData.businessDetailsModel.businessOwnerEmail}"),
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
                          "Date: ${DateFormatHelper.dateFomrat(pdfData.invoiceDateTimeCreated)}"),
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
              pw.Text(
                  "${pdfData.clientDetailsModel.clientFirstName} ${pdfData.clientDetailsModel.clientLastName}"),
              pw.Text(pdfData.clientDetailsModel.clientStreet),
              pw.Text(pdfData.clientDetailsModel.clientCity),
              pw.Text("Mobile: ${pdfData.clientDetailsModel.clientMobile}"),
              pw.Text("Email: ${pdfData.clientDetailsModel.clientEmail}"),
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
                            pw.Text(
                                "£ ${(pdfData.subTotalPrice!).toStringAsFixed(2)}",
                                style: pw.TextStyle(fontSize: 14)),
                          ],
                        ),
                        // pw.Row(
                        //   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     pw.Text("Tax (10%):",
                        //         style: pw.TextStyle(fontSize: 14)),
                        //     pw.Text(
                        //         "£ ${(pdfData.subTotalPrice! * 0.1).toStringAsFixed(2)}",
                        //         style: pw.TextStyle(fontSize: 14)),
                        //   ],
                        // ),
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
                              "£ ${(pdfData.subTotalPrice!).toStringAsFixed(2)}", //+ (pdfData.subTotalPrice! * 0.1)
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
                " ${pdfData.paymentDueDays}.",
                style: pw.TextStyle(
                  fontSize: 12,
                  fontStyle: pw.FontStyle.italic,
                ),
              ),
              pw.SizedBox(height: 16),
              pw.Divider(),
              pw.SizedBox(height: 8),
              pw.Container(
                width: 200,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      "Bank Name: ${pdfData.bankDetailsModel.bankName}",
                      style: pw.TextStyle(fontSize: 16),
                    ),
                    pw.Text(
                      "Sort Code:  ${pdfData.bankDetailsModel.sortCode}",
                      style: pw.TextStyle(fontSize: 16),
                    ),
                    pw.Text(
                      "Account No:  ${pdfData.bankDetailsModel.accountNo}",
                      style: pw.TextStyle(fontSize: 16),
                    ),
                    pw.SizedBox(height: 8),
                    pw.Divider(),
                  ],
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
