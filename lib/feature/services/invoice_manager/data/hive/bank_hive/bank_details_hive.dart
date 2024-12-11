import 'package:business_manager/core/storage_hive/hive_properites.dart';
import 'package:hive/hive.dart';

part 'bank_details_hive.g.dart';

@HiveType(typeId: HiveProperties.bankDetailsID)
class BankDetailsHive {
  @HiveField(HiveBankDetailsProperties.bankName)
  final String bankName;

  @HiveField(HiveBankDetailsProperties.sortCode)
  final String sortCode;

  @HiveField(HiveBankDetailsProperties.accountNo)
  final String accountNo;

  BankDetailsHive({
    required this.bankName,
    required this.sortCode,
    required this.accountNo,
  });

  @override
  String toString() {
    return 'BusinessDetailsHive(bankName: $bankName, sortCode: $sortCode, '
        'accountNo: $accountNo';
  }
}
