import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/feature/services/invoice_manager/bloc/invoice_manager_bloc.dart';
import 'package:business_manager/feature/services/invoice_manager/models/bank_details_model.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/drop_down_list.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/expansion_tile_wrapper.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/forms/invoice_bank_details_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StepFour extends StatefulWidget {
  final List<BankDetailsModel> bankList;
  final VoidCallback saveBankDetails;
  final TextEditingController bankName;
  final TextEditingController sortCode;
  final TextEditingController accountNo;
  final BankDetailsModel? initialSelectedBankDetails;
  final void Function(BankDetailsModel?) onBankSelected;

  const StepFour({
    super.key,
    required this.bankList,
    required this.saveBankDetails,
    required this.bankName,
    required this.sortCode,
    required this.accountNo,
    required this.onBankSelected,
    required this.initialSelectedBankDetails,
  });

  @override
  State<StepFour> createState() => _StepFourState();
}

class _StepFourState extends State<StepFour> {
  late BankDetailsModel? selectedBankDetails;

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
              widget.bankList.clear();
              widget.bankList.addAll(state.bankDetailsDataList);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Your Account:",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "Orbitron",
                      fontSize: 18,
                      color: Pallete.colorFive,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  DropDownList<BankDetailsModel>(
                    itemList: widget.bankList,
                    getFullNameDetails: (bank) => bank.bankName,
                    onValueSelected: (selectedBank) {
                      setState(() {
                        selectedBankDetails = selectedBank!;
                      });
                      widget.onBankSelected(selectedBankDetails);
                    },
                  ),
                ],
              );
            } else if (state is InvoiceManagerError) {
              return const Text("Failed to load bank data.");
            }
            return Container();
          },
        ),
        const SizedBox(height: Constants.padding16),
        ExpansionTileWrapper(
          title: "New Account",
          children: [
            InvoiceBankDetailsInputs(
              onSaveData: widget.saveBankDetails,
              bankName: widget.bankName,
              sortCode: widget.sortCode,
              accountNo: widget.accountNo,
            ),
          ],
        ),
      ],
    );
  }
}
