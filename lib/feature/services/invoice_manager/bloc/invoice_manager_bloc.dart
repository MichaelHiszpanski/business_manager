import 'package:bloc/bloc.dart';
import 'package:business_manager/core/storage_hive/hive_properites.dart';
import 'package:business_manager/feature/services/invoice_manager/data/hive/business_hive/business_details_hive.dart';
import 'package:business_manager/feature/services/invoice_manager/models/business_details_model.dart';
import 'package:business_manager/feature/services/invoice_manager/models/client_details_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'invoice_manager_event.dart';

part 'invoice_manager_state.dart';

class InvoiceManagerBloc
    extends Bloc<InvoiceManagerEvent, InvoiceManagerState> {
  late final List<BusinessDetailsModel> _businessBox;

  InvoiceManagerBloc() : super(InvoiceManagerInitial()) {
    on<InvoiceManagerEvent>((event, emit) {});
    on<InvoiceManagerAddBusiness>(_addBusinessDetails);
    on<InvoiceManagerDisplay>(_displayInvoiceData);
  }

  Future<void> _initializeHive() async {
    add(const InvoiceManagerDisplay());
  }

  Future<void> _addBusinessDetails(InvoiceManagerAddBusiness event,
      Emitter<InvoiceManagerState> emit) async {
    emit(InvoiceManagerLoading());
    Box box = await Hive.openBox(
        HiveInvoiceManagerProperties.TO_INVOICE_MANAGER_DATA_BOX);
    List<dynamic>? getExistingHiveData =
        box.get(HiveInvoiceManagerProperties.TO_INVOICE_MANAGER_DATA_KEY);
    List<BusinessDetailsHive> businessDetailList = [];

    _businessBox.add(event.businessDetailsData);
    if (getExistingHiveData != null) {
      businessDetailList = getExistingHiveData.cast<BusinessDetailsHive>();
    }
    businessDetailList.add(BusinessDetailsHive(
      businessName: event.businessDetailsData.businessName,
      businessFirstName: event.businessDetailsData.businessFirstName,
      businessLastName: event.businessDetailsData.businessLastName,
      businessOwnerStreet: event.businessDetailsData.businessOwnerStreet,
      businessOwnerPostCode: event.businessDetailsData.businessOwnerPostCode,
      businessOwnerCity: event.businessDetailsData.businessOwnerCity,
      businessOwnerMobile: event.businessDetailsData.businessOwnerMobile,
      businessOwnerEmail: event.businessDetailsData.businessOwnerEmail,
    ));

    await box.put(HiveInvoiceManagerProperties.TO_INVOICE_MANAGER_DATA_BOX,
        businessDetailList);

    emit(
      InvoiceManagerLoaded(
        businessDetailsDataList: List.from(_businessBox),
        clientDetailsDataList: [],
      ),
    );
  }

  Future<void> _displayInvoiceData(
      InvoiceManagerDisplay event, Emitter<InvoiceManagerState> emit) async {
    emit(InvoiceManagerLoading());
    Box box = await Hive.openBox(
        HiveInvoiceManagerProperties.TO_INVOICE_MANAGER_DATA_BOX);
    List<dynamic>? getExistingHiveData =
        box.get(HiveInvoiceManagerProperties.TO_INVOICE_MANAGER_DATA_KEY);
  }
}
