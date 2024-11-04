import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/widgets/custom_app_bar/custom_app_bar.dart';
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

import 'package:flutter/material.dart';

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
  InvoiceItemModel _invoiceItemDetails = const InvoiceItemModel(
    description: "",
    quantity: "",
    itemPrice: "",
    totalItems: "",
  );

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.whiteColor,
      appBar: CustomAppBar(
        title: "Invoice Service",
        onMenuPressed: () {},
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Constants.padding16),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    "Your Business:    ",
                    style: TextStyle(
                      fontFamily: "Jaro",
                      fontSize: 20,
                      color: Pallete.colorSix,
                    ),
                  ),
                  Expanded(
                    child: DropDownList<BusinessDetailsModel>(
                      itemList: _businessesList,
                      getFullNameDetails: (business) => business.displayName,
                      onValueSelected: (selectedBusiness) {
                        setState(() {
                          _selectedBusinessDetails = selectedBusiness!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Constants.padding16),
              ExpansionTileWrapper(
                title: "Add new Business Details",
                children: [
                  PersonalDetailsInputs(
                    firstName: _businessOwnerFirstName,
                    lastName: _businessOwnerLastName,
                    street: _businessOwnerStreet,
                    city: _businessOwnerCity,
                    postCode: _businessOwnerPostCode,
                    mobile: _businessOwnerMobile,
                    email: _businessOwnerEmail,
                    onSaveData: _saveBusinessDetails,
                  ),
                ],
              ),
              const SizedBox(height: Constants.padding16),
              Row(
                children: [
                  const Text(
                    "Your Clients:        ",
                    style: TextStyle(
                      fontFamily: "Jaro",
                      fontSize: 20,
                      color: Pallete.colorSix,
                    ),
                  ),
                  Expanded(
                    child: DropDownList<ClientDetailsModel>(
                      itemList: _clientsList,
                      getFullNameDetails: (client) => client.displayName,
                      onValueSelected: (selectedClient) {
                        setState(() {
                          _selectedClientDetails = selectedClient!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Constants.padding16),
              ExpansionTileWrapper(
                title: "Add new Client Details",
                children: [
                  PersonalDetailsInputs(
                    firstName: _clientFirstName,
                    lastName: _clientLastName,
                    street: _clientStreet,
                    city: _clientCity,
                    postCode: _clientPostCode,
                    mobile: _clientMobile,
                    email: _clientEmail,
                    onSaveData: _saveClientDetails,
                  ),
                ],
              ),
              const SizedBox(height: Constants.padding16),
              Row(
                children: [
                  const Text(
                    "Your Items:           ",
                    style: TextStyle(
                      fontFamily: "Jaro",
                      fontSize: 20,
                      color: Pallete.colorSix,
                    ),
                  ),
                  Expanded(
                    child: DropDownList<InvoiceItemModel>(
                      itemList: _itemsList,
                      getFullNameDetails: (invoice) => invoice.displayName,
                      onValueSelected: (selectedItem) {
                        setState(() {
                          _invoiceItemDetails = selectedItem!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Constants.padding16),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => updateQuantity(
                      false,
                      int.tryParse(_invoiceItemDetails.totalItems) ?? 10,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => updateQuantity(
                      true,
                      int.tryParse(_invoiceItemDetails.totalItems) ?? 10,
                    ),
                  ),
                  Text("Quantity: ${_currentItemQuantity.toString()}"),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: _saveInvoiceData,
                    child: const Text(
                      "Add to Invoice",
                      style: TextStyle(
                        color: Pallete.whiteColor,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Pallete.colorFive),
                    ),
                  ),
                ],
              ),
              ExpansionTileWrapper(
                title: "Add New Item",
                children: [
                  InvoiceItemsListInputs(
                    onSaveData: _saveNewItem,
                    description: _itemDescription,
                    itemPrice: _itemPrice,
                    totalItems: _itemTotalCount,
                  ),
                ],
              ),
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
              const SizedBox(height: Constants.padding16 * 10),
            ],
          ),
        ),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          // Positioned(
          //   bottom: 20,
          //   left: 20,
          //   child: InvoiceScreenLeftButton(onItemCliked: _onLeftItemsClicked),
          // ),
          Positioned(
            bottom: 20,
            right: 0,
            child: InvoiceCustomFloatingButton(
              createInvoiceData: _createInvoiceOneData,
            ),
          ),
        ],
      ),
    );
  }

  void _saveBusinessDetails() {
    final newBusiness = BusinessDetailsModel(
      businessFirstName: _businessOwnerFirstName.text,
      businessLastName: _businessOwnerLastName.text,
      businessOwnerStreet: _businessOwnerStreet.text,
      businessOwnerPostCode: _businessOwnerPostCode.text,
      businessOwnerCity: _businessOwnerCity.text,
      businessOwnerMobile: _businessOwnerMobile.text,
      businessOwnerEmail: _businessOwnerEmail.text,
    );

    setState(() {
      if (!_businessesList.contains(newBusiness)) {
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
    if (_invoiceItemDetails.description.isEmpty) return;

    final updatedItem = InvoiceItemModel(
      description: _invoiceItemDetails.description,
      quantity: _currentItemQuantity.toString(),
      itemPrice: _invoiceItemDetails.itemPrice,
      totalItems:
          (double.parse(_invoiceItemDetails.itemPrice) * _currentItemQuantity)
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

  void _onLeftItemsClicked(int index) {
    switch (index) {
      case 0:
        setState(() {});
        break;
      case 1:
        setState(() {});
        break;
      case 2:
      default:
        setState(() {});
        break;
    }
  }
}
