import 'package:equatable/equatable.dart';

class BankDetailsModel extends Equatable {
  String? bankID;
  final String bankName;
  final String sortCode;
  final String accountNo;

  BankDetailsModel({
    this.bankID,
    required this.bankName,
    required this.sortCode,
    required this.accountNo,
  });

  String get displayName => "$bankName ";

  @override
  @override
  List<Object?> get props => [
        bankID,
        bankName,
        sortCode,
        accountNo,
      ];
}
