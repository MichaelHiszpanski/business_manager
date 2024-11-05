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

  const InvoiceManagerLoaded({
   required this.businessDetailsDataList,
    required this.clientDetailsDataList,
  });

  @override
  List<Object> get props => [businessDetailsDataList, clientDetailsDataList];
}

final class InvoiceManagerError extends InvoiceManagerState {}
