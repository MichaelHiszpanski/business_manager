import 'package:business_manager/feature/services/invoice_manager/models/bank_details_model.dart';
import 'package:business_manager/feature/services/invoice_manager/models/business_details_model.dart';
import 'package:business_manager/feature/services/invoice_manager/models/client_details_model.dart';
import 'package:business_manager/feature/services/invoice_manager/models/invoice_item_model.dart';
import 'package:equatable/equatable.dart';

class InvoiceOneModel extends Equatable {
  final DateTime invoiceDateTimeCreated;
  final String invoiceNumber;
  final BusinessDetailsModel businessDetailsModel;
  final ClientDetailsModel clientDetailsModel;
  final BankDetailsModel bankDetailsModel;
  final List<InvoiceItemModel> invoiceItemsList;
  final String thankYouMessage;
  final String paymentDueDays;
  final double? subTotalPrice;

  const InvoiceOneModel({
    required this.invoiceDateTimeCreated,
    required this.invoiceNumber,
    required this.businessDetailsModel,
    required this.clientDetailsModel,
    required this.bankDetailsModel,
    required this.invoiceItemsList,
    required this.thankYouMessage,
    required this.paymentDueDays,
    this.subTotalPrice = 0,
  });

  @override
  List<Object?> get props => [
        invoiceDateTimeCreated,
        invoiceNumber,
        businessDetailsModel,
        clientDetailsModel,
        bankDetailsModel,
        invoiceItemsList,
        thankYouMessage,
        paymentDueDays,
      ];
}
