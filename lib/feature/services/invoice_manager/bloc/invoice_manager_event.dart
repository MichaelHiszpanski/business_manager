part of 'invoice_manager_bloc.dart';

sealed class InvoiceManagerEvent extends Equatable {
  const InvoiceManagerEvent();

  @override
  List<Object> get props => [];
}

class InitialInvoiceManager extends InvoiceManagerEvent {
  const InitialInvoiceManager();
}

class InvoiceManagerAddBusiness extends InvoiceManagerEvent {
  final BusinessDetailsModel businessDetailsData;

  const InvoiceManagerAddBusiness({required this.businessDetailsData});

  @override
  List<Object> get props => [businessDetailsData];
}

class InvoiceManagerRemoveBusiness extends InvoiceManagerEvent {
  final String businessID;

  const InvoiceManagerRemoveBusiness({required this.businessID});

  @override
  List<Object> get props => [businessID];
}

class InvoiceManagerAddClient extends InvoiceManagerEvent {
  final ClientDetailsModel clientDetailsData;

  const InvoiceManagerAddClient({required this.clientDetailsData});

  @override
  List<Object> get props => [clientDetailsData];
}

class InvoiceManagerRemoveClient extends InvoiceManagerEvent {
  final String clientID;

  const InvoiceManagerRemoveClient({required this.clientID});

  @override
  List<Object> get props => [clientID];
}

class InvoiceManagerAddItem extends InvoiceManagerEvent {
  final InvoiceItemModel invoiceItemData;

  const InvoiceManagerAddItem({required this.invoiceItemData});

  @override
  List<Object> get props => [invoiceItemData];
}

class InvoiceManagerRemoveItem extends InvoiceManagerEvent {
  final String itemID;

  const InvoiceManagerRemoveItem({required this.itemID});

  @override
  List<Object> get props => [itemID];
}

class InvoiceManagerAddBank extends InvoiceManagerEvent {
  final BankDetailsModel bankDetailsData;

  const InvoiceManagerAddBank({required this.bankDetailsData});

  @override
  List<Object> get props => [bankDetailsData];
}

class InvoiceManagerRemoveBank extends InvoiceManagerEvent {
  final String bankID;

  const InvoiceManagerRemoveBank({required this.bankID});

  @override
  List<Object> get props => [bankID];
}

class InvoiceManagerDisplay extends InvoiceManagerEvent {
  const InvoiceManagerDisplay();

  @override
  List<Object> get props => [];
}
