import 'package:dartz/dartz.dart';
import '../entities/project.dart';

abstract class ProjectRepository {
  Future<Either<String, List<Project>>> fetchProjects();
  Future<Either<String, Project>> createProject(Project project);
  Future<Either<String, Project>> updateProject(Project project);
  Future<Either<String, void>> archiveProject(String projectId);
  Future<Either<String, Project>> getProjectById(String projectId);
}
