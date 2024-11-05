// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_details_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClientsDetailsHiveAdapter extends TypeAdapter<ClientsDetailsHive> {
  @override
  final int typeId = 6;

  @override
  ClientsDetailsHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClientsDetailsHive(
      clientFirstName: fields[0] as String,
      clientLastName: fields[1] as String,
      clientOwnerStreet: fields[2] as String,
      clientOwnerPostCode: fields[3] as String,
      clientOwnerCity: fields[4] as String,
      clientOwnerMobile: fields[5] as String,
      clientOwnerEmail: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ClientsDetailsHive obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.clientFirstName)
      ..writeByte(1)
      ..write(obj.clientLastName)
      ..writeByte(2)
      ..write(obj.clientOwnerStreet)
      ..writeByte(3)
      ..write(obj.clientOwnerPostCode)
      ..writeByte(4)
      ..write(obj.clientOwnerCity)
      ..writeByte(5)
      ..write(obj.clientOwnerMobile)
      ..writeByte(6)
      ..write(obj.clientOwnerEmail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClientsDetailsHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
