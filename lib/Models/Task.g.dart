// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 0;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task()
      .._id = fields[0] as String?
      .._title = fields[1] as String?
      .._description = fields[2] as String?
      .._priority = fields[3] as String?
      .._completed = fields[4] as bool?
      .._deadline = fields[5] as DateTime?
      .._user = fields[6] as String?
      .._createdAt = fields[7] as DateTime?
      .._updatedAt = fields[8] as DateTime?;
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj._id)
      ..writeByte(1)
      ..write(obj._title)
      ..writeByte(2)
      ..write(obj._description)
      ..writeByte(3)
      ..write(obj._priority)
      ..writeByte(4)
      ..write(obj._completed)
      ..writeByte(5)
      ..write(obj._deadline)
      ..writeByte(6)
      ..write(obj._user)
      ..writeByte(7)
      ..write(obj._createdAt)
      ..writeByte(8)
      ..write(obj._updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
