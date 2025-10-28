import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entities/project.dart';
import '../../domain/entities/task.dart';
import '../../domain/entities/subtask.dart';
import '../../domain/entities/user.dart';
import '../adapters/project_adapter.dart';
import '../adapters/task_adapter.dart';
import '../adapters/subtask_adapter.dart';
import '../adapters/user_adapter.dart';

class LocalStorage {
  static const String _projectsBox = 'projects';
  static const String _tasksBox = 'tasks';
  static const String _subtasksBox = 'subtasks';
  static const String _usersBox = 'users';

  static Future<void> init() async {
    await Hive.initFlutter();
    
    // Register adapters
    Hive.registerAdapter(ProjectAdapter());
    Hive.registerAdapter(TaskAdapter());
    Hive.registerAdapter(TaskStatusAdapter());
    Hive.registerAdapter(TaskPriorityAdapter());
    Hive.registerAdapter(SubtaskAdapter());
    Hive.registerAdapter(SubtaskStatusAdapter());
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(UserRoleAdapter());
    
    // Open boxes
    await Hive.openBox<Project>(_projectsBox);
    await Hive.openBox<Task>(_tasksBox);
    await Hive.openBox<Subtask>(_subtasksBox);
    await Hive.openBox<User>(_usersBox);
  }

  static Box<Project> get projectsBox => Hive.box<Project>(_projectsBox);
  static Box<Task> get tasksBox => Hive.box<Task>(_tasksBox);
  static Box<Subtask> get subtasksBox => Hive.box<Subtask>(_subtasksBox);
  static Box<User> get usersBox => Hive.box<User>(_usersBox);
}
