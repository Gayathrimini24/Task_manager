#  TaskFlow Mini

A mini **Task Management App** built with **Flutter** to manage **Projects → Tasks → Subtasks**, designed for clean architecture, smooth UX, and structured BLoC state management.

---

##  Objective

Build a small task-management app (**TaskFlow Mini**) with the following structure:

> **Projects → Tasks → Subtasks**

The app lets admins and staff manage projects, assign tasks, and track progress efficiently.

---

##  Core Features (MVP)

###  1. Projects
- Create, list, and archive projects.
- **Fields:** `name`, `description`, `archived (bool)`

###  2. Tasks
- Belong to a project.  
- **Fields:**  
  `title`, `description`, `status (todo, inProgress, blocked, inReview, done)`,  
  `priority (low, medium, high, critical)`,  
  `startDate`, `dueDate`,  
  `estimate (hrs)`, `timeSpent (hrs)`,  
  `labels (tags)`, `assignees (staff)`  

- **Admin:** create/update tasks, assign staff  
- **Staff:** update task status and time spent  

###  3. Subtasks
- Belong to a task.  
- **Fields:** `title`, `status`, `optional assignee`

###  4. Assignment
- Admin can assign/unassign staff to a task.

###  5. Status Report (per project)
- Project insights dashboard:
  - **Tiles:** Total tasks, Done, In Progress, Blocked, Overdue, Completion %
  - **Table:** Open tasks by assignee

---

##  Tech & Architecture

###  Tech Stack
- **Framework:** Flutter (Stable, Null-safe Dart)
- **State Management:** `flutter_bloc` + `equatable`
- **Navigation:** `go_router` (or `Navigator 2.0`)
- **Database / Storage:** Local JSON or `Hive` / `Drift`
- **Theming:** Light/Dark with primary color `#0EA5E9`

---

### 🧩 Architecture Overview

