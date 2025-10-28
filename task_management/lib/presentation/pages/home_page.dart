import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/navigation/app_router.dart';
import '../bloc/project/project_bloc.dart';
import '../bloc/project/project_event.dart';
import '../bloc/project/project_state.dart';
import '../widgets/project_card.dart';
import '../widgets/loading_skeleton.dart';
import '../widgets/empty_state.dart';
import '../widgets/error_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TaskFlow Mini'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.go(AppRouter.createProject),
            tooltip: 'Create Project',
          ),
        ],
      ),
      body: BlocConsumer<ProjectBloc, ProjectState>(
        listener: (context, state) {
          if (state is ProjectError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          } else if (state is ProjectOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ProjectLoading) {
            return const LoadingSkeleton();
          } else if (state is ProjectLoaded) {
            final activeProjects = state.projects.where((p) => !p.archived).toList();
            
            if (activeProjects.isEmpty) {
              return EmptyState(
                icon: Icons.folder_outlined,
                title: 'No Projects Yet',
                subtitle: 'Create your first project to get started',
                actionText: 'Create Project',
                onAction: () => context.go(AppRouter.createProject),
              );
            }
            
            return RefreshIndicator(
              onRefresh: () async {
                context.read<ProjectBloc>().add(const ProjectFetchRequested());
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: activeProjects.length,
                itemBuilder: (context, index) {
                  final project = activeProjects[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ProjectCard(
                      project: project,
                      onTap: () => context.go('/project/${project.id}'),
                      onArchive: () {
                        context.read<ProjectBloc>().add(
                          ProjectArchiveRequested(project.id),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          } else if (state is ProjectError) {
            return ErrorState(
              message: state.message,
              onRetry: () {
                context.read<ProjectBloc>().add(const ProjectFetchRequested());
              },
            );
          }
          
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
