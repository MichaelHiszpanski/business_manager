import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'invoice_manager_event.dart';
part 'invoice_manager_state.dart';

class InvoiceManagerBloc extends Bloc<InvoiceManagerEvent, InvoiceManagerState> {
  InvoiceManagerBloc() : super(InvoiceManagerInitial()) {
    on<InvoiceManagerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
