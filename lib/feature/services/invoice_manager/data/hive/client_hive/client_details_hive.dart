
import 'package:business_manager/core/storage_hive/hive_properites.dart';
import 'package:hive/hive.dart';

part 'client_details_hive.g.dart';

@HiveType(typeId: HiveProperties.clientDetailsID)
class ClientsDetailsHive {

  @HiveField(0)
  final String businessFirstName;

  @HiveField(1)
  final String businessLastName;

  @HiveField(2)
  final String businessOwnerStreet;

  @HiveField(3)
  final String businessOwnerPostCode;

  @HiveField(4)
  final String businessOwnerCity;

  @HiveField(5)
  final String businessOwnerMobile;

  @HiveField(6)
  final String businessOwnerEmail;

  ClientsDetailsHive({
    required this.businessFirstName,
    required this.businessLastName,
    required this.businessOwnerStreet,
    required this.businessOwnerPostCode,
    required this.businessOwnerCity,
    required this.businessOwnerMobile,
    required this.businessOwnerEmail,
  });

  @override
  String toString() {
    return 'BusinessDetailsHive( businessFirstName: $businessFirstName, '
        'businessLastName: $businessLastName, businessOwnerStreet: $businessOwnerStreet, '
        'businessOwnerPostCode: $businessOwnerPostCode, businessOwnerCity: $businessOwnerCity, '
        'businessOwnerMobile: $businessOwnerMobile, businessOwnerEmail: $businessOwnerEmail)';
  }
}
