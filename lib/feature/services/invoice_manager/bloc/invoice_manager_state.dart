part of 'invoice_manager_bloc.dart';

sealed class InvoiceManagerState extends Equatable {
  const InvoiceManagerState();

  @override
  List<Object> get props => [];
}

final class InvoiceManagerInitial extends InvoiceManagerState {}

final class InvoiceManagerLoading extends InvoiceManagerState {}

final class InvoiceManagerLoaded extends InvoiceManagerState {
  final List<BusinessDetailsModel> businessDetailsDataList;
  final List<ClientDetailsModel> clientDetailsDataList;
  final List<InvoiceItemModel> invoiceItemsList;
  final List<BankDetailsModel> bankDetailsDataList;

  const InvoiceManagerLoaded({
    required this.businessDetailsDataList,
    required this.clientDetailsDataList,
    required this.invoiceItemsList,
    required this.bankDetailsDataList,
  });

  @override
  List<Object> get props => [
        businessDetailsDataList,
        clientDetailsDataList,
        invoiceItemsList,
        bankDetailsDataList,
      ];
}

final class InvoiceManagerError extends InvoiceManagerState {}
