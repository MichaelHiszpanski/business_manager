import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/feature/services/invoice_manager/models/invoice_item_model.dart';
import 'package:business_manager/feature/services/invoice_manager/models/invoice_one_model.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/invoice_custom_floating_button.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/invoice_inputs.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/invoice_screen_left_button.dart';

import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:pdf/pdf.dart' as pdf;

class InvoiceManagerScreen extends StatefulWidget {
  const InvoiceManagerScreen({super.key});

  @override
  State<InvoiceManagerScreen> createState() => _InvoiceManagerScreenState();
}

class _InvoiceManagerScreenState extends State<InvoiceManagerScreen> {
  final TextEditingController _businessOwnerName = TextEditingController();
  final TextEditingController _businessOwnerStreet = TextEditingController();

  InvoiceOneModel _createInvoiceData() {
    return InvoiceOneModel(
      businessName: _businessOwnerName.text,
      businessOwnerStreet: _businessOwnerStreet.text,
      businessOwnerCity: "City, State, Zip",
      businessOwnerMobile: "(123) 456-7890",
      businessOwnerEmail: "business@example.com",
      invoiceDateTimeCreated: DateTime.now(),
      invoiceNumber: "00123",
      clientName: _businessOwnerName.text,
      clientStreet: "456 Client Rd",
      clientCity: "City, State, Zip",
      clientMobile: "(987) 654-3210",
      clientEmail: "client@example.com",
      invoiceItemsList: [
        InvoiceItemModel(
            description: "Service/Product 1",
            quantity: "1",
            itemPrice: "\$100.00",
            totalItems: "\$100.00"),
        InvoiceItemModel(
            description: "Service/Product 2",
            quantity: "2",
            itemPrice: "\$50.00",
            totalItems: "\$100.00"),
      ],
      thankYouMessage: "Thank you for your business!",
      paymentDueMessage: "Payment is due within 15 days.",
    );
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
        child: InvoiceInputs(
          businessOwnerName: _businessOwnerName,
          businessOwnerStreet: _businessOwnerStreet,
        ),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Positioned(
            bottom: 20,
            left: 20,
            child: InvoiceScreenLeftButton(onItemCliked: _onLeftItemsClicked),
          ),
          Positioned(
            bottom: 20,
            right: 0,
            // child: InvoiceCustomFloatingButton(
            //   generatePdf:
            //       PdfTemplateOne(pdfData: _createInvoiceData()).generatePdf,
            // ),
            child: InvoiceCustomFloatingButton(
              createInvoiceData: _createInvoiceData,
            ),
          ),
        ],
      ),
    );
  }

  void _onLeftItemsClicked(int index) {
    switch (index) {
      case 0:
        setState(() {});
        break;
      case 1:
        setState(() {});
        break;
      case 2:
      default:
        setState(() {});
        break;
    }
  }
}
