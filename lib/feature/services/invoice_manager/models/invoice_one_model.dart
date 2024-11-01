import 'package:business_manager/feature/services/invoice_manager/models/invoice_item_model.dart';

class InvoiceOneModel {
  final String businessName;
  final String businessOwnerStreet;
  final String businessOwnerCity;
  final String businessOwnerMobile;
  final String businessOwnerEmail;
  final DateTime invoiceDateTimeCreated;
  final String invoiceNumber;
  final String clientName;
  final String clientStreet;
  final String clientCity;
  final String clientMobile;
  final String clientEmail;
  final List<InvoiceItemModel> invoiceItemsList;
  final String thankYouMessage;
  final String paymentDueMessage;

  InvoiceOneModel({
    required this.businessName,
    required this.businessOwnerStreet,
    required this.businessOwnerCity,
    required this.businessOwnerMobile,
    required this.businessOwnerEmail,
    required this.invoiceDateTimeCreated,
    required this.invoiceNumber,
    required this.clientName,
    required this.clientStreet,
    required this.clientCity,
    required this.clientEmail,
    required this.clientMobile,
    required this.invoiceItemsList,
    required this.thankYouMessage,
    required this.paymentDueMessage,
  });
}


