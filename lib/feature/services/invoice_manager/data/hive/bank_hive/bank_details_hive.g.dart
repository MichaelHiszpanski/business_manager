// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_details_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BankDetailsHiveAdapter extends TypeAdapter<BankDetailsHive> {
  @override
  final int typeId = 8;

  @override
  BankDetailsHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BankDetailsHive(
      bankName: fields[0] as String,
      sortCode: fields[1] as String,
      accountNo: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BankDetailsHive obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.bankName)
      ..writeByte(1)
      ..write(obj.sortCode)
      ..writeByte(2)
      ..write(obj.accountNo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BankDetailsHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
