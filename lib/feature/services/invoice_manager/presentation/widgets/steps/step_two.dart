import 'package:business_manager/core/theme/app_font_family.dart';
import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/widgets/custom_dialog/custom_dialog.dart';
import 'package:business_manager/feature/services/invoice_manager/bloc/invoice_manager_bloc.dart';
import 'package:business_manager/feature/services/invoice_manager/models/client_details_model.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/drop_down_list.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/expansion_tile_wrapper.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/forms/personal_details_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StepTwo extends StatefulWidget {
  final List<ClientDetailsModel> clientsList;
  final VoidCallback saveClientDetails;
  final ClientDetailsModel? initialSelectedClientDetails;
  final void Function(ClientDetailsModel?) onClientSelected;
  final TextEditingController clientFirstName;
  final TextEditingController clientLastName;
  final TextEditingController clientStreet;
  final TextEditingController clientPostCode;
  final TextEditingController clientCity;
  final TextEditingController clientMobile;
  final TextEditingController clientEmail;

  StepTwo({
    super.key,
    required this.clientsList,
    required this.clientFirstName,
    required this.clientLastName,
    required this.clientStreet,
    required this.clientPostCode,
    required this.clientCity,
    required this.clientMobile,
    required this.clientEmail,
    required this.initialSelectedClientDetails,
    required this.saveClientDetails,
    required this.onClientSelected,
  });

  @override
  State<StepTwo> createState() => _StepTwoState();
}

class _StepTwoState extends State<StepTwo> {
  late ClientDetailsModel? selectedClientDetails;

  @override
  void initState() {
    super.initState();
    selectedClientDetails = widget.initialSelectedClientDetails;
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
              widget.clientsList.clear();
              widget.clientsList.addAll(state.clientDetailsDataList);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Your Clients:",
                    style: TextStyle(
                      fontFamily: AppFontFamily.orbitron,
                      fontSize: 18,
                      color: Pallete.colorOne,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  DropDownList<ClientDetailsModel>(
                    itemList: widget.clientsList,
                    getFullNameDetails: (client) => client.displayName,
                    onValueSelected: (selectedClient) {
                      setState(() {
                        selectedClientDetails = selectedClient!;
                      });
                      widget.onClientSelected(selectedClientDetails);
                    },
                    onRemoveItem: (client) => _removeClient(context, client),
                  ),
                ],
              );
            } else if (state is InvoiceManagerError) {
              return const Text("Failed to load clients data.");
            }
            return Container();
          },
        ),
        const SizedBox(height: Constants.padding16),
        ExpansionTileWrapper(
          title: "Add new Client",
          children: [
            PersonalDetailsInputs(
              firstName: widget.clientFirstName,
              lastName: widget.clientLastName,
              street: widget.clientStreet,
              city: widget.clientCity,
              postCode: widget.clientPostCode,
              mobile: widget.clientMobile,
              email: widget.clientEmail,
              onSaveData: widget.saveClientDetails,
            ),
          ],
        ),
        // const SizedBox(height: Constants.padding16 * 10),
      ],
    );
  }

  void _removeClient(BuildContext context, ClientDetailsModel client) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          title: "Confirm Delete",
          currentItem: "${client.clientFirstName} ${client.clientLastName}",
          onConfirm: () {
            context.read<InvoiceManagerBloc>().add(
                  InvoiceManagerRemoveClient(
                    clientID: client.clinetID!,
                  ),
                );
          },
          question: 'Do you want to delete this: ',
          itemType: ' client?',
        );
      },
    );
  }
}
