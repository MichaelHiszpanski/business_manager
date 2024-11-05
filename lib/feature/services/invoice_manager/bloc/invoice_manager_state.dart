part of 'invoice_manager_bloc.dart';

sealed class InvoiceManagerState extends Equatable {
  const InvoiceManagerState();

  @override
  List<Object> get props => [];
}

final class InvoiceManagerInitial extends InvoiceManagerState {}

final class InvoiceManagerLoading extends InvoiceManagerState {}

final class InvoiceManagerLoaded extends InvoiceManagerState {
  final BusinessDetailsModel businessDetailsData;
  final ClientDetailsModel clientDetailsData;

  const InvoiceManagerLoaded({
    required this.businessDetailsData,
    required this.clientDetailsData,
  });


  @override
  List<Object> get props => [businessDetailsData,clientDetailsData];
}
