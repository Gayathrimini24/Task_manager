import 'package:equatable/equatable.dart';
import '../../../domain/entities/task.dart';
import '../../../domain/entities/subtask.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

class TaskInitial extends TaskState {
  const TaskInitial();
}

class TaskLoading extends TaskState {
  const TaskLoading();
}

class TaskLoaded extends TaskState {
  final List<Task> tasks;
  final List<Subtask> subtasks;
  final TaskStatus? statusFilter;
  final TaskPriority? priorityFilter;
  final String? assigneeFilter;
  final String? searchQuery;

  const TaskLoaded({
    required this.tasks,
    required this.subtasks,
    this.statusFilter,
    this.priorityFilter,
    this.assigneeFilter,
    this.searchQuery,
  });

  TaskLoaded copyWith({
    List<Task>? tasks,
    List<Subtask>? subtasks,
    TaskStatus? statusFilter,
    TaskPriority? priorityFilter,
    String? assigneeFilter,
    String? searchQuery,
  }) {
    return TaskLoaded(
      tasks: tasks ?? this.tasks,
      subtasks: subtasks ?? this.subtasks,
      statusFilter: statusFilter ?? this.statusFilter,
      priorityFilter: priorityFilter ?? this.priorityFilter,
      assigneeFilter: assigneeFilter ?? this.assigneeFilter,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  List<Task> get filteredTasks {
    var filtered = tasks;

    if (statusFilter != null) {
      filtered = filtered.where((task) => task.status == statusFilter).toList();
    }

    if (priorityFilter != null) {
      filtered = filtered.where((task) => task.priority == priorityFilter).toList();
    }

    if (assigneeFilter != null && assigneeFilter!.isNotEmpty) {
      filtered = filtered.where((task) => task.assignees.contains(assigneeFilter)).toList();
    }

    if (searchQuery != null && searchQuery!.isNotEmpty) {
      final query = searchQuery!.toLowerCase();
      filtered = filtered.where((task) =>
          task.title.toLowerCase().contains(query) ||
          task.description.toLowerCase().contains(query) ||
          task.labels.any((label) => label.toLowerCase().contains(query))).toList();
    }

    return filtered;
  }

  @override
  List<Object?> get props => [
        tasks,
        subtasks,
        statusFilter,
        priorityFilter,
        assigneeFilter,
        searchQuery,
      ];
}

class TaskError extends TaskState {
  final String message;

  const TaskError(this.message);

  @override
  List<Object?> get props => [message];
}

class TaskOperationSuccess extends TaskState {
  final String message;

  const TaskOperationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}
