import 'package:hive/hive.dart';
import '../../domain/entities/subtask.dart';

class SubtaskAdapter extends TypeAdapter<Subtask> {
  @override
  final int typeId = 4;

  @override
  Subtask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Subtask(
      id: fields[0] as String,
      taskId: fields[1] as String,
      title: fields[2] as String,
      status: fields[3] as SubtaskStatus,
      assignee: fields[4] as String?,
      createdAt: fields[5] as DateTime,
      updatedAt: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Subtask obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.taskId)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.assignee)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.updatedAt);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubtaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;

  @override
  int get hashCode => typeId.hashCode;
}

class SubtaskStatusAdapter extends TypeAdapter<SubtaskStatus> {
  @override
  final int typeId = 5;

  @override
  SubtaskStatus read(BinaryReader reader) {
    return SubtaskStatus.values[reader.readByte()];
  }

  @override
  void write(BinaryWriter writer, SubtaskStatus obj) {
    writer.writeByte(obj.index);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubtaskStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;

  @override
  int get hashCode => typeId.hashCode;
}
