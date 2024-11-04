import 'package:equatable/equatable.dart';

class InvoiceItemModel extends Equatable {
  final String description;
  final String quantity;
  final String itemPrice;
  final String totalItems;

  const InvoiceItemModel({
    required this.description,
    required this.quantity,
    required this.itemPrice,
    required this.totalItems,
  });

  String get displayName => "$description ";

  @override
  @override
  List<Object?> get props => [
        description,
        quantity,
        itemPrice,
        totalItems,
      ];
}
