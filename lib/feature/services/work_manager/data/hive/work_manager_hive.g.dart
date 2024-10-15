// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_manager_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkManagerHiveAdapter extends TypeAdapter<WorkManagerHive> {
  @override
  final int typeId = 3;

  @override
  WorkManagerHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkManagerHive(
      eventName: fields[0] as String,
      eventDescription: fields[1] as String,
      startDate: fields[2] as DateTime,
      finishDate: fields[3] as DateTime,
      backgroundColor: fields[4] as Color,
      isAllDay: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, WorkManagerHive obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.eventName)
      ..writeByte(1)
      ..write(obj.eventDescription)
      ..writeByte(2)
      ..write(obj.startDate)
      ..writeByte(3)
      ..write(obj.finishDate)
      ..writeByte(4)
      ..write(obj.backgroundColor)
      ..writeByte(5)
      ..write(obj.isAllDay);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkManagerHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
