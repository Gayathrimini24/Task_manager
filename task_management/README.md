# TaskFlow Mini

A comprehensive task management app built with Flutter, featuring projects, tasks, and subtasks with a clean architecture and modern UI.

## Features

### Core Features (MVP)
- **Projects**: Create, list, and archive projects with name and description
- **Tasks**: Full task management with status, priority, dates, estimates, and assignments
- **Subtasks**: Break down tasks into smaller, manageable subtasks
- **User Management**: Admin and staff roles with assignment capabilities
- **Status Reports**: Project insights with completion metrics and assignee breakdowns

### Technical Features
- **Clean Architecture**: Domain-driven design with repository pattern
- **State Management**: Flutter BLoC with Equatable for immutable states
- **Navigation**: Go Router for declarative navigation
- **Local Storage**: Hive database for offline-first functionality
- **Theming**: Light/Dark mode support with Material 3 design
- **Responsive UI**: Loading skeletons, empty states, and error handling

## Architecture

```
lib/
├── core/                    # Core functionality
│   ├── di/                 # Dependency injection
│   ├── navigation/         # App routing
│   └── theme/              # App theming
├── data/                   # Data layer
│   ├── adapters/           # Hive adapters
│   ├── datasources/        # Local storage
│   ├── repositories/       # Repository implementations
│   └── sample_data.dart    # Sample data initialization
├── domain/                 # Domain layer
│   ├── entities/           # Business entities
│   └── repositories/       # Repository interfaces
└── presentation/           # Presentation layer
    ├── bloc/               # State management
    ├── pages/              # App screens
    └── widgets/            # Reusable widgets
```

## Setup Instructions

### Prerequisites
- Flutter SDK (3.9.2 or higher)
- Dart SDK (included with Flutter)
- Android Studio / VS Code with Flutter extensions

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd task_management
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Build for Production

**Android APK**
```bash
flutter build apk --release
```

**iOS** (macOS only)
```bash
flutter build ios --release
```

**Web**
```bash
flutter build web --release
```

## Key Packages & Why

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter_bloc` | ^8.1.6 | State management with predictable state transitions |
| `equatable` | ^2.0.5 | Value equality for immutable objects |
| `go_router` | ^14.6.2 | Declarative routing with type-safe navigation |
| `hive` | ^2.2.3 | Fast, lightweight local database |
| `hive_flutter` | ^1.1.0 | Flutter integration for Hive |
| `get_it` | ^8.0.0 | Service locator for dependency injection |
| `dartz` | ^0.10.1 | Functional programming with Either type |
| `uuid` | ^4.5.1 | UUID generation for unique identifiers |
| `intl` | ^0.19.0 | Internationalization and date formatting |

## Data Models

### Project
- `id`: Unique identifier
- `name`: Project name
- `description`: Project description
- `archived`: Archive status
- `createdAt`/`updatedAt`: Timestamps

### Task
- `id`: Unique identifier
- `projectId`: Parent project reference
- `title`/`description`: Task details
- `status`: todo, inProgress, blocked, inReview, done
- `priority`: low, medium, high, critical
- `startDate`/`dueDate`: Scheduling
- `estimate`/`timeSpent`: Time tracking (hours)
- `labels`: Tags for categorization
- `assignees`: List of assigned user IDs

### Subtask
- `id`: Unique identifier
- `taskId`: Parent task reference
- `title`: Subtask name
- `status`: todo, inProgress, done
- `assignee`: Optional assignee ID

### User
- `id`: Unique identifier
- `name`/`email`: User details
- `role`: admin or staff

## State Management

The app uses BLoC pattern for state management:

- **ProjectBloc**: Manages project-related state and operations
- **TaskBloc**: Handles task and subtask operations with filtering

### Key Events
- `ProjectFetchRequested`: Load all projects
- `ProjectCreateRequested`: Create new project
- `TaskFetchRequested`: Load tasks for a project
- `TaskFilterChanged`: Apply filters and search

## Repository Pattern

Clean separation between domain and data layers:

```dart
// Domain interface
abstract class ProjectRepository {
  Future<Either<String, List<Project>>> fetchProjects();
  Future<Either<String, Project>> createProject(Project project);
}

// Data implementation
class ProjectRepositoryImpl implements ProjectRepository {
  // Hive-based implementation with simulated network delays
}
```

## UI/UX Features

### Loading States
- Skeleton loading for lists
- Shimmer effects for better perceived performance

### Empty States
- Helpful empty states with call-to-action buttons
- Contextual icons and messaging

### Error Handling
- User-friendly error messages
- Retry mechanisms for failed operations

### Theming
- Material 3 design system
- Light/Dark mode support
- Primary color: #0EA5E9 (Sky Blue)
- Consistent spacing and typography

## Sample Data

The app includes comprehensive sample data:
- 3 sample projects (1 archived)
- 6 sample tasks with various statuses and priorities
- 5 sample subtasks
- 4 sample users (1 admin, 3 staff)

## Known Limitations

1. **No Real Network**: Uses simulated delays (500-800ms) instead of real API calls
2. **Basic Filtering**: Task filtering is implemented but UI controls are pending
3. **Limited Reports**: Project status reports are implemented but UI is pending
4. **No Authentication**: User management is basic without real auth flow
5. **No Offline Sync**: Local-only storage without cloud synchronization

## Future Improvements

### Short Term
- [ ] Complete task filtering UI
- [ ] Implement project reports UI
- [ ] Add task detail page with subtask management
- [ ] Create task creation/editing forms
- [ ] Add user assignment UI

### Medium Term
- [ ] Real API integration
- [ ] User authentication
- [ ] Push notifications
- [ ] File attachments
- [ ] Time tracking improvements

### Long Term
- [ ] Team collaboration features
- [ ] Advanced reporting and analytics
- [ ] Mobile app store deployment
- [ ] Web version optimization
- [ ] Integration with external tools

## Development

### Code Quality
- Null-safe Dart code
- Consistent naming conventions
- Comprehensive error handling
- Immutable state objects

### Testing
- Unit tests for business logic
- Widget tests for UI components
- BLoC tests for state management

### Performance
- Efficient list rendering
- Optimized state updates
- Minimal rebuilds with BLoC

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Screenshots

*Screenshots will be added once the UI is fully implemented*

### Light Mode
- Home page with project list
- Project detail with tasks
- Task creation form

### Dark Mode
- Same screens with dark theme
- Consistent Material 3 design

---

**TaskFlow Mini** - Streamline your project management with a clean, efficient, and user-friendly task management solution.