import 'package:business_manager/core/theme/app_font_family.dart';
import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
import 'package:business_manager/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:business_manager/feature/services/invoice_manager/bloc/invoice_manager_bloc.dart';
import 'package:business_manager/feature/services/invoice_manager/models/bank_details_model.dart';
import 'package:business_manager/feature/services/invoice_manager/models/business_details_model.dart';
import 'package:business_manager/feature/services/invoice_manager/models/client_details_model.dart';
import 'package:business_manager/feature/services/invoice_manager/models/invoice_item_model.dart';
import 'package:business_manager/feature/services/invoice_manager/models/invoice_one_model.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/expansion_tile_wrapper.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/forms/invoice_bank_details_inputs.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/invoice_custom_floating_button.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/forms/invoice_details_inputs.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/steps/step_four.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/steps/step_one.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/steps/step_three.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/steps/step_two.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class InvoiceManagerScreen extends StatefulWidget {
  const InvoiceManagerScreen({super.key});

  @override
  State<InvoiceManagerScreen> createState() => _InvoiceManagerScreenState();
}

class _InvoiceManagerScreenState extends State<InvoiceManagerScreen> {
  final List<BusinessDetailsModel> _businessesList = [];
  final List<ClientDetailsModel> _clientsList = [];
  final List<InvoiceItemModel> _itemsList = [];
  final List<InvoiceItemModel> _invoiceAddedItemsList = [];
  final List<BankDetailsModel> _bankList = [];
  double _currentItemQuantity = 0;
  int _currentStep = 0;
  int _totalSteps = 4;
  final uuid = const Uuid();

  BusinessDetailsModel _selectedBusinessDetails = BusinessDetailsModel(
    businessName: "",
    businessFirstName: "",
    businessLastName: "",
    businessOwnerStreet: "",
    businessOwnerPostCode: "",
    businessOwnerCity: "",
    businessOwnerMobile: "",
    businessOwnerEmail: "",
  );
  ClientDetailsModel _selectedClientDetails = ClientDetailsModel(
    clientFirstName: "",
    clientLastName: "",
    clientStreet: "",
    clientPostCode: "",
    clientCity: "",
    clientEmail: "",
    clientMobile: "",
  );
  InvoiceItemModel _selectedItemDetails = InvoiceItemModel(
    description: "",
    quantity: "",
    itemPrice: "",
    totalItems: "",
  );

  BankDetailsModel _selectedBankDetails =
      BankDetailsModel(bankName: "", sortCode: "", accountNo: "");

  final TextEditingController _businessName = TextEditingController();
  final TextEditingController _businessOwnerFirstName = TextEditingController();
  final TextEditingController _businessOwnerLastName = TextEditingController();
  final TextEditingController _businessOwnerStreet = TextEditingController();
  final TextEditingController _businessOwnerPostCode = TextEditingController();
  final TextEditingController _businessOwnerCity = TextEditingController();
  final TextEditingController _businessOwnerMobile = TextEditingController();
  final TextEditingController _businessOwnerEmail = TextEditingController();

  final TextEditingController _clientFirstName = TextEditingController();
  final TextEditingController _clientLastName = TextEditingController();
  final TextEditingController _clientStreet = TextEditingController();
  final TextEditingController _clientPostCode = TextEditingController();
  final TextEditingController _clientCity = TextEditingController();
  final TextEditingController _clientMobile = TextEditingController();
  final TextEditingController _clientEmail = TextEditingController();

  final TextEditingController _invoiceNumber = TextEditingController();
  final TextEditingController _thankYouMessage = TextEditingController();
  final TextEditingController _paymentDueDays = TextEditingController();

  final TextEditingController _itemDescription = TextEditingController();
  final TextEditingController _itemPrice = TextEditingController();
  final TextEditingController _itemQuantity = TextEditingController();
  final TextEditingController _itemTotalCount = TextEditingController();

  final TextEditingController _bankName = TextEditingController();
  final TextEditingController _sortCode = TextEditingController();
  final TextEditingController _accountNo = TextEditingController();

  DateTime? _invoiceDateCreated;

  bool _isFormValid = false;

  InvoiceOneModel _createInvoiceOneData() {
    return InvoiceOneModel(
      invoiceDateTimeCreated: _invoiceDateCreated ?? DateTime.now(),
      invoiceNumber: _invoiceNumber.text,
      businessDetailsModel: BusinessDetailsModel(
        businessName: _selectedBusinessDetails.businessName,
        businessFirstName: _selectedBusinessDetails.businessFirstName,
        businessLastName: _selectedBusinessDetails.businessLastName,
        businessOwnerStreet: _selectedBusinessDetails.businessOwnerStreet,
        businessOwnerPostCode: _selectedBusinessDetails.businessOwnerPostCode,
        businessOwnerCity: _selectedBusinessDetails.businessOwnerCity,
        businessOwnerMobile: _selectedBusinessDetails.businessOwnerMobile,
        businessOwnerEmail: _selectedBusinessDetails.businessOwnerEmail,
      ),
      clientDetailsModel: ClientDetailsModel(
        clientFirstName: _selectedClientDetails.clientFirstName,
        clientLastName: _selectedClientDetails.clientLastName,
        clientStreet: _selectedClientDetails.clientStreet,
        clientPostCode: _selectedClientDetails.clientPostCode,
        clientCity: _selectedClientDetails.clientCity,
        clientEmail: _selectedClientDetails.clientMobile,
        clientMobile: _selectedClientDetails.clientEmail,
      ),
      bankDetailsModel: BankDetailsModel(
        bankName: _selectedBankDetails.bankName,
        sortCode: _selectedBankDetails.sortCode,
        accountNo: _selectedBankDetails.accountNo,
      ),
      invoiceItemsList: _invoiceAddedItemsList,
      thankYouMessage: _thankYouMessage.text,
      paymentDueDays: "Payment is due within ${_paymentDueDays.text} days.",
      subTotalPrice: calculateSubTotalPrice(),
    );
  }

  double calculateSubTotalPrice() {
    return _invoiceAddedItemsList.fold(0.0, (total, item) {
      final price = double.tryParse(item.itemPrice) ?? 0.0;
      final quantity = double.tryParse(item.quantity) ?? 0.0;
      return total + (price * quantity);
    });
  }

  void _onFormValidated(bool isValid) {
    setState(() {
      _isFormValid = isValid;
    });
  }

  void _onDateSelected(DateTime selectedDate) {
    setState(() {
      _invoiceDateCreated = selectedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.whiteColor,
      appBar: CustomAppBar(
        title: "Invoice Service",
        onMenuPressed: () {},
      ),
      body: Container(
        height: double.infinity,
        // decoration: BoxDecoration(color: Pallete.colorTwo.withOpacity(0.25)),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Pallete.colorSix.withOpacity(0.55),
              // Pallete.colorOne.withOpacity(0.75),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Constants.padding16),
          child: Stepper(
            steps: [
              Step(
                title: const SizedBox.shrink(),
                isActive: _currentStep == 0,
                content: StepOne(
                  businessesList: _businessesList,
                  businessName: _businessName,
                  businessOwnerFirstName: _businessOwnerFirstName,
                  businessOwnerLastName: _businessOwnerLastName,
                  businessOwnerStreet: _businessOwnerStreet,
                  businessOwnerPostCode: _businessOwnerPostCode,
                  businessOwnerCity: _businessOwnerCity,
                  businessOwnerMobile: _businessOwnerMobile,
                  businessOwnerEmail: _businessOwnerEmail,
                  initialSelectedBusinessDetails: _selectedBusinessDetails,
                  saveBusinessDetails: _saveBusinessDetails,
                  onBusinessSelected: (BusinessDetailsModel? selectedBusiness) {
                    setState(() {
                      _selectedBusinessDetails = selectedBusiness!;
                    });
                  },
                ),
                stepStyle: _stepStyle(),
              ),
              Step(
                title: const SizedBox.shrink(),
                isActive: _currentStep == 1,
                content: StepTwo(
                  clientsList: _clientsList,
                  clientFirstName: _clientFirstName,
                  clientLastName: _clientLastName,
                  clientStreet: _clientStreet,
                  clientPostCode: _clientPostCode,
                  clientCity: _clientCity,
                  clientMobile: _clientMobile,
                  clientEmail: _clientEmail,
                  initialSelectedClientDetails: _selectedClientDetails,
                  saveClientDetails: _saveClientDetails,
                  onClientSelected: (ClientDetailsModel? selectedClient) {
                    setState(() {
                      _selectedClientDetails = selectedClient!;
                    });
                  },
                ),
                stepStyle: _stepStyle(),
              ),
              Step(
                title: const SizedBox.shrink(),
                isActive: _currentStep == 2,
                content: StepThree(
                  itemsList: _itemsList,
                  initialSelectedItemDetails: _selectedItemDetails,
                  updateQuantity: _updateQuantity,
                  currentItemQuantity: _currentItemQuantity,
                  saveInvoiceData: _saveInvoiceData,
                  itemDescription: _itemDescription,
                  itemPrice: _itemPrice,
                  itemTotalCount: _itemTotalCount,
                  saveNewItem: _saveNewItem,
                  onItemSelected: (InvoiceItemModel? selectedItem) {
                    setState(() {
                      _selectedItemDetails = selectedItem!;
                    });
                  },
                  invoiceAddedItemsList: _invoiceAddedItemsList,
                ),
                stepStyle: _stepStyle(),
              ),
              Step(
                title: const SizedBox.shrink(),
                isActive: _currentStep == 3,
                content: StepFour(
                    bankList: _bankList,
                    saveBankDetails: _saveBankDetails,
                    bankName: _bankName,
                    sortCode: _sortCode,
                    accountNo: _accountNo,
                    onBankSelected: (BankDetailsModel? selectedItem) {
                      setState(() {
                        _selectedBankDetails = selectedItem!;
                      });
                    },
                    initialSelectedBankDetails: _selectedBankDetails),
                stepStyle: _stepStyle(),
              ),
              Step(
                title: const SizedBox.shrink(),
                isActive: _currentStep == 4,
                content: Column(
                  children: [
                    const SizedBox(height: Constants.padding16),
                    // ExpansionTileWrapper(
                    //   title: "Invoice Details",
                    //   children: [
                    //     InvoiceDetailsInputs(
                    //       invoiceNumber: _invoiceNumber,
                    //       thankYouMessage: _thankYouMessage,
                    //       paymentDueDays: _paymentDueDays,
                    //       onSaveData: () {},
                    //       onFormValidated: _onFormValidated,
                    //       onDateSelected: _onDateSelected,
                    //     ),
                    //   ],
                    // ),
                    InvoiceDetailsInputs(
                      invoiceNumber: _invoiceNumber,
                      thankYouMessage: _thankYouMessage,
                      paymentDueDays: _paymentDueDays,
                      onSaveData: () {},
                      onFormValidated: _onFormValidated,
                      onDateSelected: _onDateSelected,
                    ),
                    const SizedBox(height: Constants.padding8),
                  ],
                ),
                stepStyle: _stepStyle(),
              ),
            ],
            onStepTapped: (int newIndex) {
              setState(() {
                _currentStep = newIndex;
              });
            },
            currentStep: _currentStep,
            onStepContinue: () {
              if (_currentStep != _totalSteps) {
                setState(() {
                  _currentStep += 1;
                });
              }
            },
            onStepCancel: () {
              if (_currentStep != 0) {
                setState(() {
                  _currentStep -= 1;
                });
              }
            },
            //  type: StepperType.horizontal,
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              return Padding(
                padding: const EdgeInsets.only(top: Constants.padding24),
                child: Row(
                  children: <Widget>[
                    if (_currentStep == _totalSteps) ...[
                      const SizedBox.shrink(),
                    ] else ...[
                      Container(
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Pallete.colorSeven, Pallete.colorSix],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Pallete.colorFive.withOpacity(0.45),
                                offset: const Offset(0, 4),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ],
                            borderRadius:
                                BorderRadius.circular(Constants.padding24)),
                        child: ElevatedButton(
                          onPressed: details.onStepContinue,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(Constants.padding24),
                            ),
                          ),
                          child: Text(
                            'Continue',
                            style: context.text.bodyMedium,
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(width: 2 * Constants.padding16),
                    if (_currentStep > 0)
                      Container(
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Pallete.colorSix, Pallete.colorSeven],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Pallete.colorFive.withOpacity(0.45),
                                offset: const Offset(0, 4),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ],
                            borderRadius:
                                BorderRadius.circular(Constants.padding24)),
                        child: ElevatedButton(
                          onPressed: details.onStepCancel,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(Constants.padding24),
                            ),
                          ),
                          child: const Text(
                            'Back',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFontFamily.orbitron,
                              color: Pallete.colorOne,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Positioned(
            top: MediaQuery.of(context).padding.top +
                MediaQuery.of(context).size.height * 0.15,
            right: 20,
            child: (_currentStep == _totalSteps && _isFormValid)
                ? InvoiceCustomFloatingButton(
                    createInvoiceData: _createInvoiceOneData,
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  void _saveBusinessDetails() {
    final newBusiness = BusinessDetailsModel(
      businessID: uuid.v4(),
      businessName: _businessName.text,
      businessFirstName: _businessOwnerFirstName.text,
      businessLastName: _businessOwnerLastName.text,
      businessOwnerStreet: _businessOwnerStreet.text,
      businessOwnerPostCode: _businessOwnerPostCode.text,
      businessOwnerCity: _businessOwnerCity.text,
      businessOwnerMobile: _businessOwnerMobile.text,
      businessOwnerEmail: _businessOwnerEmail.text,
    );

    context
        .read<InvoiceManagerBloc>()
        .add(InvoiceManagerAddBusiness(businessDetailsData: newBusiness));

    setState(() {
      if (!_businessesList.contains(newBusiness) &&
          (_businessesList
              .every((item) => item.businessName != _businessName.text))) {
        _businessesList.add(newBusiness);
        _businessName.clear();
        _businessOwnerFirstName.clear();
        _businessOwnerLastName.clear();
        _businessOwnerStreet.clear();
        _businessOwnerPostCode.clear();
        _businessOwnerCity.clear();
        _businessOwnerMobile.clear();
        _businessOwnerEmail.clear();
      }
    });
  }

  void _saveClientDetails() {
    final newClient = ClientDetailsModel(
      clinetID: uuid.v4(),
      clientFirstName: _clientFirstName.text,
      clientLastName: _clientLastName.text,
      clientStreet: _clientStreet.text,
      clientPostCode: _clientPostCode.text,
      clientCity: _clientCity.text,
      clientEmail: _clientEmail.text,
      clientMobile: _clientMobile.text,
    );
    context
        .read<InvoiceManagerBloc>()
        .add(InvoiceManagerAddClient(clientDetailsData: newClient));
    setState(() {
      if (!_clientsList.contains(newClient)) {
        _clientsList.add(newClient);
        _clientFirstName.clear();
        _clientLastName.clear();
        _clientStreet.clear();
        _clientPostCode.clear();
        _clientCity.clear();
        _clientMobile.clear();
        _clientEmail.clear();
      }
    });
  }

  void _saveBankDetails() {
    final newBank = BankDetailsModel(
        bankID: uuid.v4(),
        bankName: _bankName.text,
        sortCode: _sortCode.text,
        accountNo: _accountNo.text);
    context
        .read<InvoiceManagerBloc>()
        .add(InvoiceManagerAddBank(bankDetailsData: newBank));
    setState(() {
      if (!_bankList.contains(newBank)) {
        _bankList.add(newBank);
        _bankName.clear();
        _sortCode.clear();
        _accountNo.clear();
      }
    });
  }

  void _saveNewItem() {
    final newItem = InvoiceItemModel(
        itemID: uuid.v4(),
        description: _itemDescription.text,
        quantity: _itemQuantity.text,
        itemPrice: _itemPrice.text,
        totalItems: _itemTotalCount.text);
    context
        .read<InvoiceManagerBloc>()
        .add(InvoiceManagerAddItem(invoiceItemData: newItem));
    setState(() {
      if (!_itemsList.any((item) => item == newItem)) {
        _itemsList.add(newItem);
        _itemDescription.clear();
        _itemQuantity.clear();
        _itemPrice.clear();
        _itemTotalCount.clear();
      }
    });
  }

  void _saveInvoiceData() {
    if (_selectedItemDetails.description.isEmpty) return;

    final updatedItem = InvoiceItemModel(
      description: _selectedItemDetails.description,
      quantity: _currentItemQuantity.toString(),
      itemPrice: _selectedItemDetails.itemPrice,
      totalItems:
          (double.parse(_selectedItemDetails.itemPrice) * _currentItemQuantity)
              .toStringAsFixed(2),
    );

    setState(() {
      if (!_invoiceAddedItemsList
          .any((item) => item.description == updatedItem.description)) {
        _invoiceAddedItemsList.add(updatedItem);
      }

      _currentItemQuantity = 0;
    });
  }

  void _updateQuantity(bool isIncrement, int maximumQuantity,
      {bool resetQuantity = false}) {
    setState(() {
      if (resetQuantity) {
        _currentItemQuantity = 0;
      } else if (isIncrement) {
        if (_currentItemQuantity < maximumQuantity) {
          _currentItemQuantity += 0.5;
        }
      } else {
        if (_currentItemQuantity > 0) {
          _currentItemQuantity -= 0.5;
        }
      }
    });
  }

  StepStyle _stepStyle() {
    return StepStyle(
        connectorColor: Pallete.colorSeven,
        gradient: const LinearGradient(
          colors: [Pallete.colorSeven, Pallete.colorSix],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        indexStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: AppFontFamily.orbitron,
        ),
        connectorThickness: 2.0,
        border: Border.all(
          color: Colors.black,
          width: 0.5,
        ),
        boxShadow: BoxShadow(
          color: Pallete.colorFive.withOpacity(0.45),
          offset: const Offset(0, 4),
          blurRadius: 8,
          spreadRadius: 1,
        ));
  }
}
