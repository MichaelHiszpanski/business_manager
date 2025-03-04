// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_details_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmployeeDetailsHiveAdapter extends TypeAdapter<EmployeeDetailsHive> {
  @override
  final int typeId = 9;

  @override
  EmployeeDetailsHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmployeeDetailsHive(
      employeeID: fields[0] as String?,
      employeeFirstName: fields[1] as String,
      employeeLastName: fields[2] as String,
      employeeEmail: fields[3] as String,
      employeeRole: fields[4] as String,
      tasksDone: (fields[5] as List).cast<TasksDoneHive>(),
      employeeDateJoined: fields[6] as DateTime,
      employeeTaskList: (fields[7] as List).cast<EmployeeTaskHive>(),
    );
  }

  @override
  void write(BinaryWriter writer, EmployeeDetailsHive obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.employeeID)
      ..writeByte(1)
      ..write(obj.employeeFirstName)
      ..writeByte(2)
      ..write(obj.employeeLastName)
      ..writeByte(3)
      ..write(obj.employeeEmail)
      ..writeByte(4)
      ..write(obj.employeeRole)
      ..writeByte(5)
      ..write(obj.tasksDone)
      ..writeByte(6)
      ..write(obj.employeeDateJoined)
      ..writeByte(7)
      ..write(obj.employeeTaskList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeDetailsHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
