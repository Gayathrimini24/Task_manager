import 'package:equatable/equatable.dart';
import '../../../domain/entities/project.dart';

abstract class ProjectEvent extends Equatable {
  const ProjectEvent();

  @override
  List<Object?> get props => [];
}

class ProjectFetchRequested extends ProjectEvent {
  const ProjectFetchRequested();
}

class ProjectCreateRequested extends ProjectEvent {
  final Project project;

  const ProjectCreateRequested(this.project);

  @override
  List<Object?> get props => [project];
}

class ProjectUpdateRequested extends ProjectEvent {
  final Project project;

  const ProjectUpdateRequested(this.project);

  @override
  List<Object?> get props => [project];
}

class ProjectArchiveRequested extends ProjectEvent {
  final String projectId;

  const ProjectArchiveRequested(this.projectId);

  @override
  List<Object?> get props => [projectId];
}

class ProjectSelected extends ProjectEvent {
  final String projectId;

  const ProjectSelected(this.projectId);

  @override
  List<Object?> get props => [projectId];
}
