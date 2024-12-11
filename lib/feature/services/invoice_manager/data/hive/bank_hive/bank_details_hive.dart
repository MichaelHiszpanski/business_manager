import 'package:business_manager/core/storage_hive/hive_properites.dart';
import 'package:hive/hive.dart';

part 'bank_details_hive.g.dart';

@HiveType(typeId: HiveProperties.bankDetailsID)
class BankDetailsHive {
  @HiveField(HiveBankDetailsProperties.bankName)
  final String description;

  @HiveField(HiveBankDetailsProperties.sortCode)
  final String quantity;

  @HiveField(HiveBankDetailsProperties.accountNo)
  final String itemPrice;

  BankDetailsHive({
    required this.description,
    required this.quantity,
    required this.itemPrice,
  });

  @override
  String toString() {
    return 'BusinessDetailsHive(description: $description, quantity: $quantity, '
        'itemPrice: $itemPrice';
  }
}
