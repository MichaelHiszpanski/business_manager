part of 'invoice_manager_bloc.dart';

sealed class InvoiceManagerState extends Equatable {
  const InvoiceManagerState();
  
  @override
  List<Object> get props => [];
}

final class InvoiceManagerInitial extends InvoiceManagerState {}
