import 'package:business_manager/core/theme/app_font_family.dart';
import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/feature/services/invoice_manager/bloc/invoice_manager_bloc.dart';
import 'package:business_manager/feature/services/invoice_manager/models/client_details_model.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/drop_down_list.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/expansion_tile_wrapper.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/personal_details_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StepTwo extends StatefulWidget {
  final List<ClientDetailsModel> clientsList;
  final VoidCallback saveClientDetails;
  ClientDetailsModel selectedClientDetails;
  final TextEditingController clientFirstName;

  final TextEditingController clientLastName;

  final TextEditingController clientStreet;
  final TextEditingController clientPostCode;

  final TextEditingController clientCity;

  final TextEditingController clientMobile;
  final TextEditingController clientEmail;

  StepTwo(
      {super.key,
      required this.clientsList,
      required this.clientFirstName,
      required this.clientLastName,
      required this.clientStreet,
      required this.clientPostCode,
      required this.clientCity,
      required this.clientMobile,
      required this.clientEmail,
      required this.selectedClientDetails,
      required this.saveClientDetails});

  @override
  State<StepTwo> createState() => _StepTwoState();
}

class _StepTwoState extends State<StepTwo> {
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

              return Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Your Clients:",
                      style: TextStyle(
                        fontFamily: AppFontFamily.orbitron,
                        fontSize: 18,
                        color: Pallete.colorFive,
                      ),
                    ),
                  ),
                  Expanded(
                    child: DropDownList<ClientDetailsModel>(
                      itemList: widget.clientsList,
                      getFullNameDetails: (client) => client.displayName,
                      onValueSelected: (selectedClient) {
                        setState(() {
                          widget.selectedClientDetails = selectedClient!;
                        });
                      },
                    ),
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
          title: "Add new Client Details",
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
}
