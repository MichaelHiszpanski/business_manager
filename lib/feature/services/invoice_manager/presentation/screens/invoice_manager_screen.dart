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
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/invoice_inputs.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/invoice_screen_left_button.dart';

import 'package:flutter/material.dart';

class InvoiceManagerScreen extends StatefulWidget {
  const InvoiceManagerScreen({super.key});

  @override
  State<InvoiceManagerScreen> createState() => _InvoiceManagerScreenState();
}

class _InvoiceManagerScreenState extends State<InvoiceManagerScreen> {
  final List<BusinessDetailsModel> _businessesList = [];
  BusinessDetailsModel _selectedBusinessDetails = const BusinessDetailsModel(
    businessFirstName: "",
    businessLastName: "",
    businessOwnerStreet: "",
    businessOwnerPostCode: "",
    businessOwnerCity: "",
    businessOwnerMobile: "",
    businessOwnerEmail: "",
  );
  final TextEditingController _businessOwnerFirstName = TextEditingController();
  final TextEditingController _businessOwnerLastName = TextEditingController();
  final TextEditingController _businessOwnerStreet = TextEditingController();
  final TextEditingController _businessOwnerPostCode = TextEditingController();
  final TextEditingController _businessOwnerCity = TextEditingController();
  final TextEditingController _businessOwnerMobile = TextEditingController();
  final TextEditingController _businessOwnerEmail = TextEditingController();

  InvoiceOneModel _createInvoiceData() {
    return InvoiceOneModel(
      invoiceDateTimeCreated: DateTime.now(),
      invoiceNumber: "00123",
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
          clientFirstName: "NONE",
          clientLastName: "NONE",
          clientStreet: "NONE",
          clientPostCode: "NONE",
          clientCity: "NONE",
          clientEmail: "NONE",
          clientMobile: "NONE"),
      invoiceItemsList: [
        InvoiceItemModel(
            description: "Service/Product 1",
            quantity: "1",
            itemPrice: "\£100.00",
            totalItems: "\£100.00"),
        InvoiceItemModel(
            description: "Service/Product 2",
            quantity: "2",
            itemPrice: "\£50.00",
            totalItems: "\£100.00"),
      ],
      thankYouMessage: "Thank you for your business!",
      paymentDueMessage: "Payment is due within 15 days.",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.colorThree,
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
            ],
          ),
        ),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Positioned(
            bottom: 20,
            left: 20,
            child: InvoiceScreenLeftButton(onItemCliked: _onLeftItemsClicked),
          ),
          Positioned(
            bottom: 20,
            right: 0,
            child: InvoiceCustomFloatingButton(
              createInvoiceData: _createInvoiceData,
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
