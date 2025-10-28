// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectStatus _$ProjectStatusFromJson(Map<String, dynamic> json) => ProjectStatus(
      projectId: json['projectId'] as String,
      totalTasks: json['totalTasks'] as int,
      doneTasks: json['doneTasks'] as int,
      inProgressTasks: json['inProgressTasks'] as int,
      blockedTasks: json['blockedTasks'] as int,
      overdueTasks: json['overdueTasks'] as int,
      completionPercentage: (json['completionPercentage'] as num).toDouble(),
      tasksByAssignee: (json['tasksByAssignee'] as List<dynamic>)
          .map((e) => TaskByAssignee.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProjectStatusToJson(ProjectStatus instance) => <String, dynamic>{
      'projectId': instance.projectId,
      'totalTasks': instance.totalTasks,
      'doneTasks': instance.doneTasks,
      'inProgressTasks': instance.inProgressTasks,
      'blockedTasks': instance.blockedTasks,
      'overdueTasks': instance.overdueTasks,
      'completionPercentage': instance.completionPercentage,
      'tasksByAssignee': instance.tasksByAssignee,
    };

TaskByAssignee _$TaskByAssigneeFromJson(Map<String, dynamic> json) => TaskByAssignee(
      assigneeId: json['assigneeId'] as String,
      assigneeName: json['assigneeName'] as String,
      openTasks: (json['openTasks'] as List<dynamic>)
          .map((e) => Task.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TaskByAssigneeToJson(TaskByAssignee instance) => <String, dynamic>{
      'assigneeId': instance.assigneeId,
      'assigneeName': instance.assigneeName,
      'openTasks': instance.openTasks,
    };
