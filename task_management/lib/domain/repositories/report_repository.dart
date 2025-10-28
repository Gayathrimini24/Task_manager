import 'package:dartz/dartz.dart';
import '../entities/project_status.dart';

abstract class ReportRepository {
  Future<Either<String, ProjectStatus>> getProjectStatus(String projectId);
}
