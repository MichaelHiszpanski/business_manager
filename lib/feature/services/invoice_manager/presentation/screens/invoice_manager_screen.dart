import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/invoice_custom_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:pdf/pdf.dart' as pdf;

class InvoiceManagerScreen extends StatefulWidget {
  const InvoiceManagerScreen({super.key});

  @override
  State<InvoiceManagerScreen> createState() => _InvoiceManagerScreenState();
}

class _InvoiceManagerScreenState extends State<InvoiceManagerScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  pw.Document generatePdf() {
    final document = pw.Document();

    document.addPage(
      pw.Page(
        pageFormat: pdf.PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            children: [
              pw.Text("Preview Document", style: pw.TextStyle(fontSize: 24)),
              pw.Text("Name: ${_nameController.text}"),
              pw.Text("Details: ${_detailsController.text}"),
            ],
          );
        },
      ),
    );
    return document;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.colorThree,
      appBar: AppBar(
        backgroundColor: Pallete.colorThree,
        title: const Text(
          'Invoice Service ',
          style: TextStyle(
            color: Pallete.colorTwo,
            fontFamily: "Jaro",
            fontSize: 24,
          ),
        ),
        iconTheme: IconThemeData(
          color: Pallete.colorOne,
          size: 28,
          shadows: [
            BoxShadow(
              color: Colors.black38.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: Pallete.colorOne,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: _detailsController,
              decoration: InputDecoration(labelText: 'Details'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Positioned(
            bottom: 20,
            right: 0,
            child: InvoiceCustomFloatingButton(
              generatePdf: generatePdf,
            ),
          ),
        ],
      ),
    );
  }
}
