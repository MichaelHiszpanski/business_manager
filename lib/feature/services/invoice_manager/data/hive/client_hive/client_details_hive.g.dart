// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_details_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BusinessDetailsHiveAdapter extends TypeAdapter<ClientsDetailsHive> {
  @override
  final int typeId = 6;

  @override
  ClientsDetailsHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClientsDetailsHive(
      businessFirstName: fields[0] as String,
      businessLastName: fields[1] as String,
      businessOwnerStreet: fields[2] as String,
      businessOwnerPostCode: fields[3] as String,
      businessOwnerCity: fields[4] as String,
      businessOwnerMobile: fields[5] as String,
      businessOwnerEmail: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ClientsDetailsHive obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.businessFirstName)
      ..writeByte(1)
      ..write(obj.businessLastName)
      ..writeByte(2)
      ..write(obj.businessOwnerStreet)
      ..writeByte(3)
      ..write(obj.businessOwnerPostCode)
      ..writeByte(4)
      ..write(obj.businessOwnerCity)
      ..writeByte(5)
      ..write(obj.businessOwnerMobile)
      ..writeByte(6)
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
