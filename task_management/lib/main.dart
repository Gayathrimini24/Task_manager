import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection.dart';
import 'core/navigation/app_router.dart';
import 'core/theme/app_theme.dart';
import 'data/datasources/local_storage.dart';
import 'data/sample_data.dart';
import 'presentation/bloc/project/project_bloc.dart';
import 'presentation/bloc/project/project_event.dart';
import 'presentation/bloc/task/task_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await LocalStorage.init();
  
  // Initialize sample data
  await SampleData.initializeSampleData();
  
  // Configure dependencies
  await configureDependencies();
  
  runApp(const TaskFlowApp());
}

class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProjectBloc>(
          create: (context) => getIt<ProjectBloc>()..add(const ProjectFetchRequested()),
        ),
        BlocProvider<TaskBloc>(
          create: (context) => getIt<TaskBloc>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'TaskFlow Mini',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
