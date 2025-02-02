// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_details_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BusinessDetailsHiveAdapter extends TypeAdapter<BusinessDetailsHive> {
  @override
  final int typeId = 5;

  @override
  BusinessDetailsHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BusinessDetailsHive(
      businessID: fields[0] as String?,
      businessName: fields[1] as String,
      businessFirstName: fields[2] as String,
      businessLastName: fields[3] as String,
      businessOwnerStreet: fields[4] as String,
      businessOwnerPostCode: fields[5] as String,
      businessOwnerCity: fields[6] as String,
      businessOwnerMobile: fields[7] as String,
      businessOwnerEmail: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BusinessDetailsHive obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.businessID)
      ..writeByte(1)
      ..write(obj.businessName)
      ..writeByte(2)
      ..write(obj.businessFirstName)
      ..writeByte(3)
      ..write(obj.businessLastName)
      ..writeByte(4)
      ..write(obj.businessOwnerStreet)
      ..writeByte(5)
      ..write(obj.businessOwnerPostCode)
      ..writeByte(6)
      ..write(obj.businessOwnerCity)
      ..writeByte(7)
      ..write(obj.businessOwnerMobile)
      ..writeByte(8)
      ..write(obj.businessOwnerEmail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusinessDetailsHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
