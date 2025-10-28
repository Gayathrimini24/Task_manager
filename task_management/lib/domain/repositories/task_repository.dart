import 'package:dartz/dartz.dart';
import '../entities/task.dart' as domain;
import '../entities/subtask.dart';

abstract class TaskRepository {
  // Task operations
  Future<Either<String, List<domain.Task>>> fetchTasksByProject(String projectId);
  Future<Either<String, domain.Task>> createTask(domain.Task task);
  Future<Either<String, domain.Task>> updateTask(domain.Task task);
  Future<Either<String, void>> deleteTask(String taskId);
  Future<Either<String, domain.Task>> getTaskById(String taskId);
  
  // Assignment operations
  Future<Either<String, domain.Task>> assignUserToTask(String taskId, String userId);
  Future<Either<String, domain.Task>> unassignUserFromTask(String taskId, String userId);
  
  // Subtask operations
  Future<Either<String, List<Subtask>>> fetchSubtasksByTask(String taskId);
  Future<Either<String, Subtask>> createSubtask(Subtask subtask);
  Future<Either<String, Subtask>> updateSubtask(Subtask subtask);
  Future<Either<String, void>> deleteSubtask(String subtaskId);
}
