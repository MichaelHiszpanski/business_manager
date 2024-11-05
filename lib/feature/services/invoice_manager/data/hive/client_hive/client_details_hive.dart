
import 'package:business_manager/core/storage_hive/hive_properites.dart';
import 'package:hive/hive.dart';

part 'client_details_hive.g.dart';

@HiveType(typeId: HiveProperties.clientDetailsID)
class ClientsDetailsHive {

  @HiveField(0)
  final String clientFirstName;

  @HiveField(1)
  final String clientLastName;

  @HiveField(2)
  final String clientOwnerStreet;

  @HiveField(3)
  final String clientOwnerPostCode;

  @HiveField(4)
  final String clientOwnerCity;

  @HiveField(5)
  final String clientOwnerMobile;

  @HiveField(6)
  final String clientOwnerEmail;

  ClientsDetailsHive({
    required this.clientFirstName,
    required this.clientLastName,
    required this.clientOwnerStreet,
    required this.clientOwnerPostCode,
    required this.clientOwnerCity,
    required this.clientOwnerMobile,
    required this.clientOwnerEmail,
  });

  @override
  String toString() {
    return 'BusinessDetailsHive( businessFirstName: $clientFirstName, '
        'businessLastName: $clientLastName, businessOwnerStreet: $clientOwnerStreet, '
        'businessOwnerPostCode: $clientOwnerPostCode, businessOwnerCity: $clientOwnerCity, '
        'businessOwnerMobile: $clientOwnerMobile, businessOwnerEmail: $clientOwnerEmail)';
  }
}
