import 'package:get_it/get_it.dart';
import '../../data/repositories/project_repository_impl.dart';
import '../../data/repositories/task_repository_impl.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../data/repositories/report_repository_impl.dart';
import '../../domain/repositories/project_repository.dart';
import '../../domain/repositories/task_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/repositories/report_repository.dart';
import '../../presentation/bloc/project/project_bloc.dart';
import '../../presentation/bloc/task/task_bloc.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Repositories
  getIt.registerLazySingleton<ProjectRepository>(
    () => ProjectRepositoryImpl(),
  );
  
  getIt.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(),
  );
  
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(),
  );
  
  getIt.registerLazySingleton<ReportRepository>(
    () => ReportRepositoryImpl(),
  );

  // BLoCs
  getIt.registerFactory<ProjectBloc>(
    () => ProjectBloc(projectRepository: getIt<ProjectRepository>()),
  );
  
  getIt.registerFactory<TaskBloc>(
    () => TaskBloc(taskRepository: getIt<TaskRepository>()),
  );
}
