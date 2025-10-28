import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/project/project_bloc.dart';
import '../bloc/project/project_state.dart';
import '../bloc/task/task_bloc.dart';
import '../bloc/task/task_event.dart';
import '../bloc/task/task_state.dart';
import '../widgets/task_card.dart';
import '../widgets/loading_skeleton.dart';
import '../widgets/empty_state.dart';
import '../widgets/error_state.dart';

class ProjectDetailPage extends StatefulWidget {
  final String projectId;

  const ProjectDetailPage({
    super.key,
    required this.projectId,
  });

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(TaskFetchRequested(widget.projectId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<ProjectBloc, ProjectState>(
          builder: (context, state) {
            if (state is ProjectLoaded) {
              final project = state.projects.firstWhere(
                (p) => p.id == widget.projectId,
                orElse: () => throw Exception('Project not found'),
              );
              return Text(project.name);
            }
            return const Text('Project');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.analytics_outlined),
            onPressed: () => context.go('/project/${widget.projectId}/reports'),
            tooltip: 'View Reports',
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.go('/project/${widget.projectId}/create-task'),
            tooltip: 'Create Task',
          ),
        ],
      ),
      body: BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is TaskError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          } else if (state is TaskOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is TaskLoading) {
            return const LoadingSkeleton();
          } else if (state is TaskLoaded) {
            final tasks = state.filteredTasks;
            
            if (tasks.isEmpty) {
              return EmptyState(
                icon: Icons.task_alt,
                title: 'No Tasks Yet',
                subtitle: 'Create your first task to get started',
                actionText: 'Create Task',
                onAction: () => context.go('/project/${widget.projectId}/create-task'),
              );
            }
            
            return RefreshIndicator(
              onRefresh: () async {
                context.read<TaskBloc>().add(TaskFetchRequested(widget.projectId));
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: TaskCard(
                      task: task,
                      onTap: () => context.go('/project/${widget.projectId}/task/${task.id}'),
                    ),
                  );
                },
              ),
            );
          } else if (state is TaskError) {
            return ErrorState(
              message: state.message,
              onRetry: () {
                context.read<TaskBloc>().add(TaskFetchRequested(widget.projectId));
              },
            );
          }
          
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
