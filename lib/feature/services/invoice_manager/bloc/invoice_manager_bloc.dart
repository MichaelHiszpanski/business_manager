import 'package:bloc/bloc.dart';
import 'package:business_manager/core/storage_hive/hive_properites.dart';
import 'package:business_manager/feature/services/invoice_manager/data/hive/business_hive/business_details_hive.dart';
import 'package:business_manager/feature/services/invoice_manager/data/hive/client_hive/client_details_hive.dart';
import 'package:business_manager/feature/services/invoice_manager/models/business_details_model.dart';
import 'package:business_manager/feature/services/invoice_manager/models/client_details_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'invoice_manager_event.dart';

part 'invoice_manager_state.dart';

class InvoiceManagerBloc
    extends Bloc<InvoiceManagerEvent, InvoiceManagerState> {
  final List<BusinessDetailsModel> _businessCurrentList = [];
  final List<ClientDetailsModel> _clientCurrentList = [];

  InvoiceManagerBloc() : super(InvoiceManagerInitial()) {
    on<InitialInvoiceManager>(_initializeHive);
    on<InvoiceManagerAddBusiness>(_addBusinessDetails);
    on<InvoiceManagerAddClient>(_addClientDetails);
    on<InvoiceManagerDisplay>(_displayInvoiceData);
    add(const InitialInvoiceManager());
  }

  Future<void> _initializeHive(
      InitialInvoiceManager event, Emitter<InvoiceManagerState> emit) async {
    await Hive.initFlutter();
    Box boxBusiness = await Hive.openBox(
        HiveBusinessDetailsProperties.TO_BUSINESS_DETAILS_DATA_BOX);
    final List<dynamic>? getExistingBusinessHiveData = await boxBusiness
        .get(HiveBusinessDetailsProperties.TO_BUSINESS_DETAILS_DATA_KEY);
    Box boxClient = await Hive.openBox(
        HiveClientDetailsProperties.TO_CLIENT_DETAILS_DATA_BOX);
    List<dynamic>? getExistingClientHiveData = await boxClient
        .get(HiveClientDetailsProperties.TO_CLIENT_DETAILS_DATA_KEY);

    if (getExistingBusinessHiveData != null) {
      _businessCurrentList.addAll(
        getExistingBusinessHiveData
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
          clientDetailsDataList: _clientCurrentList,
        ),
      );
    }
    if (getExistingClientHiveData != null) {
      _clientCurrentList.addAll(
        getExistingClientHiveData.cast<ClientsDetailsHive>().map(
              (hiveData) => ClientDetailsModel(
                clientFirstName: hiveData.clientFirstName,
                clientLastName: hiveData.clientLastName,
                clientStreet: hiveData.clientOwnerStreet,
                clientPostCode: hiveData.clientOwnerPostCode,
                clientCity: hiveData.clientOwnerCity,
                clientEmail: hiveData.clientOwnerEmail,
                clientMobile: hiveData.clientOwnerMobile,
              ),
            ),
      );

      emit(
        InvoiceManagerLoaded(
          businessDetailsDataList: _businessCurrentList,
          clientDetailsDataList: List.from(_clientCurrentList),
        ),
      );
    }
    add(const InvoiceManagerDisplay());
  }

  Future<void> _addBusinessDetails(InvoiceManagerAddBusiness event,
      Emitter<InvoiceManagerState> emit) async {
    emit(InvoiceManagerLoading());

    Box box = await Hive.openBox(
        HiveBusinessDetailsProperties.TO_BUSINESS_DETAILS_DATA_BOX);
    List<dynamic>? getExistingHiveData = await box
        .get(HiveBusinessDetailsProperties.TO_BUSINESS_DETAILS_DATA_KEY);
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

    await box.put(HiveBusinessDetailsProperties.TO_BUSINESS_DETAILS_DATA_KEY,
        businessDetailList);

    emit(
      InvoiceManagerLoaded(
        businessDetailsDataList: List.from(_businessCurrentList),
        clientDetailsDataList: _clientCurrentList,
      ),
    );
  }

  Future<void> _addClientDetails(
      InvoiceManagerAddClient event, Emitter<InvoiceManagerState> emit) async {
    emit(InvoiceManagerLoading());

    Box box = await Hive.openBox(
        HiveClientDetailsProperties.TO_CLIENT_DETAILS_DATA_BOX);
    List<dynamic>? getExistingHiveData =
        await box.get(HiveClientDetailsProperties.TO_CLIENT_DETAILS_DATA_KEY);
    List<ClientsDetailsHive> clientDetailsList = [];

    if (getExistingHiveData != null) {
      clientDetailsList = getExistingHiveData.cast<ClientsDetailsHive>();
    }

    _clientCurrentList.add(event.clientDetailsData);

    clientDetailsList.add(ClientsDetailsHive(
      clientFirstName: event.clientDetailsData.clientFirstName,
      clientLastName: event.clientDetailsData.clientLastName,
      clientOwnerStreet: event.clientDetailsData.clientStreet,
      clientOwnerPostCode: event.clientDetailsData.clientPostCode,
      clientOwnerCity: event.clientDetailsData.clientCity,
      clientOwnerMobile: event.clientDetailsData.clientMobile,
      clientOwnerEmail: event.clientDetailsData.clientEmail,
    ));

    await box.put(HiveClientDetailsProperties.TO_CLIENT_DETAILS_DATA_KEY,
        clientDetailsList);

    emit(
      InvoiceManagerLoaded(
        businessDetailsDataList: _businessCurrentList,
        clientDetailsDataList: List.from(_clientCurrentList),
      ),
    );
  }

  Future<void> _displayInvoiceData(
      InvoiceManagerDisplay event, Emitter<InvoiceManagerState> emit) async {
    emit(InvoiceManagerLoading());
    Box box = await Hive.openBox(
        HiveBusinessDetailsProperties.TO_BUSINESS_DETAILS_DATA_BOX);
    final List<dynamic>? getExistingHiveData = await box
        .get(HiveBusinessDetailsProperties.TO_BUSINESS_DETAILS_DATA_KEY);

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
