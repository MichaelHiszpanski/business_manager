// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_task_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmployeeTaskHiveAdapter extends TypeAdapter<EmployeeTaskHive> {
  @override
  final int typeId = 10;

  @override
  EmployeeTaskHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmployeeTaskHive(
      taskID: fields[0] as String?,
      taskTitle: fields[1] as String,
      taskDescription: fields[2] as String,
      taskDuration: fields[3] as double,
      employeeID: fields[4] as String,
      employeeCheckInTime: fields[5] as DateTime?,
      employeeCheckOutTime: fields[6] as DateTime?,
      isDone: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, EmployeeTaskHive obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.taskID)
      ..writeByte(1)
      ..write(obj.taskTitle)
      ..writeByte(2)
      ..write(obj.taskDescription)
      ..writeByte(3)
      ..write(obj.taskDuration)
      ..writeByte(4)
      ..write(obj.employeeID)
      ..writeByte(5)
      ..write(obj.employeeCheckInTime)
      ..writeByte(6)
      ..write(obj.employeeCheckOutTime)
      ..writeByte(7)
      ..write(obj.isDone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeTaskHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
