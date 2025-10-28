import 'package:dartz/dartz.dart';
import '../../domain/entities/project.dart';
import '../../domain/repositories/project_repository.dart';
import '../datasources/local_storage.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  @override
  Future<Either<String, List<Project>>> fetchProjects() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      final projects = LocalStorage.projectsBox.values.toList();
      return Right(projects);
    } catch (e) {
      return Left('Failed to fetch projects: $e');
    }
  }

  @override
  Future<Either<String, Project>> createProject(Project project) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 600));
      
      await LocalStorage.projectsBox.put(project.id, project);
      return Right(project);
    } catch (e) {
      return Left('Failed to create project: $e');
    }
  }

  @override
  Future<Either<String, Project>> updateProject(Project project) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 700));
      
      await LocalStorage.projectsBox.put(project.id, project);
      return Right(project);
    } catch (e) {
      return Left('Failed to update project: $e');
    }
  }

  @override
  Future<Either<String, void>> archiveProject(String projectId) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      final project = LocalStorage.projectsBox.get(projectId);
      if (project == null) {
        return Left('Project not found');
      }
      
      final archivedProject = project.copyWith(
        archived: true,
        updatedAt: DateTime.now(),
      );
      
      await LocalStorage.projectsBox.put(projectId, archivedProject);
      return const Right(null);
    } catch (e) {
      return Left('Failed to archive project: $e');
    }
  }

  @override
  Future<Either<String, Project>> getProjectById(String projectId) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 400));
      
      final project = LocalStorage.projectsBox.get(projectId);
      if (project == null) {
        return Left('Project not found');
      }
      
      return Right(project);
    } catch (e) {
      return Left('Failed to get project: $e');
    }
  }
}
