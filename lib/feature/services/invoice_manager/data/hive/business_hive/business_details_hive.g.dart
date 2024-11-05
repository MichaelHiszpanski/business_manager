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
      businessName: fields[0] as String,
      businessFirstName: fields[1] as String,
      businessLastName: fields[2] as String,
      businessOwnerStreet: fields[3] as String,
      businessOwnerPostCode: fields[4] as String,
      businessOwnerCity: fields[5] as String,
      businessOwnerMobile: fields[6] as String,
      businessOwnerEmail: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BusinessDetailsHive obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.businessName)
      ..writeByte(1)
      ..write(obj.businessFirstName)
      ..writeByte(2)
      ..write(obj.businessLastName)
      ..writeByte(3)
      ..write(obj.businessOwnerStreet)
      ..writeByte(4)
      ..write(obj.businessOwnerPostCode)
      ..writeByte(5)
      ..write(obj.businessOwnerCity)
      ..writeByte(6)
      ..write(obj.businessOwnerMobile)
      ..writeByte(7)
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
