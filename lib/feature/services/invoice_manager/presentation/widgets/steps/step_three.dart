import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/feature/services/invoice_manager/models/invoice_item_model.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/drop_down_list.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/expansion_tile_wrapper.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/invoice_items_list_inputs.dart';
import 'package:flutter/material.dart';

class StepThree extends StatefulWidget {
  final  Function(bool isIncrement, int maximumQuantity) updateQuantity;
  final List<InvoiceItemModel> itemsList;
  InvoiceItemModel invoiceItemDetails;
  final int currentItemQuantity;
  final VoidCallback saveInvoiceData;
  final VoidCallback saveNewItem;
  final TextEditingController itemDescription;

  final TextEditingController itemPrice;

  final TextEditingController itemTotalCount;

  StepThree(
      {super.key,
      required this.itemsList,
      required this.invoiceItemDetails,
      required this.updateQuantity,
      required this.currentItemQuantity,
      required this.saveInvoiceData,
      required this.itemDescription,
      required this.itemPrice,
      required this.itemTotalCount,
      required this.saveNewItem});

  @override
  State<StepThree> createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                "Your Items:",
                style: TextStyle(
                  fontFamily: "Orbitron",
                  fontSize: 18,
                  color: Pallete.colorFive,
                ),
              ),
            ),
            Expanded(
              child: DropDownList<InvoiceItemModel>(
                itemList: widget.itemsList,
                getFullNameDetails: (invoice) => invoice.displayName,
                onValueSelected: (selectedItem) {
                  setState(() {
                    widget.invoiceItemDetails = selectedItem!;
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
              onPressed: () => widget.updateQuantity,
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => widget.updateQuantity,
            ),
            Text("Quantity: ${widget.currentItemQuantity.toString()}"),
            const Spacer(),
            ElevatedButton(
              onPressed: widget.saveInvoiceData,
              child: const Text(
                "Add to Invoice",
                style: TextStyle(
                  color: Pallete.whiteColor,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Pallete.colorFive),
              ),
            ),
          ],
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
