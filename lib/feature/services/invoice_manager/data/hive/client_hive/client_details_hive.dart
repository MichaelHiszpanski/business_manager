import 'package:business_manager/core/storage_hive/hive_properites.dart';
import 'package:hive/hive.dart';

part 'client_details_hive.g.dart';

@HiveType(typeId: HiveProperties.clientDetailsID)
class ClientsDetailsHive {
  @HiveField(HiveClientDetailsProperties.clientFirstName)
  final String clientFirstName;

  @HiveField(HiveClientDetailsProperties.clientLastName)
  final String clientLastName;

  @HiveField(HiveClientDetailsProperties.clientOwnerStreet)
  final String clientOwnerStreet;

  @HiveField(HiveClientDetailsProperties.clientOwnerPostCode)
  final String clientOwnerPostCode;

  @HiveField(HiveClientDetailsProperties.clientOwnerCity)
  final String clientOwnerCity;

  @HiveField(HiveClientDetailsProperties.clientOwnerMobile)
  final String clientOwnerMobile;

  @HiveField(HiveClientDetailsProperties.clientOwnerEmail)
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
