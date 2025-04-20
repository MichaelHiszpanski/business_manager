import 'package:business_manager/core/storage_hive/hive_properites.dart';
import 'package:hive/hive.dart';

part 'business_details_hive.g.dart';

@HiveType(typeId: HiveProperties.businessDetailsID)
class BusinessDetailsHive {
  @HiveField(HiveBusinessDetailsProperties.businessID)
  final String? businessID;

  @HiveField(HiveBusinessDetailsProperties.businessName)
  final String businessName;

  @HiveField(HiveBusinessDetailsProperties.businessFirstName)
  final String businessFirstName;

  @HiveField(HiveBusinessDetailsProperties.businessLastName)
  final String businessLastName;

  @HiveField(HiveBusinessDetailsProperties.businessOwnerStreet)
  final String businessOwnerStreet;

  @HiveField(HiveBusinessDetailsProperties.businessOwnerPostCode)
  final String businessOwnerPostCode;

  @HiveField(HiveBusinessDetailsProperties.businessOwnerCity)
  final String businessOwnerCity;

  @HiveField(HiveBusinessDetailsProperties.businessOwnerMobile)
  final String businessOwnerMobile;

  @HiveField(HiveBusinessDetailsProperties.businessOwnerEmail)
  final String businessOwnerEmail;

  @HiveField(HiveBusinessDetailsProperties.businessNiNo)
  final String businessNiNo;

  BusinessDetailsHive({
    this.businessID,
    required this.businessName,
    required this.businessFirstName,
    required this.businessLastName,
    required this.businessOwnerStreet,
    required this.businessOwnerPostCode,
    required this.businessOwnerCity,
    required this.businessOwnerMobile,
    required this.businessOwnerEmail,
    required this.businessNiNo,
  });

  @override
  String toString() {
    return 'BusinessDetailsHive(businessID : $businessID, businessName: $businessName, businessFirstName: $businessFirstName, '
        'businessLastName: $businessLastName, businessOwnerStreet: $businessOwnerStreet, '
        'businessOwnerPostCode: $businessOwnerPostCode, businessOwnerCity: $businessOwnerCity, '
        'businessOwnerMobile: $businessOwnerMobile, businessOwnerEmail: $businessOwnerEmail, businessNino $businessNiNo)';
  }
}
