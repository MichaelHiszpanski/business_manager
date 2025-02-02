import 'package:equatable/equatable.dart';

class InvoiceItemModel extends Equatable {
  String? itemID;
  final String description;
  final String quantity;
  final String itemPrice;
  final String totalItems;

  InvoiceItemModel({
    this.itemID,
    required this.description,
    required this.quantity,
    required this.itemPrice,
    required this.totalItems,
  });

  String get displayName => "$description ";

  @override
  @override
  List<Object?> get props => [
        itemID,
        description,
        quantity,
        itemPrice,
        totalItems,
      ];
}
