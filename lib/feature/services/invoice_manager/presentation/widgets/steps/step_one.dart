import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/widgets/custom_dialog/custom_dialog.dart';
import 'package:business_manager/feature/services/invoice_manager/bloc/invoice_manager_bloc.dart';
import 'package:business_manager/feature/services/invoice_manager/models/business_details_model.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/drop_down_list.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/expansion_tile_wrapper.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/forms/personal_details_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StepOne extends StatefulWidget {
  final List<BusinessDetailsModel> businessesList;
  final BusinessDetailsModel? initialSelectedBusinessDetails;
  final VoidCallback saveBusinessDetails;
  final TextEditingController businessName;
  final void Function(BusinessDetailsModel?) onBusinessSelected;
  final TextEditingController businessOwnerFirstName;
  final TextEditingController businessOwnerLastName;
  final TextEditingController businessOwnerStreet;
  final TextEditingController businessOwnerPostCode;
  final TextEditingController businessOwnerCity;
  final TextEditingController businessOwnerMobile;
  final TextEditingController businessOwnerEmail;
  final TextEditingController businessNiNo;

  StepOne({
    super.key,
    required this.businessesList,
    required this.businessName,
    required this.businessOwnerFirstName,
    required this.businessOwnerLastName,
    required this.businessOwnerStreet,
    required this.businessOwnerPostCode,
    required this.businessOwnerCity,
    required this.businessOwnerMobile,
    required this.businessOwnerEmail,
    required this.initialSelectedBusinessDetails,
    required this.saveBusinessDetails,
    required this.onBusinessSelected,
    required this.businessNiNo,
  });

  @override
  State<StepOne> createState() => _StepOneState();
}

class _StepOneState extends State<StepOne> {
  late BusinessDetailsModel? selectedBusinessDetails;

  @override
  void initState() {
    super.initState();
    selectedBusinessDetails = widget.initialSelectedBusinessDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: Constants.padding16),
        BlocBuilder<InvoiceManagerBloc, InvoiceManagerState>(
          builder: (context, state) {
            if (state is InvoiceManagerLoading) {
              return const CircularProgressIndicator();
            } else if (state is InvoiceManagerLoaded) {
              widget.businessesList.clear();
              widget.businessesList.addAll(state.businessDetailsDataList);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Your Business:",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "Orbitron",
                      fontSize: 18,
                      color: Pallete.colorOne,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  DropDownList<BusinessDetailsModel>(
                    itemList: widget.businessesList,
                    getFullNameDetails: (business) => business.displayName,
                    onValueSelected: (selectedBusiness) {
                      setState(() {
                        selectedBusinessDetails = selectedBusiness!;
                      });
                      widget.onBusinessSelected(selectedBusinessDetails);
                    },
                    onRemoveItem: (business) =>
                        _removeBusiness(context, business),
                  ),
                ],
              );
            } else if (state is InvoiceManagerError) {
              return const Text("Failed to load business data.");
            }
            return Container();
          },
        ),
        const SizedBox(height: Constants.padding16),
        ExpansionTileWrapper(
          title: "Add new Business",
          children: [
            PersonalDetailsInputs(
              isBusinessInputText: true,
              businessName: widget.businessName,
              firstName: widget.businessOwnerFirstName,
              lastName: widget.businessOwnerLastName,
              street: widget.businessOwnerStreet,
              city: widget.businessOwnerCity,
              postCode: widget.businessOwnerPostCode,
              mobile: widget.businessOwnerMobile,
              email: widget.businessOwnerEmail,
              onSaveData: widget.saveBusinessDetails,
              businessNiNo: widget.businessNiNo,
            ),
          ],
        ),
      ],
    );
  }

  void _removeBusiness(BuildContext context, BusinessDetailsModel business) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          title: "Confirm Delete",
          currentItem: business.businessName,
          onConfirm: () {
            context.read<InvoiceManagerBloc>().add(
                  InvoiceManagerRemoveBusiness(
                    businessID: business.businessID!,
                  ),
                );
          },
          question: 'Do you want to delete this: ',
          itemType: ' business?',
        );
      },
    );
  }
}
