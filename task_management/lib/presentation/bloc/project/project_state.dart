import 'package:equatable/equatable.dart';
import '../../../domain/entities/project.dart';

abstract class ProjectState extends Equatable {
  const ProjectState();

  @override
  List<Object?> get props => [];
}

class ProjectInitial extends ProjectState {
  const ProjectInitial();
}

class ProjectLoading extends ProjectState {
  const ProjectLoading();
}

class ProjectLoaded extends ProjectState {
  final List<Project> projects;
  final String? selectedProjectId;

  const ProjectLoaded({
    required this.projects,
    this.selectedProjectId,
  });

  ProjectLoaded copyWith({
    List<Project>? projects,
    String? selectedProjectId,
  }) {
    return ProjectLoaded(
      projects: projects ?? this.projects,
      selectedProjectId: selectedProjectId ?? this.selectedProjectId,
    );
  }

  @override
  List<Object?> get props => [projects, selectedProjectId];
}

class ProjectError extends ProjectState {
  final String message;

  const ProjectError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProjectOperationSuccess extends ProjectState {
  final String message;

  const ProjectOperationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}
