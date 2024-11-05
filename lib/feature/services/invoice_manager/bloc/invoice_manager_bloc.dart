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
  final List<BusinessDetailsModel> _businessCurrentList = [];

  InvoiceManagerBloc() : super(InvoiceManagerInitial()) {
    on<InitialInvoiceManager>(_initializeHive);
    on<InvoiceManagerAddBusiness>(_addBusinessDetails);
    on<InvoiceManagerDisplay>(_displayInvoiceData);
    add(const InitialInvoiceManager());
  }

  Future<void> _initializeHive(
      InitialInvoiceManager event, Emitter<InvoiceManagerState> emit) async {
    await Hive.initFlutter();
    Box box = await Hive.openBox(
        HiveInvoiceManagerProperties.TO_INVOICE_MANAGER_DATA_BOX);
    final List<dynamic>? getExistingHiveData =
        await box.get(HiveInvoiceManagerProperties.TO_INVOICE_MANAGER_DATA_KEY);
    if (getExistingHiveData != null) {
      _businessCurrentList.addAll(
        getExistingHiveData
            .cast<BusinessDetailsHive>()
            .map((hiveData) => BusinessDetailsModel(
                  businessName: hiveData.businessName,
                  businessFirstName: hiveData.businessFirstName,
                  businessLastName: hiveData.businessLastName,
                  businessOwnerStreet: hiveData.businessOwnerStreet,
                  businessOwnerPostCode: hiveData.businessOwnerPostCode,
                  businessOwnerCity: hiveData.businessOwnerCity,
                  businessOwnerMobile: hiveData.businessOwnerMobile,
                  businessOwnerEmail: hiveData.businessOwnerEmail,
                )),
      );

      emit(
        InvoiceManagerLoaded(
          businessDetailsDataList: List.from(_businessCurrentList),
          clientDetailsDataList: [],
        ),
      );
    }
    add(const InvoiceManagerDisplay());
  }

  Future<void> _addBusinessDetails(InvoiceManagerAddBusiness event,
      Emitter<InvoiceManagerState> emit) async {
    emit(InvoiceManagerLoading());

    Box box = await Hive.openBox(
        HiveInvoiceManagerProperties.TO_INVOICE_MANAGER_DATA_BOX);
    List<dynamic>? getExistingHiveData =
        await box.get(HiveInvoiceManagerProperties.TO_INVOICE_MANAGER_DATA_KEY);
    List<BusinessDetailsHive> businessDetailList = [];

    if (getExistingHiveData != null) {
      businessDetailList = getExistingHiveData.cast<BusinessDetailsHive>();
    }

    _businessCurrentList.add(event.businessDetailsData);

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

    await box.put(HiveInvoiceManagerProperties.TO_INVOICE_MANAGER_DATA_KEY,
        businessDetailList);

    emit(
      InvoiceManagerLoaded(
        businessDetailsDataList: List.from(_businessCurrentList),
        clientDetailsDataList: [],
      ),
    );
  }

  Future<void> _displayInvoiceData(
      InvoiceManagerDisplay event, Emitter<InvoiceManagerState> emit) async {
    emit(InvoiceManagerLoading());
    Box box = await Hive.openBox(
        HiveInvoiceManagerProperties.TO_INVOICE_MANAGER_DATA_BOX);
    final List<dynamic>? getExistingHiveData =
        await box.get(HiveInvoiceManagerProperties.TO_INVOICE_MANAGER_DATA_KEY);

    if (getExistingHiveData != null) {
      final List<BusinessDetailsModel> businessDetailsDataList =
          getExistingHiveData.map((dynamic hiveData) {
        return BusinessDetailsModel(
          businessName: hiveData.businessName,
          businessFirstName: hiveData.businessFirstName,
          businessLastName: hiveData.businessLastName,
          businessOwnerStreet: hiveData.businessOwnerStreet,
          businessOwnerPostCode: hiveData.businessOwnerPostCode,
          businessOwnerCity: hiveData.businessOwnerCity,
          businessOwnerMobile: hiveData.businessOwnerMobile,
          businessOwnerEmail: hiveData.businessOwnerEmail,
        );
      }).toList();

      _businessCurrentList
        ..clear()
        ..addAll(businessDetailsDataList);
      emit(
        InvoiceManagerLoaded(
          businessDetailsDataList: List.from(_businessCurrentList),
          clientDetailsDataList: [],
        ),
      );
    } else {
      emit(InvoiceManagerError());
      _businessCurrentList.clear();
    }
  }
}
