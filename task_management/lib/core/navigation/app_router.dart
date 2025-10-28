import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/pages/home_page.dart';
import '../../presentation/pages/project_detail_page.dart';
import '../../presentation/pages/task_detail_page.dart';
import '../../presentation/pages/create_project_page.dart';
import '../../presentation/pages/create_task_page.dart';
import '../../presentation/pages/project_reports_page.dart';

class AppRouter {
  static const String home = '/';
  static const String projectDetail = '/project/:projectId';
  static const String taskDetail = '/project/:projectId/task/:taskId';
  static const String createProject = '/create-project';
  static const String createTask = '/project/:projectId/create-task';
  static const String projectReports = '/project/:projectId/reports';

  static final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: createProject,
        name: 'create-project',
        builder: (context, state) => const CreateProjectPage(),
      ),
      GoRoute(
        path: projectDetail,
        name: 'project-detail',
        builder: (context, state) {
          final projectId = state.pathParameters['projectId']!;
          return ProjectDetailPage(projectId: projectId);
        },
        routes: [
          GoRoute(
            path: 'create-task',
            name: 'create-task',
            builder: (context, state) {
              final projectId = state.pathParameters['projectId']!;
              return CreateTaskPage(projectId: projectId);
            },
          ),
          GoRoute(
            path: 'task/:taskId',
            name: 'task-detail',
            builder: (context, state) {
              final projectId = state.pathParameters['projectId']!;
              final taskId = state.pathParameters['taskId']!;
              return TaskDetailPage(projectId: projectId, taskId: taskId);
            },
          ),
          GoRoute(
            path: 'reports',
            name: 'project-reports',
            builder: (context, state) {
              final projectId = state.pathParameters['projectId']!;
              return ProjectReportsPage(projectId: projectId);
            },
          ),
        ],
      ),
    ],
  );
}
