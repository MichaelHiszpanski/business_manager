// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_items_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InvoiceItemsHiveAdapter extends TypeAdapter<InvoiceItemsHive> {
  @override
  final int typeId = 7;

  @override
  InvoiceItemsHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InvoiceItemsHive(
      description: fields[0] as String,
      quantity: fields[1] as String,
      itemPrice: fields[2] as String,
      totalItems: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, InvoiceItemsHive obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.description)
      ..writeByte(1)
      ..write(obj.quantity)
      ..writeByte(2)
      ..write(obj.itemPrice)
      ..writeByte(3)
      ..write(obj.totalItems);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InvoiceItemsHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
