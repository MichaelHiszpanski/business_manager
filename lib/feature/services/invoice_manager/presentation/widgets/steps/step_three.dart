import 'package:business_manager/core/theme/app_font_family.dart';
import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/feature/services/invoice_manager/bloc/invoice_manager_bloc.dart';
import 'package:business_manager/feature/services/invoice_manager/models/invoice_item_model.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/drop_down_list.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/expansion_tile_wrapper.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/invoice_items_list_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StepThree extends StatefulWidget {
  final Function(bool isIncrement, int maximumQuantity) updateQuantity;
  final List<InvoiceItemModel> itemsList;
  final InvoiceItemModel? initialSelectedItemDetails;
  final void Function(InvoiceItemModel?) onItemSelected;
  final int currentItemQuantity;
  final VoidCallback saveInvoiceData;
  final VoidCallback saveNewItem;
  final TextEditingController itemDescription;

  final TextEditingController itemPrice;

  final TextEditingController itemTotalCount;

  StepThree({
    super.key,
    required this.itemsList,
    required this.initialSelectedItemDetails,
    required this.onItemSelected,
    required this.updateQuantity,
    required this.currentItemQuantity,
    required this.saveInvoiceData,
    required this.itemDescription,
    required this.itemPrice,
    required this.itemTotalCount,
    required this.saveNewItem,
  });

  @override
  State<StepThree> createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree> {
  late InvoiceItemModel? selectedItemDetails;

  @override
  void initState() {
    super.initState();
    selectedItemDetails = widget.initialSelectedItemDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: Constants.padding16),
        BlocBuilder<InvoiceManagerBloc, InvoiceManagerState>(
          builder: (context, state) {
            if (state is InvoiceManagerLoading) {
              return const CircularProgressIndicator();
            } else if (state is InvoiceManagerLoaded) {
              widget.itemsList.clear();
              widget.itemsList.addAll(state.invoiceItemsList);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Your Items:",
                    style: TextStyle(
                      fontFamily: "Orbitron",
                      fontSize: 18,
                      color: Pallete.colorFive,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  DropDownList<InvoiceItemModel>(
                    itemList: widget.itemsList,
                    getFullNameDetails: (invoice) => invoice.displayName,
                    onValueSelected: (selectedItem) {
                      setState(() {
                        selectedItemDetails = selectedItem!;
                      });
                      widget.onItemSelected(selectedItemDetails);
                    },
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
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () => widget.updateQuantity(
                  false, int.tryParse(selectedItemDetails!.totalItems) ?? 10),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: "Add",
              onPressed: () => widget.updateQuantity(
                true,
                int.tryParse(selectedItemDetails!.totalItems) ?? 10,
              ),
            ),
            Text("Quantity: ${widget.currentItemQuantity.toString()}"),
            const Spacer(),
          ],
        ),
        const SizedBox(height: Constants.padding16),
        ElevatedButton(
          onPressed: widget.saveInvoiceData,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Pallete.colorFive),
          ),
          child: const Text(
            "Add Item to Invoice",
            style: TextStyle(
                color: Pallete.whiteColor,
                fontWeight: FontWeight.w600,
                fontFamily: AppFontFamily.suse,
                fontSize: 18),
          ),
        ),
        const SizedBox(height: Constants.padding16),
        ExpansionTileWrapper(
          title: "Add New Item",
          children: [
            InvoiceItemsListInputs(
              onSaveData: widget.saveNewItem,
              description: widget.itemDescription,
              itemPrice: widget.itemPrice,
              totalItems: widget.itemTotalCount,
            ),
          ],
        ),
        const SizedBox(height: Constants.padding16),
      ],
    );
  }
}
