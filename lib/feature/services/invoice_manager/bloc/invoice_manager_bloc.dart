import 'package:bloc/bloc.dart';
import 'package:business_manager/core/storage_hive/hive_properites.dart';
import 'package:business_manager/feature/services/invoice_manager/data/hive/bank_hive/bank_details_hive.dart';
import 'package:business_manager/feature/services/invoice_manager/data/hive/business_hive/business_details_hive.dart';
import 'package:business_manager/feature/services/invoice_manager/data/hive/client_hive/client_details_hive.dart';
import 'package:business_manager/feature/services/invoice_manager/data/hive/invoice_items/invoice_items_hive.dart';
import 'package:business_manager/feature/services/invoice_manager/models/bank_details_model.dart';
import 'package:business_manager/feature/services/invoice_manager/models/business_details_model.dart';
import 'package:business_manager/feature/services/invoice_manager/models/client_details_model.dart';
import 'package:business_manager/feature/services/invoice_manager/models/invoice_item_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'invoice_manager_event.dart';

part 'invoice_manager_state.dart';

class InvoiceManagerBloc
    extends Bloc<InvoiceManagerEvent, InvoiceManagerState> {
  final List<BusinessDetailsModel> _businessCurrentList = [];
  final List<ClientDetailsModel> _clientCurrentList = [];
  final List<InvoiceItemModel> _invoiceItemsCurrentList = [];
  final List<BankDetailsModel> _bankCurrentList = [];

  InvoiceManagerBloc() : super(InvoiceManagerInitial()) {
    on<InitialInvoiceManager>(_initializeHive);
    on<InvoiceManagerAddBusiness>(_addBusinessDetails);
    on<InvoiceManagerAddClient>(_addClientDetails);
    on<InvoiceManagerAddItem>(_addItemsDetails);
    on<InvoiceManagerAddBank>(_addBankDetails);
    on<InvoiceManagerRemoveBusiness>(_onRemoveBusiness);
    on<InvoiceManagerRemoveClient>(_onRemoveClient);
    on<InvoiceManagerRemoveItem>(_onRemoveItem);
    on<InvoiceManagerRemoveBank>(_onRemoveBank);
    add(const InitialInvoiceManager());
  }

  Future<void> _initializeHive(
      InitialInvoiceManager event, Emitter<InvoiceManagerState> emit) async {
    emit(InvoiceManagerLoading());
    await Hive.initFlutter();

    Box boxBusiness = await Hive.openBox(
        HiveBusinessDetailsProperties.TO_BUSINESS_DETAILS_DATA_BOX);
    Box boxClient = await Hive.openBox(
        HiveClientDetailsProperties.TO_CLIENT_DETAILS_DATA_BOX);
    Box boxItems = await Hive.openBox(
        HiveInvoiceItemsProperties.TO_INVOICE_ITEMS_DATA_BOX);
    Box boxBankDetails =
        await Hive.openBox(HiveBankDetailsProperties.TO_BANK_DETAILS_DATA_BOX);

    List<dynamic>? getExistingBusinessHiveData = await boxBusiness
        .get(HiveBusinessDetailsProperties.TO_BUSINESS_DETAILS_DATA_KEY);

    List<dynamic>? getExistingClientHiveData = await boxClient
        .get(HiveClientDetailsProperties.TO_CLIENT_DETAILS_DATA_KEY);

    List<dynamic>? getExistingItemsHiveData = await boxItems
        .get(HiveInvoiceItemsProperties.TO_INVOICE_ITEMS_DATA_KEY);

    List<dynamic>? getExistingBankDetailsHiveData = await boxBankDetails
        .get(HiveBankDetailsProperties.TO_BANK_DETAILS_DATA_KEY);

    _businessCurrentList.clear();
    _clientCurrentList.clear();
    _invoiceItemsCurrentList.clear();
    _bankCurrentList.clear();

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
    }

    if (getExistingItemsHiveData != null) {
      _invoiceItemsCurrentList.addAll(
        getExistingItemsHiveData.cast<InvoiceItemsHive>().map(
              (hiveData) => InvoiceItemModel(
                description: hiveData.description,
                quantity: hiveData.quantity,
                itemPrice: hiveData.itemPrice,
                totalItems: hiveData.totalItems,
              ),
            ),
      );
    }

    if (getExistingBankDetailsHiveData != null) {
      _bankCurrentList.addAll(
        getExistingBankDetailsHiveData.cast<BankDetailsHive>().map(
              (hiveData) => BankDetailsModel(
                bankName: hiveData.bankName,
                sortCode: hiveData.sortCode,
                accountNo: hiveData.accountNo,
              ),
            ),
      );
    }

    emit(
      InvoiceManagerLoaded(
        businessDetailsDataList: List.from(_businessCurrentList),
        clientDetailsDataList: List.from(_clientCurrentList),
        invoiceItemsList: List.from(_invoiceItemsCurrentList),
        bankDetailsDataList: List.from(_bankCurrentList),
      ),
    );
    // add(const InvoiceManagerDisplay());
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

    await box.put(
      HiveBusinessDetailsProperties.TO_BUSINESS_DETAILS_DATA_KEY,
      businessDetailList,
    );

    emit(
      InvoiceManagerLoaded(
        businessDetailsDataList: List.from(_businessCurrentList),
        clientDetailsDataList: _clientCurrentList,
        invoiceItemsList: _invoiceItemsCurrentList,
        bankDetailsDataList: _bankCurrentList,
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

    await box.put(
      HiveClientDetailsProperties.TO_CLIENT_DETAILS_DATA_KEY,
      clientDetailsList,
    );

    emit(
      InvoiceManagerLoaded(
        businessDetailsDataList: _businessCurrentList,
        clientDetailsDataList: List.from(_clientCurrentList),
        invoiceItemsList: _invoiceItemsCurrentList,
        bankDetailsDataList: _bankCurrentList,
      ),
    );
  }

  Future<void> _addItemsDetails(
      InvoiceManagerAddItem event, Emitter<InvoiceManagerState> emit) async {
    emit(InvoiceManagerLoading());

    Box boxItems = await Hive.openBox(
        HiveInvoiceItemsProperties.TO_INVOICE_ITEMS_DATA_BOX);
    List<InvoiceItemsHive> invoiceItemsList = [];
    List<dynamic>? getExistingItemsHiveData = await boxItems
        .get(HiveInvoiceItemsProperties.TO_INVOICE_ITEMS_DATA_KEY);

    if (getExistingItemsHiveData != null) {
      invoiceItemsList = getExistingItemsHiveData.cast<InvoiceItemsHive>();
    }

    _invoiceItemsCurrentList.add(event.invoiceItemData);

    invoiceItemsList.add(
      InvoiceItemsHive(
        description: event.invoiceItemData.description,
        quantity: event.invoiceItemData.quantity,
        itemPrice: event.invoiceItemData.itemPrice,
        totalItems: event.invoiceItemData.totalItems,
      ),
    );

    await boxItems.put(
      HiveInvoiceItemsProperties.TO_INVOICE_ITEMS_DATA_KEY,
      invoiceItemsList,
    );

    emit(
      InvoiceManagerLoaded(
        businessDetailsDataList: _businessCurrentList,
        clientDetailsDataList: List.from(_clientCurrentList),
        invoiceItemsList: _invoiceItemsCurrentList,
        bankDetailsDataList: _bankCurrentList,
      ),
    );
  }

  Future<void> _addBankDetails(
      InvoiceManagerAddBank event, Emitter<InvoiceManagerState> emit) async {
    emit(InvoiceManagerLoading());

    Box boxItems =
        await Hive.openBox(HiveBankDetailsProperties.TO_BANK_DETAILS_DATA_BOX);
    List<BankDetailsHive> bankDetailsList = [];
    List<dynamic>? getExistingBankDetailsHiveData =
        await boxItems.get(HiveBankDetailsProperties.TO_BANK_DETAILS_DATA_KEY);

    if (getExistingBankDetailsHiveData != null) {
      bankDetailsList = getExistingBankDetailsHiveData.cast<BankDetailsHive>();
    }

    _bankCurrentList.add(event.bankDetailsData);

    bankDetailsList.add(BankDetailsHive(
        bankName: event.bankDetailsData.bankName,
        sortCode: event.bankDetailsData.sortCode,
        accountNo: event.bankDetailsData.accountNo));

    await boxItems.put(
      HiveBankDetailsProperties.TO_BANK_DETAILS_DATA_KEY,
      bankDetailsList,
    );

    emit(
      InvoiceManagerLoaded(
        businessDetailsDataList: _businessCurrentList,
        clientDetailsDataList: _clientCurrentList,
        invoiceItemsList: _invoiceItemsCurrentList,
        bankDetailsDataList: List.from(_bankCurrentList),
      ),
    );
  }

  Future<void> _onRemoveBusiness(
    InvoiceManagerRemoveBusiness event,
    Emitter<InvoiceManagerState> emit,
  ) async {
    emit(InvoiceManagerLoading());

    final box = await Hive.openBox(
        HiveBusinessDetailsProperties.TO_BUSINESS_DETAILS_DATA_BOX);
    List<dynamic>? existingBusinessList =
        box.get(HiveBusinessDetailsProperties.TO_BUSINESS_DETAILS_DATA_KEY);

    if (existingBusinessList != null) {
      List<BusinessDetailsHive> updatedBusinessList =
          existingBusinessList.cast<BusinessDetailsHive>();
      updatedBusinessList
          .removeWhere((business) => business.businessID == event.businessID);

      await box.put(HiveBusinessDetailsProperties.TO_BUSINESS_DETAILS_DATA_KEY,
          updatedBusinessList);
      _businessCurrentList
          .removeWhere((business) => business.businessID == event.businessID);
    }

    emit(InvoiceManagerLoaded(
      businessDetailsDataList: List.from(_businessCurrentList),
      clientDetailsDataList: _clientCurrentList,
      invoiceItemsList: _invoiceItemsCurrentList,
      bankDetailsDataList: _bankCurrentList,
    ));
  }

  Future<void> _onRemoveClient(
    InvoiceManagerRemoveClient event,
    Emitter<InvoiceManagerState> emit,
  ) async {
    emit(InvoiceManagerLoading());

    final box = await Hive.openBox(
        HiveClientDetailsProperties.TO_CLIENT_DETAILS_DATA_BOX);
    List<dynamic>? existingClientList =
        box.get(HiveClientDetailsProperties.TO_CLIENT_DETAILS_DATA_KEY);

    if (existingClientList != null) {
      List<ClientsDetailsHive> updatedClientList =
          existingClientList.cast<ClientsDetailsHive>();
      updatedClientList
          .removeWhere((client) => client.clientID == event.clientID);

      await box.put(
          HiveClientDetailsProperties.TO_CLIENT_DETAILS_DATA_KEY, updatedClientList);
      _clientCurrentList
          .removeWhere((client) => client.clinetID == event.clientID);
    }

    emit(InvoiceManagerLoaded(
      businessDetailsDataList: _businessCurrentList,
      clientDetailsDataList: List.from(_clientCurrentList),
      invoiceItemsList: _invoiceItemsCurrentList,
      bankDetailsDataList: _bankCurrentList,
    ));
  }

  Future<void> _onRemoveItem(
    InvoiceManagerRemoveItem event,
    Emitter<InvoiceManagerState> emit,
  ) async {
    emit(InvoiceManagerLoading());

    final box = await Hive.openBox(
        HiveInvoiceItemsProperties.TO_INVOICE_ITEMS_DATA_BOX);
    List<dynamic>? existingItemList =
        box.get(HiveInvoiceItemsProperties.TO_INVOICE_ITEMS_DATA_KEY);

    if (existingItemList != null) {
      List<InvoiceItemsHive> updatedItemListList =
          existingItemList.cast<InvoiceItemsHive>();
      updatedItemListList.removeWhere((item) => item.itemID == event.itemID);

      await box.put(
          HiveInvoiceItemsProperties.TO_INVOICE_ITEMS_DATA_KEY, updatedItemListList);
      _invoiceItemsCurrentList
          .removeWhere((item) => item.itemID == event.itemID);
    }

    emit(InvoiceManagerLoaded(
      businessDetailsDataList: _businessCurrentList,
      clientDetailsDataList: _clientCurrentList,
      invoiceItemsList: List.from(_invoiceItemsCurrentList),
      bankDetailsDataList: _bankCurrentList,
    ));
  }

  Future<void> _onRemoveBank(
    InvoiceManagerRemoveBank event,
    Emitter<InvoiceManagerState> emit,
  ) async {
    emit(InvoiceManagerLoading());

    final box =
        await Hive.openBox(HiveBankDetailsProperties.TO_BANK_DETAILS_DATA_BOX);
    List<dynamic>? existingBankList =
        box.get(HiveBankDetailsProperties.TO_BANK_DETAILS_DATA_KEY);

    if (existingBankList != null) {
      List<BankDetailsHive> updatedBankDetailsList =
          existingBankList.cast<BankDetailsHive>();
      updatedBankDetailsList.removeWhere((bank) => bank.bankID == event.bankID);

      await box.put(
          HiveBankDetailsProperties.TO_BANK_DETAILS_DATA_KEY, updatedBankDetailsList);
      _bankCurrentList.removeWhere((bank) => bank.bankID == event.bankID);
    }

    emit(InvoiceManagerLoaded(
      businessDetailsDataList: _businessCurrentList,
      clientDetailsDataList: _clientCurrentList,
      invoiceItemsList: _invoiceItemsCurrentList,
      bankDetailsDataList: List.from(_bankCurrentList),
    ));
  }
}
