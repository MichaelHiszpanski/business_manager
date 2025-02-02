import 'package:business_manager/core/storage_hive/hive_properites.dart';
import 'package:hive/hive.dart';

part 'invoice_items_hive.g.dart';

@HiveType(typeId: HiveProperties.invoiceItemsID)
class InvoiceItemsHive {
  @HiveField(HiveInvoiceItemsProperties.itemID)
  String? itemID;

  @HiveField(HiveInvoiceItemsProperties.description)
  final String description;

  @HiveField(HiveInvoiceItemsProperties.quantity)
  final String quantity;

  @HiveField(HiveInvoiceItemsProperties.itemPrice)
  final String itemPrice;

  @HiveField(HiveInvoiceItemsProperties.totalItems)
  final String totalItems;

  InvoiceItemsHive({
    this.itemID,
    required this.description,
    required this.quantity,
    required this.itemPrice,
    required this.totalItems,
  });

  @override
  String toString() {
    return 'InvoiceItemsHive(itemID: $itemID, description: $description, quantity: $quantity, '
        'itemPrice: $itemPrice, totalItems: $totalItems)';
  }
}
