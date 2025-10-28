import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/task_repository.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository _taskRepository;

  TaskBloc({required TaskRepository taskRepository})
      : _taskRepository = taskRepository,
        super(const TaskInitial()) {
    on<TaskFetchRequested>(_onTaskFetchRequested);
    on<TaskCreateRequested>(_onTaskCreateRequested);
    on<TaskUpdateRequested>(_onTaskUpdateRequested);
    on<TaskDeleteRequested>(_onTaskDeleteRequested);
    on<TaskAssignUserRequested>(_onTaskAssignUserRequested);
    on<TaskUnassignUserRequested>(_onTaskUnassignUserRequested);
    on<TaskFilterChanged>(_onTaskFilterChanged);
    on<SubtaskFetchRequested>(_onSubtaskFetchRequested);
    on<SubtaskCreateRequested>(_onSubtaskCreateRequested);
    on<SubtaskUpdateRequested>(_onSubtaskUpdateRequested);
    on<SubtaskDeleteRequested>(_onSubtaskDeleteRequested);
  }

  Future<void> _onTaskFetchRequested(
    TaskFetchRequested event,
    Emitter<TaskState> emit,
  ) async {
    emit(const TaskLoading());
    
    final result = await _taskRepository.fetchTasksByProject(event.projectId);
    
    result.fold(
      (error) => emit(TaskError(error)),
      (tasks) => emit(TaskLoaded(tasks: tasks, subtasks: [])),
    );
  }

  Future<void> _onTaskCreateRequested(
    TaskCreateRequested event,
    Emitter<TaskState> emit,
  ) async {
    final result = await _taskRepository.createTask(event.task);
    
    result.fold(
      (error) => emit(TaskError(error)),
      (task) {
        if (state is TaskLoaded) {
          final currentState = state as TaskLoaded;
          final updatedTasks = [...currentState.tasks, task];
          emit(currentState.copyWith(tasks: updatedTasks));
        }
        emit(const TaskOperationSuccess('Task created successfully'));
      },
    );
  }

  Future<void> _onTaskUpdateRequested(
    TaskUpdateRequested event,
    Emitter<TaskState> emit,
  ) async {
    final result = await _taskRepository.updateTask(event.task);
    
    result.fold(
      (error) => emit(TaskError(error)),
      (task) {
        if (state is TaskLoaded) {
          final currentState = state as TaskLoaded;
          final updatedTasks = currentState.tasks
              .map((t) => t.id == task.id ? task : t)
              .toList();
          emit(currentState.copyWith(tasks: updatedTasks));
        }
        emit(const TaskOperationSuccess('Task updated successfully'));
      },
    );
  }

  Future<void> _onTaskDeleteRequested(
    TaskDeleteRequested event,
    Emitter<TaskState> emit,
  ) async {
    final result = await _taskRepository.deleteTask(event.taskId);
    
    result.fold(
      (error) => emit(TaskError(error)),
      (_) {
        if (state is TaskLoaded) {
          final currentState = state as TaskLoaded;
          final updatedTasks = currentState.tasks
              .where((t) => t.id != event.taskId)
              .toList();
          final updatedSubtasks = currentState.subtasks
              .where((s) => s.taskId != event.taskId)
              .toList();
          emit(currentState.copyWith(tasks: updatedTasks, subtasks: updatedSubtasks));
        }
        emit(const TaskOperationSuccess('Task deleted successfully'));
      },
    );
  }

  Future<void> _onTaskAssignUserRequested(
    TaskAssignUserRequested event,
    Emitter<TaskState> emit,
  ) async {
    final result = await _taskRepository.assignUserToTask(event.taskId, event.userId);
    
    result.fold(
      (error) => emit(TaskError(error)),
      (task) {
        if (state is TaskLoaded) {
          final currentState = state as TaskLoaded;
          final updatedTasks = currentState.tasks
              .map((t) => t.id == task.id ? task : t)
              .toList();
          emit(currentState.copyWith(tasks: updatedTasks));
        }
        emit(const TaskOperationSuccess('User assigned to task'));
      },
    );
  }

  Future<void> _onTaskUnassignUserRequested(
    TaskUnassignUserRequested event,
    Emitter<TaskState> emit,
  ) async {
    final result = await _taskRepository.unassignUserFromTask(event.taskId, event.userId);
    
    result.fold(
      (error) => emit(TaskError(error)),
      (task) {
        if (state is TaskLoaded) {
          final currentState = state as TaskLoaded;
          final updatedTasks = currentState.tasks
              .map((t) => t.id == task.id ? task : t)
              .toList();
          emit(currentState.copyWith(tasks: updatedTasks));
        }
        emit(const TaskOperationSuccess('User unassigned from task'));
      },
    );
  }

  void _onTaskFilterChanged(
    TaskFilterChanged event,
    Emitter<TaskState> emit,
  ) {
    if (state is TaskLoaded) {
      final currentState = state as TaskLoaded;
      emit(currentState.copyWith(
        statusFilter: event.status,
        priorityFilter: event.priority,
        assigneeFilter: event.assigneeId,
        searchQuery: event.searchQuery,
      ));
    }
  }

  Future<void> _onSubtaskFetchRequested(
    SubtaskFetchRequested event,
    Emitter<TaskState> emit,
  ) async {
    final result = await _taskRepository.fetchSubtasksByTask(event.taskId);
    
    result.fold(
      (error) => emit(TaskError(error)),
      (subtasks) {
        if (state is TaskLoaded) {
          final currentState = state as TaskLoaded;
          emit(currentState.copyWith(subtasks: subtasks));
        }
      },
    );
  }

  Future<void> _onSubtaskCreateRequested(
    SubtaskCreateRequested event,
    Emitter<TaskState> emit,
  ) async {
    final result = await _taskRepository.createSubtask(event.subtask);
    
    result.fold(
      (error) => emit(TaskError(error)),
      (subtask) {
        if (state is TaskLoaded) {
          final currentState = state as TaskLoaded;
          final updatedSubtasks = [...currentState.subtasks, subtask];
          emit(currentState.copyWith(subtasks: updatedSubtasks));
        }
        emit(const TaskOperationSuccess('Subtask created successfully'));
      },
    );
  }

  Future<void> _onSubtaskUpdateRequested(
    SubtaskUpdateRequested event,
    Emitter<TaskState> emit,
  ) async {
    final result = await _taskRepository.updateSubtask(event.subtask);
    
    result.fold(
      (error) => emit(TaskError(error)),
      (subtask) {
        if (state is TaskLoaded) {
          final currentState = state as TaskLoaded;
          final updatedSubtasks = currentState.subtasks
              .map((s) => s.id == subtask.id ? subtask : s)
              .toList();
          emit(currentState.copyWith(subtasks: updatedSubtasks));
        }
        emit(const TaskOperationSuccess('Subtask updated successfully'));
      },
    );
  }

  Future<void> _onSubtaskDeleteRequested(
    SubtaskDeleteRequested event,
    Emitter<TaskState> emit,
  ) async {
    final result = await _taskRepository.deleteSubtask(event.subtaskId);
    
    result.fold(
      (error) => emit(TaskError(error)),
      (_) {
        if (state is TaskLoaded) {
          final currentState = state as TaskLoaded;
          final updatedSubtasks = currentState.subtasks
              .where((s) => s.id != event.subtaskId)
              .toList();
          emit(currentState.copyWith(subtasks: updatedSubtasks));
        }
        emit(const TaskOperationSuccess('Subtask deleted successfully'));
      },
    );
  }
}
