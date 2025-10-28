import 'package:dartz/dartz.dart';
import '../../domain/entities/task.dart' as domain;
import '../../domain/entities/subtask.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/local_storage.dart';

class TaskRepositoryImpl implements TaskRepository {
  @override
  Future<Either<String, List<domain.Task>>> fetchTasksByProject(String projectId) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      final tasks = LocalStorage.tasksBox.values
          .where((task) => task.projectId == projectId)
          .toList();
      return Right(tasks);
    } catch (e) {
      return Left('Failed to fetch tasks: $e');
    }
  }

  @override
  Future<Either<String, domain.Task>> createTask(domain.Task task) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 600));
      
      await LocalStorage.tasksBox.put(task.id, task);
      return Right(task);
    } catch (e) {
      return Left('Failed to create task: $e');
    }
  }

  @override
  Future<Either<String, domain.Task>> updateTask(domain.Task task) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 700));
      
      await LocalStorage.tasksBox.put(task.id, task);
      return Right(task);
    } catch (e) {
      return Left('Failed to update task: $e');
    }
  }

  @override
  Future<Either<String, void>> deleteTask(String taskId) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      await LocalStorage.tasksBox.delete(taskId);
      
      // Also delete associated subtasks
      final subtasks = LocalStorage.subtasksBox.values
          .where((subtask) => subtask.taskId == taskId)
          .toList();
      
      for (final subtask in subtasks) {
        await LocalStorage.subtasksBox.delete(subtask.id);
      }
      
      return const Right(null);
    } catch (e) {
      return Left('Failed to delete task: $e');
    }
  }

  @override
  Future<Either<String, domain.Task>> getTaskById(String taskId) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 400));
      
      final task = LocalStorage.tasksBox.get(taskId);
      if (task == null) {
        return Left('Task not found');
      }
      
      return Right(task);
    } catch (e) {
      return Left('Failed to get task: $e');
    }
  }

  @override
  Future<Either<String, domain.Task>> assignUserToTask(String taskId, String userId) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      final task = LocalStorage.tasksBox.get(taskId);
      if (task == null) {
        return Left('Task not found');
      }
      
      if (task.assignees.contains(userId)) {
        return Right(task); // Already assigned
      }
      
      final updatedTask = task.copyWith(
        assignees: [...task.assignees, userId],
        updatedAt: DateTime.now(),
      );
      
      await LocalStorage.tasksBox.put(taskId, updatedTask);
      return Right(updatedTask);
    } catch (e) {
      return Left('Failed to assign user to task: $e');
    }
  }


  @override
  Future<Either<String, domain.Task>> unassignUserFromTask(String taskId, String userId) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      final task = LocalStorage.tasksBox.get(taskId);
      if (task == null) {
        return Left('Task not found');
      }
      
      final updatedAssignees = task.assignees.where((id) => id != userId).toList();
      final updatedTask = task.copyWith(
        assignees: updatedAssignees,
        updatedAt: DateTime.now(),
      );
      
      await LocalStorage.tasksBox.put(taskId, updatedTask);
      return Right(updatedTask);
    } catch (e) {
      return Left('Failed to unassign user from task: $e');
    }
  }

  @override
  Future<Either<String, List<Subtask>>> fetchSubtasksByTask(String taskId) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 400));
      
      final subtasks = LocalStorage.subtasksBox.values
          .where((subtask) => subtask.taskId == taskId)
          .toList();
      return Right(subtasks);
    } catch (e) {
      return Left('Failed to fetch subtasks: $e');
    }
  }

  @override
  Future<Either<String, Subtask>> createSubtask(Subtask subtask) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      await LocalStorage.subtasksBox.put(subtask.id, subtask);
      return Right(subtask);
    } catch (e) {
      return Left('Failed to create subtask: $e');
    }
  }

  @override
  Future<Either<String, Subtask>> updateSubtask(Subtask subtask) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 600));
      
      await LocalStorage.subtasksBox.put(subtask.id, subtask);
      return Right(subtask);
    } catch (e) {
      return Left('Failed to update subtask: $e');
    }
  }

  @override
  Future<Either<String, void>> deleteSubtask(String subtaskId) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 400));
      
      await LocalStorage.subtasksBox.delete(subtaskId);
      return const Right(null);
    } catch (e) {
      return Left('Failed to delete subtask: $e');
    }
  }
}
