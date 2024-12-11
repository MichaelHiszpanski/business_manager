import 'package:business_manager/core/theme/app_font_family.dart';
import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:business_manager/feature/services/invoice_manager/bloc/invoice_manager_bloc.dart';
import 'package:business_manager/feature/services/invoice_manager/models/business_details_model.dart';
import 'package:business_manager/feature/services/invoice_manager/models/client_details_model.dart';
import 'package:business_manager/feature/services/invoice_manager/models/invoice_item_model.dart';
import 'package:business_manager/feature/services/invoice_manager/models/invoice_one_model.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/drop_down_list.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/expansion_tile_wrapper.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/invoice_custom_floating_button.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/invoice_details_inputs.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/invoice_items_list_inputs.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/personal_details_inputs.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/invoice_screen_left_button.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/steps/step_one.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/steps/step_three.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/steps/step_two.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  int _currentItemQuantity = 0;

  BusinessDetailsModel _selectedBusinessDetails = const BusinessDetailsModel(
    businessName: "",
    businessFirstName: "",
    businessLastName: "",
    businessOwnerStreet: "",
    businessOwnerPostCode: "",
    businessOwnerCity: "",
    businessOwnerMobile: "",
    businessOwnerEmail: "",
  );
  ClientDetailsModel _selectedClientDetails = const ClientDetailsModel(
    clientFirstName: "",
    clientLastName: "",
    clientStreet: "",
    clientPostCode: "",
    clientCity: "",
    clientEmail: "",
    clientMobile: "",
  );
  InvoiceItemModel _selectedItemDetails = const InvoiceItemModel(
    description: "",
    quantity: "",
    itemPrice: "",
    totalItems: "",
  );

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

  InvoiceOneModel _createInvoiceOneData() {
    return InvoiceOneModel(
      invoiceDateTimeCreated: DateTime.now(),
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
      invoiceItemsList: _invoiceAddedItemsList,
      thankYouMessage: _thankYouMessage.text,
      paymentDueDays: "Payment is due within ${_paymentDueDays.text} days.",
      subTotalPrice: calculateSubTotalPrice(),
    );
  }

  double calculateSubTotalPrice() {
    return _invoiceAddedItemsList.fold(0.0, (total, item) {
      final price = double.tryParse(item.itemPrice) ?? 0.0;
      final quantity = int.tryParse(item.quantity) ?? 0;
      return total + (price * quantity);
    });
  }

  int _currentStep = 0;

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
        decoration: BoxDecoration(color: Pallete.colorTwo.withOpacity(0.25)),
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
              // Step(
              //   title: SizedBox.shrink(),
              //   isActive: _currentStep == 2,
              //   content:
              Step(
                title: const SizedBox.shrink(),
                isActive: _currentStep == 2,
                content: StepThree(
                  itemsList: _itemsList,
                  initialSelectedItemDetails: _selectedItemDetails,
                  updateQuantity: updateQuantity,
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
                  //     Column(
                  //   children: [
                  //     Row(
                  //       children: [
                  //         const Expanded(
                  //           child: Text(
                  //             "Your Items:",
                  //             style: TextStyle(
                  //               fontFamily: "Orbitron",
                  //               fontSize: 18,
                  //               color: Pallete.colorFive,
                  //             ),
                  //           ),
                  //         ),
                  //         Expanded(
                  //           child: DropDownList<InvoiceItemModel>(
                  //             itemList: _itemsList,
                  //             getFullNameDetails: (invoice) =>
                  //                 invoice.displayName,
                  //             onValueSelected: (selectedItem) {
                  //               setState(() {
                  //                 _invoiceItemDetails = selectedItem!;
                  //               });
                  //             },
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     const SizedBox(height: Constants.padding16),
                  //     Row(
                  //       children: [
                  //         IconButton(
                  //           icon: const Icon(Icons.remove),
                  //           onPressed: () => updateQuantity(
                  //             false,
                  //             int.tryParse(_invoiceItemDetails.totalItems) ?? 10,
                  //           ),
                  //         ),
                  //         IconButton(
                  //           icon: const Icon(Icons.add),
                  //           onPressed: () => updateQuantity(
                  //             true,
                  //             int.tryParse(_invoiceItemDetails.totalItems) ?? 10,
                  //           ),
                  //         ),
                  //         Text("Quantity: ${_currentItemQuantity.toString()}"),
                  //         const Spacer(),
                  //         ElevatedButton(
                  //           onPressed: _saveInvoiceData,
                  //           child: const Text(
                  //             "Add to Invoice",
                  //             style: TextStyle(
                  //               color: Pallete.whiteColor,
                  //             ),
                  //           ),
                  //           style: ButtonStyle(
                  //             backgroundColor:
                  //                 WidgetStateProperty.all(Pallete.colorFive),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     const SizedBox(height: Constants.padding16),
                  //     ExpansionTileWrapper(
                  //       title: "Add New Item",
                  //       children: [
                  //         InvoiceItemsListInputs(
                  //           onSaveData: _saveNewItem,
                  //           description: _itemDescription,
                  //           itemPrice: _itemPrice,
                  //           totalItems: _itemTotalCount,
                  //         ),
                  //       ],
                  //     ),
                  //     const SizedBox(height: Constants.padding16),
                  //   ],
                  // ),
                ),
                stepStyle: _stepStyle(),
              ),
              Step(
                title: const SizedBox.shrink(),
                isActive: _currentStep == 3,
                content: Column(
                  children: [
                    const SizedBox(height: Constants.padding16),
                    ExpansionTileWrapper(
                      title: "Invoice Details",
                      children: [
                        InvoiceDetailsInputs(
                          invoiceNumber: _invoiceNumber,
                          thankYouMessage: _thankYouMessage,
                          paymentDueDays: _paymentDueDays,
                          onSaveData: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: Constants.padding16),
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
              if (_currentStep != 3) {
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
                    if (_currentStep == 3) ...[
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
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFontFamily.orbitron,
                              color: Colors.white,
                            ),
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
            bottom: 60,
            right: 0,
            child: _currentStep == 3
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

  void _saveNewItem() {
    final newItem = InvoiceItemModel(
        description: _itemDescription.text,
        quantity: _itemQuantity.text,
        itemPrice: _itemPrice.text,
        totalItems: _itemTotalCount.text);

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

    context
        .read<InvoiceManagerBloc>()
        .add(InvoiceManagerAddItem(invoiceItemData: updatedItem));
  }

  void updateQuantity(bool isIncrement, int maximumQuantity) {
    setState(() {
      if (isIncrement) {
        if (_currentItemQuantity < maximumQuantity) {
          _currentItemQuantity++;
        }
      } else {
        if (_currentItemQuantity > 0) {
          _currentItemQuantity--;
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

// Step(
// title: SizedBox.shrink(),
// isActive: _currentStep == 2,
// content: StepThree(
// itemsList: _itemsList,
// invoiceItemDetails: _invoiceItemDetails,
// updateQuantity:
//
// updateQuantity(
// true,
// int.tryParse(_invoiceItemDetails.totalItems) ?? 10,
// ),
//
// currentItemQuantity: _currentItemQuantity,
// saveInvoiceData: _saveInvoiceData,
// itemDescription: _itemDescription,
// itemPrice: _itemPrice,
// itemTotalCount: _itemTotalCount,
// saveNewItem: _saveNewItem,
// ),
// stepStyle: _stepStyle(),
// ),
