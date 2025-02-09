// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_done_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TasksDoneHiveAdapter extends TypeAdapter<TasksDoneHive> {
  @override
  final int typeId = 11;

  @override
  TasksDoneHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TasksDoneHive(
      employeeID: fields[0] as String?,
      isDone: fields[1] as bool,
      taskID: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TasksDoneHive obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.employeeID)
      ..writeByte(1)
      ..write(obj.isDone)
      ..writeByte(2)
      ..write(obj.taskID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TasksDoneHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
