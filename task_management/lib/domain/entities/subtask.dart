import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subtask.g.dart';

enum SubtaskStatus {
  @JsonValue('todo')
  todo,
  @JsonValue('inProgress')
  inProgress,
  @JsonValue('done')
  done,
}

@JsonSerializable()
class Subtask extends Equatable {
  final String id;
  final String taskId;
  final String title;
  final SubtaskStatus status;
  final String? assignee;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Subtask({
    required this.id,
    required this.taskId,
    required this.title,
    required this.status,
    this.assignee,
    required this.createdAt,
    required this.updatedAt,
  });

  Subtask copyWith({
    String? id,
    String? taskId,
    String? title,
    SubtaskStatus? status,
    String? assignee,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Subtask(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      title: title ?? this.title,
      status: status ?? this.status,
      assignee: assignee ?? this.assignee,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Subtask.fromJson(Map<String, dynamic> json) => _$SubtaskFromJson(json);
  Map<String, dynamic> toJson() => _$SubtaskToJson(this);

  @override
  List<Object?> get props => [id, taskId, title, status, assignee, createdAt, updatedAt];
}
