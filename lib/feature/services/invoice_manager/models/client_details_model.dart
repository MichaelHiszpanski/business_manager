import 'package:business_manager/feature/services/invoice_manager/models/invoice_item_model.dart';
import 'package:equatable/equatable.dart';

class ClientDetailsModel extends Equatable {
  final String clientFirstName;
  final String clientLastName;
  final String clientStreet;
  final String clientPostCode;
  final String clientCity;
  final String clientMobile;
  final String clientEmail;

  const ClientDetailsModel({
    required this.clientFirstName,
    required this.clientLastName,
    required this.clientStreet,
    required this.clientPostCode,
    required this.clientCity,
    required this.clientEmail,
    required this.clientMobile,
  });

  String get displayName => "$clientFirstName $clientLastName";

  @override
  List<Object?> get props => [
        clientFirstName,
        clientLastName,
        clientStreet,
        clientPostCode,
        clientCity,
        clientMobile,
        clientEmail,
      ];
}
