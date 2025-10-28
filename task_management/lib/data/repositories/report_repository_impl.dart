import 'package:dartz/dartz.dart';
import '../../domain/entities/project_status.dart';
import '../../domain/entities/task.dart' as domain;
import '../../domain/repositories/report_repository.dart';
import '../datasources/local_storage.dart';

class ReportRepositoryImpl implements ReportRepository {
  @override
  Future<Either<String, ProjectStatus>> getProjectStatus(String projectId) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 800));
      
      final tasks = LocalStorage.tasksBox.values
          .where((task) => task.projectId == projectId)
          .toList();
      
      final totalTasks = tasks.length;
      final doneTasks = tasks.where((task) => task.status == domain.TaskStatus.done).length;
      final inProgressTasks = tasks.where((task) => task.status == domain.TaskStatus.inProgress).length;
      final blockedTasks = tasks.where((task) => task.status == domain.TaskStatus.blocked).length;
      final overdueTasks = tasks.where((task) => task.isOverdue).length;
      
      final completionPercentage = totalTasks > 0 ? (doneTasks / totalTasks) * 100 : 0.0;
      
      // Get tasks by assignee
      final tasksByAssignee = <TaskByAssignee>[];
      final assigneeMap = <String, List<domain.Task>>{};
      
      for (final task in tasks) {
        if (task.status != domain.TaskStatus.done) {
          for (final assigneeId in task.assignees) {
            assigneeMap.putIfAbsent(assigneeId, () => []).add(task);
          }
        }
      }
      
      for (final entry in assigneeMap.entries) {
        final user = LocalStorage.usersBox.get(entry.key);
        if (user != null) {
          tasksByAssignee.add(TaskByAssignee(
            assigneeId: entry.key,
            assigneeName: user.name,
            openTasks: entry.value,
          ));
        }
      }
      
      final projectStatus = ProjectStatus(
        projectId: projectId,
        totalTasks: totalTasks,
        doneTasks: doneTasks,
        inProgressTasks: inProgressTasks,
        blockedTasks: blockedTasks,
        overdueTasks: overdueTasks,
        completionPercentage: completionPercentage,
        tasksByAssignee: tasksByAssignee,
      );
      
      return Right(projectStatus);
    } catch (e) {
      return Left('Failed to get project status: $e');
    }
  }
}
