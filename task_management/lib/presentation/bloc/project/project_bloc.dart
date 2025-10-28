import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/project_repository.dart';
import 'project_event.dart';
import 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final ProjectRepository _projectRepository;

  ProjectBloc({required ProjectRepository projectRepository})
      : _projectRepository = projectRepository,
        super(const ProjectInitial()) {
    on<ProjectFetchRequested>(_onProjectFetchRequested);
    on<ProjectCreateRequested>(_onProjectCreateRequested);
    on<ProjectUpdateRequested>(_onProjectUpdateRequested);
    on<ProjectArchiveRequested>(_onProjectArchiveRequested);
    on<ProjectSelected>(_onProjectSelected);
  }

  Future<void> _onProjectFetchRequested(
    ProjectFetchRequested event,
    Emitter<ProjectState> emit,
  ) async {
    emit(const ProjectLoading());
    
    final result = await _projectRepository.fetchProjects();
    
    result.fold(
      (error) => emit(ProjectError(error)),
      (projects) => emit(ProjectLoaded(projects: projects)),
    );
  }

  Future<void> _onProjectCreateRequested(
    ProjectCreateRequested event,
    Emitter<ProjectState> emit,
  ) async {
    final result = await _projectRepository.createProject(event.project);
    
    result.fold(
      (error) => emit(ProjectError(error)),
      (project) {
        if (state is ProjectLoaded) {
          final currentState = state as ProjectLoaded;
          final updatedProjects = [...currentState.projects, project];
          emit(ProjectLoaded(
            projects: updatedProjects,
            selectedProjectId: currentState.selectedProjectId,
          ));
        }
        emit(const ProjectOperationSuccess('Project created successfully'));
      },
    );
  }

  Future<void> _onProjectUpdateRequested(
    ProjectUpdateRequested event,
    Emitter<ProjectState> emit,
  ) async {
    final result = await _projectRepository.updateProject(event.project);
    
    result.fold(
      (error) => emit(ProjectError(error)),
      (project) {
        if (state is ProjectLoaded) {
          final currentState = state as ProjectLoaded;
          final updatedProjects = currentState.projects
              .map((p) => p.id == project.id ? project : p)
              .toList();
          emit(ProjectLoaded(
            projects: updatedProjects,
            selectedProjectId: currentState.selectedProjectId,
          ));
        }
        emit(const ProjectOperationSuccess('Project updated successfully'));
      },
    );
  }

  Future<void> _onProjectArchiveRequested(
    ProjectArchiveRequested event,
    Emitter<ProjectState> emit,
  ) async {
    final result = await _projectRepository.archiveProject(event.projectId);
    
    result.fold(
      (error) => emit(ProjectError(error)),
      (_) {
        if (state is ProjectLoaded) {
          final currentState = state as ProjectLoaded;
          final updatedProjects = currentState.projects
              .map((p) => p.id == event.projectId 
                  ? p.copyWith(archived: true, updatedAt: DateTime.now())
                  : p)
              .toList();
          emit(ProjectLoaded(
            projects: updatedProjects,
            selectedProjectId: currentState.selectedProjectId,
          ));
        }
        emit(const ProjectOperationSuccess('Project archived successfully'));
      },
    );
  }

  void _onProjectSelected(
    ProjectSelected event,
    Emitter<ProjectState> emit,
  ) {
    if (state is ProjectLoaded) {
      final currentState = state as ProjectLoaded;
      emit(ProjectLoaded(
        projects: currentState.projects,
        selectedProjectId: event.projectId,
      ));
    }
  }
}
