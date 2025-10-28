import 'package:flutter/material.dart';

class TaskDetailPage extends StatelessWidget {
  final String projectId;
  final String taskId;

  const TaskDetailPage({
    super.key,
    required this.projectId,
    required this.taskId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
      ),
      body: const Center(
        child: Text('Task Detail Page - Coming Soon'),
      ),
    );
  }
}
