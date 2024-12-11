import 'package:equatable/equatable.dart';

class BankDetailsModel extends Equatable {
  final String bankName;
  final String sortCode;
  final String accountNo;

  const BankDetailsModel({
    required this.bankName,
    required this.sortCode,
    required this.accountNo,
  });

  String get displayName => "$bankName ";

  @override
  @override
  List<Object?> get props => [
        bankName,
        sortCode,
        accountNo,
      ];
}
