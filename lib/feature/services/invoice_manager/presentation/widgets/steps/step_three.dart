import 'package:business_manager/core/theme/app_font_family.dart';
import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
import 'package:business_manager/feature/services/invoice_manager/bloc/invoice_manager_bloc.dart';
import 'package:business_manager/feature/services/invoice_manager/models/invoice_item_model.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/drop_down_list.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/expansion_tile_wrapper.dart';
import 'package:business_manager/feature/services/invoice_manager/presentation/widgets/forms/invoice_items_list_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StepThree extends StatefulWidget {
  final Function(bool isIncrement, int maximumQuantity, {bool resetQuantity})
      updateQuantity;
  final List<InvoiceItemModel> itemsList;
  final InvoiceItemModel? initialSelectedItemDetails;
  final void Function(InvoiceItemModel?) onItemSelected;
  final double currentItemQuantity;
  final VoidCallback saveInvoiceData;
  final VoidCallback saveNewItem;
  final TextEditingController itemDescription;
  final TextEditingController itemPrice;
  final TextEditingController itemTotalCount;
  final List<InvoiceItemModel> invoiceAddedItemsList;

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
    required this.invoiceAddedItemsList,
  });

  @override
  State<StepThree> createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree> {
  late InvoiceItemModel? selectedItemDetails;

  // final List<InvoiceItemModel> _itemsAddedToInvoiceList = [];

  @override
  void initState() {
    super.initState();
    selectedItemDetails = widget.initialSelectedItemDetails;
  }

  void _removeItem(InvoiceItemModel item) {
    context
        .read<InvoiceManagerBloc>()
        .add(InvoiceManagerRemoveItem(itemID: item.itemID ?? item.displayName));
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
                      color: Pallete.colorOne,
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
                    onRemoveItem: _removeItem,
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
            Text(
              "Quantity: ${widget.currentItemQuantity.toString()}",
              style: const TextStyle(
                color: Pallete.colorFive,
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: Constants.padding16),
        ElevatedButton(
          onPressed: widget.saveInvoiceData,
          //     () {
          //   _addItemToItemsAddedToInvoiceList();
          //   widget.saveInvoiceData();
          //
          // },
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
        if (widget.invoiceAddedItemsList.isNotEmpty) ...[
          const Text(
            "Items Added to Invoice:",
            style: TextStyle(
              fontFamily: "Orbitron",
              fontSize: 18,
              color: Pallete.colorOne,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: Constants.padding8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Pallete.colorSix.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Pallete.colorFive, width: 1),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.invoiceAddedItemsList.length,
              itemBuilder: (context, index) {
                final item = widget.invoiceAddedItemsList[index];
                return _itemList(index, item);
              },
            ),
          ),
          const SizedBox(height: Constants.padding16),
        ],
        // const SizedBox(height: Constants.padding16),
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

  Widget _itemList(
    int index,
    InvoiceItemModel item,
  ) {
    return ListTile(
      title: Text(
        item.description,
        style: context.text.titleSmall,
      ),
      subtitle: Text(
        "Total: ${item.quantity} x ${item.itemPrice} Price: ${(double.parse(item.quantity) * double.parse(item.itemPrice)).toStringAsFixed(2)}",
        style: context.text.labelLarge,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Pallete.colorFive),
        onPressed: () {
          setState(() {
            widget.invoiceAddedItemsList.removeAt(index);
          });
        },
      ),
    );
  }
}
