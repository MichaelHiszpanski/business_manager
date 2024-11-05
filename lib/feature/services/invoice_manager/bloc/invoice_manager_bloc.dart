import 'package:bloc/bloc.dart';
import 'package:business_manager/feature/services/invoice_manager/models/business_details_model.dart';
import 'package:business_manager/feature/services/invoice_manager/models/client_details_model.dart';
import 'package:equatable/equatable.dart';

part 'invoice_manager_event.dart';

part 'invoice_manager_state.dart';

class InvoiceManagerBloc
    extends Bloc<InvoiceManagerEvent, InvoiceManagerState> {
  InvoiceManagerBloc() : super(InvoiceManagerInitial()) {
    on<InvoiceManagerEvent>((event, emit) {});
    on<InvoiceManagerAddBusiness>(_addBusinessDetails);
  }

  Future<void> _addBusinessDetails(
      InvoiceManagerEvent event, Emitter<InvoiceManagerState> emit) async {}
}
