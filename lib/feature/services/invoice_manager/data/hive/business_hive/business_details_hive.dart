
import 'package:business_manager/core/storage_hive/hive_properites.dart';
import 'package:hive/hive.dart';

part 'business_details_hive.g.dart';

@HiveType(typeId: HiveProperties.businessDetailsID)
class BusinessDetailsHive {
  @HiveField(0)
  final String businessName;

  @HiveField(1)
  final String businessFirstName;

  @HiveField(2)
  final String businessLastName;

  @HiveField(3)
  final String businessOwnerStreet;

  @HiveField(4)
  final String businessOwnerPostCode;

  @HiveField(5)
  final String businessOwnerCity;

  @HiveField(6)
  final String businessOwnerMobile;

  @HiveField(7)
  final String businessOwnerEmail;

  BusinessDetailsHive({
    required this.businessName,
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
    return 'BusinessDetailsHive(businessName: $businessName, businessFirstName: $businessFirstName, '
        'businessLastName: $businessLastName, businessOwnerStreet: $businessOwnerStreet, '
        'businessOwnerPostCode: $businessOwnerPostCode, businessOwnerCity: $businessOwnerCity, '
        'businessOwnerMobile: $businessOwnerMobile, businessOwnerEmail: $businessOwnerEmail)';
  }
}
