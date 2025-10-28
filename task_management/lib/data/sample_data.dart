import 'package:uuid/uuid.dart';
import '../domain/entities/project.dart';
import '../domain/entities/task.dart';
import '../domain/entities/subtask.dart';
import '../domain/entities/user.dart';
import 'datasources/local_storage.dart';

class SampleData {
  static const _uuid = Uuid();

  static Future<void> initializeSampleData() async {
    // Check if data already exists
    if (LocalStorage.projectsBox.isNotEmpty) return;

    // Create sample users
    final users = [
      User(
        id: _uuid.v4(),
        name: 'John Admin',
        email: 'john@example.com',
        role: UserRole.admin,
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
      ),
      User(
        id: _uuid.v4(),
        name: 'Jane Smith',
        email: 'jane@example.com',
        role: UserRole.staff,
        createdAt: DateTime.now().subtract(const Duration(days: 25)),
      ),
      User(
        id: _uuid.v4(),
        name: 'Bob Johnson',
        email: 'bob@example.com',
        role: UserRole.staff,
        createdAt: DateTime.now().subtract(const Duration(days: 20)),
      ),
      User(
        id: _uuid.v4(),
        name: 'Alice Brown',
        email: 'alice@example.com',
        role: UserRole.staff,
        createdAt: DateTime.now().subtract(const Duration(days: 15)),
      ),
    ];

    for (final user in users) {
      await LocalStorage.usersBox.put(user.id, user);
    }

    // Create sample projects
    final projects = [
      Project(
        id: _uuid.v4(),
        name: 'Mobile App Development',
        description: 'Building a cross-platform mobile application using Flutter',
        archived: false,
        createdAt: DateTime.now().subtract(const Duration(days: 20)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      Project(
        id: _uuid.v4(),
        name: 'Website Redesign',
        description: 'Complete redesign of the company website with modern UI/UX',
        archived: false,
        createdAt: DateTime.now().subtract(const Duration(days: 15)),
        updatedAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      Project(
        id: _uuid.v4(),
        name: 'Database Migration',
        description: 'Migrating legacy database to new cloud infrastructure',
        archived: true,
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        updatedAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
    ];

    for (final project in projects) {
      await LocalStorage.projectsBox.put(project.id, project);
    }

    // Create sample tasks
    final tasks = [
      // Mobile App Development tasks
      Task(
        id: _uuid.v4(),
        projectId: projects[0].id,
        title: 'Setup Flutter Project',
        description: 'Initialize Flutter project with proper folder structure and dependencies',
        status: TaskStatus.done,
        priority: TaskPriority.high,
        startDate: DateTime.now().subtract(const Duration(days: 18)),
        dueDate: DateTime.now().subtract(const Duration(days: 15)),
        estimate: 8.0,
        timeSpent: 8.0,
        labels: ['setup', 'flutter'],
        assignees: [users[0].id, users[1].id],
        createdAt: DateTime.now().subtract(const Duration(days: 18)),
        updatedAt: DateTime.now().subtract(const Duration(days: 15)),
      ),
      Task(
        id: _uuid.v4(),
        projectId: projects[0].id,
        title: 'Design UI Components',
        description: 'Create reusable UI components and design system',
        status: TaskStatus.inProgress,
        priority: TaskPriority.medium,
        startDate: DateTime.now().subtract(const Duration(days: 10)),
        dueDate: DateTime.now().add(const Duration(days: 5)),
        estimate: 16.0,
        timeSpent: 10.0,
        labels: ['ui', 'design', 'components'],
        assignees: [users[1].id, users[2].id],
        createdAt: DateTime.now().subtract(const Duration(days: 12)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      Task(
        id: _uuid.v4(),
        projectId: projects[0].id,
        title: 'Implement Authentication',
        description: 'Add user authentication and authorization features',
        status: TaskStatus.todo,
        priority: TaskPriority.high,
        startDate: DateTime.now().add(const Duration(days: 2)),
        dueDate: DateTime.now().add(const Duration(days: 10)),
        estimate: 12.0,
        timeSpent: 0.0,
        labels: ['auth', 'security'],
        assignees: [users[0].id],
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        updatedAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
      Task(
        id: _uuid.v4(),
        projectId: projects[0].id,
        title: 'API Integration',
        description: 'Integrate with backend APIs for data management',
        status: TaskStatus.blocked,
        priority: TaskPriority.medium,
        startDate: DateTime.now().subtract(const Duration(days: 3)),
        dueDate: DateTime.now().add(const Duration(days: 7)),
        estimate: 20.0,
        timeSpent: 5.0,
        labels: ['api', 'integration'],
        assignees: [users[2].id, users[3].id],
        createdAt: DateTime.now().subtract(const Duration(days: 8)),
        updatedAt: DateTime.now().subtract(const Duration(days: 2)),
      ),

      // Website Redesign tasks
      Task(
        id: _uuid.v4(),
        projectId: projects[1].id,
        title: 'Research and Analysis',
        description: 'Analyze current website and research best practices',
        status: TaskStatus.done,
        priority: TaskPriority.low,
        startDate: DateTime.now().subtract(const Duration(days: 12)),
        dueDate: DateTime.now().subtract(const Duration(days: 8)),
        estimate: 6.0,
        timeSpent: 6.0,
        labels: ['research', 'analysis'],
        assignees: [users[1].id],
        createdAt: DateTime.now().subtract(const Duration(days: 12)),
        updatedAt: DateTime.now().subtract(const Duration(days: 8)),
      ),
      Task(
        id: _uuid.v4(),
        projectId: projects[1].id,
        title: 'Create Wireframes',
        description: 'Design wireframes for all major pages',
        status: TaskStatus.inReview,
        priority: TaskPriority.medium,
        startDate: DateTime.now().subtract(const Duration(days: 6)),
        dueDate: DateTime.now().add(const Duration(days: 2)),
        estimate: 10.0,
        timeSpent: 8.0,
        labels: ['wireframes', 'design'],
        assignees: [users[1].id, users[2].id],
        createdAt: DateTime.now().subtract(const Duration(days: 8)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];

    for (final task in tasks) {
      await LocalStorage.tasksBox.put(task.id, task);
    }

    // Create sample subtasks
    final subtasks = [
      Subtask(
        id: _uuid.v4(),
        taskId: tasks[1].id, // Design UI Components
        title: 'Create Button Components',
        status: SubtaskStatus.done,
        assignee: users[1].id,
        createdAt: DateTime.now().subtract(const Duration(days: 8)),
        updatedAt: DateTime.now().subtract(const Duration(days: 6)),
      ),
      Subtask(
        id: _uuid.v4(),
        taskId: tasks[1].id, // Design UI Components
        title: 'Create Input Field Components',
        status: SubtaskStatus.inProgress,
        assignee: users[2].id,
        createdAt: DateTime.now().subtract(const Duration(days: 6)),
        updatedAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      Subtask(
        id: _uuid.v4(),
        taskId: tasks[1].id, // Design UI Components
        title: 'Create Card Components',
        status: SubtaskStatus.todo,
        assignee: users[1].id,
        createdAt: DateTime.now().subtract(const Duration(days: 4)),
        updatedAt: DateTime.now().subtract(const Duration(days: 4)),
      ),
      Subtask(
        id: _uuid.v4(),
        taskId: tasks[5].id, // Create Wireframes
        title: 'Homepage Wireframe',
        status: SubtaskStatus.done,
        assignee: users[1].id,
        createdAt: DateTime.now().subtract(const Duration(days: 6)),
        updatedAt: DateTime.now().subtract(const Duration(days: 4)),
      ),
      Subtask(
        id: _uuid.v4(),
        taskId: tasks[5].id, // Create Wireframes
        title: 'Product Page Wireframe',
        status: SubtaskStatus.inProgress,
        assignee: users[2].id,
        createdAt: DateTime.now().subtract(const Duration(days: 4)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];

    for (final subtask in subtasks) {
      await LocalStorage.subtasksBox.put(subtask.id, subtask);
    }
  }
}
