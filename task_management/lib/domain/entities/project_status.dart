import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'task.dart';

part 'project_status.g.dart';

@JsonSerializable()
class ProjectStatus extends Equatable {
  final String projectId;
  final int totalTasks;
  final int doneTasks;
  final int inProgressTasks;
  final int blockedTasks;
  final int overdueTasks;
  final double completionPercentage;
  final List<TaskByAssignee> tasksByAssignee;

  const ProjectStatus({
    required this.projectId,
    required this.totalTasks,
    required this.doneTasks,
    required this.inProgressTasks,
    required this.blockedTasks,
    required this.overdueTasks,
    required this.completionPercentage,
    required this.tasksByAssignee,
  });

  factory ProjectStatus.fromJson(Map<String, dynamic> json) => _$ProjectStatusFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectStatusToJson(this);

  @override
  List<Object?> get props => [
        projectId,
        totalTasks,
        doneTasks,
        inProgressTasks,
        blockedTasks,
        overdueTasks,
        completionPercentage,
        tasksByAssignee,
      ];
}

@JsonSerializable()
class TaskByAssignee extends Equatable {
  final String assigneeId;
  final String assigneeName;
  final List<Task> openTasks;

  const TaskByAssignee({
    required this.assigneeId,
    required this.assigneeName,
    required this.openTasks,
  });

  factory TaskByAssignee.fromJson(Map<String, dynamic> json) => _$TaskByAssigneeFromJson(json);
  Map<String, dynamic> toJson() => _$TaskByAssigneeToJson(this);

  @override
  List<Object?> get props => [assigneeId, assigneeName, openTasks];
}
