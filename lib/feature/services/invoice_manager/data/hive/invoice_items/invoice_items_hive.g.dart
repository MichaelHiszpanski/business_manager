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
      itemID: fields[0] as String?,
      description: fields[1] as String,
      quantity: fields[2] as String,
      itemPrice: fields[3] as String,
      totalItems: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, InvoiceItemsHive obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.itemID)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.itemPrice)
      ..writeByte(4)
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
