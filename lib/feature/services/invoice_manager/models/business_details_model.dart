import 'package:equatable/equatable.dart';

class BusinessDetailsModel extends Equatable {
  final String businessName;
  final String businessFirstName;
  final String businessLastName;
  final String businessOwnerStreet;
  final String businessOwnerPostCode;
  final String businessOwnerCity;
  final String businessOwnerMobile;
  final String businessOwnerEmail;

  const BusinessDetailsModel({
    required this.businessName,
    required this.businessFirstName,
    required this.businessLastName,
    required this.businessOwnerStreet,
    required this.businessOwnerPostCode,
    required this.businessOwnerCity,
    required this.businessOwnerMobile,
    required this.businessOwnerEmail,
  });

  String get displayName => "$businessName";

  @override
  List<Object?> get props => [
        businessName,
        businessFirstName,
        businessLastName,
        businessOwnerStreet,
        businessOwnerCity,
        businessOwnerPostCode,
        businessOwnerMobile,
        businessOwnerEmail,
      ];
}
