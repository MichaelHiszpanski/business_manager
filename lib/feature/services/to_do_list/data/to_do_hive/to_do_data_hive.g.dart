// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'to_do_data_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ToDoItemHiveAdapter extends TypeAdapter<ToDoItemHive> {
  @override
  final int typeId = 2;

  @override
  ToDoItemHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ToDoItemHive(
      id: fields[0] as String,
      title: fields[1] as String,
      content: fields[2] as String,
      dateTimeAdded: fields[3] as DateTime?,
      expiredDate: fields[4] as DateTime?,
      priority: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ToDoItemHive obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.dateTimeAdded)
      ..writeByte(4)
      ..write(obj.expiredDate)
      ..writeByte(5)
      ..write(obj.priority);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToDoItemHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
