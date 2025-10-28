import 'package:equatable/equatable.dart';
import '../../../domain/entities/task.dart';
import '../../../domain/entities/subtask.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class TaskFetchRequested extends TaskEvent {
  final String projectId;

  const TaskFetchRequested(this.projectId);

  @override
  List<Object?> get props => [projectId];
}

class TaskCreateRequested extends TaskEvent {
  final Task task;

  const TaskCreateRequested(this.task);

  @override
  List<Object?> get props => [task];
}

class TaskUpdateRequested extends TaskEvent {
  final Task task;

  const TaskUpdateRequested(this.task);

  @override
  List<Object?> get props => [task];
}

class TaskDeleteRequested extends TaskEvent {
  final String taskId;

  const TaskDeleteRequested(this.taskId);

  @override
  List<Object?> get props => [taskId];
}

class TaskAssignUserRequested extends TaskEvent {
  final String taskId;
  final String userId;

  const TaskAssignUserRequested(this.taskId, this.userId);

  @override
  List<Object?> get props => [taskId, userId];
}

class TaskUnassignUserRequested extends TaskEvent {
  final String taskId;
  final String userId;

  const TaskUnassignUserRequested(this.taskId, this.userId);

  @override
  List<Object?> get props => [taskId, userId];
}

class TaskFilterChanged extends TaskEvent {
  final TaskStatus? status;
  final TaskPriority? priority;
  final String? assigneeId;
  final String? searchQuery;

  const TaskFilterChanged({
    this.status,
    this.priority,
    this.assigneeId,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [status, priority, assigneeId, searchQuery];
}

// Subtask events
class SubtaskFetchRequested extends TaskEvent {
  final String taskId;

  const SubtaskFetchRequested(this.taskId);

  @override
  List<Object?> get props => [taskId];
}

class SubtaskCreateRequested extends TaskEvent {
  final Subtask subtask;

  const SubtaskCreateRequested(this.subtask);

  @override
  List<Object?> get props => [subtask];
}

class SubtaskUpdateRequested extends TaskEvent {
  final Subtask subtask;

  const SubtaskUpdateRequested(this.subtask);

  @override
  List<Object?> get props => [subtask];
}

class SubtaskDeleteRequested extends TaskEvent {
  final String subtaskId;

  const SubtaskDeleteRequested(this.subtaskId);

  @override
  List<Object?> get props => [subtaskId];
}