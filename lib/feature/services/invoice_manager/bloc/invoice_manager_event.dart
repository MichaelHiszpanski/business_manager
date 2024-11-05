part of 'invoice_manager_bloc.dart';

sealed class InvoiceManagerEvent extends Equatable {
  const InvoiceManagerEvent();

  @override
  List<Object> get props => [];
}

class InvoiceManagerAddBusiness extends InvoiceManagerEvent {
  final BusinessDetailsModel businessDetailsData;

  const InvoiceManagerAddBusiness({required this.businessDetailsData});

  @override
  List<Object> get props => [businessDetailsData];
}

class InvoiceManagerAddClient extends InvoiceManagerEvent {
  final ClientDetailsModel clientDetailsData;

  const InvoiceManagerAddClient({required this.clientDetailsData});

  @override
  List<Object> get props => [clientDetailsData];
}

class InvoiceManagerDisplay extends InvoiceManagerEvent {
  const InvoiceManagerDisplay();

  @override
  List<Object> get props => [];
}
