import 'package:flutter/material.dart';

class CreateTaskPage extends StatelessWidget {
  final String projectId;

  const CreateTaskPage({
    super.key,
    required this.projectId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task'),
      ),
      body: const Center(
        child: Text('Create Task Page - Coming Soon'),
      ),
    );
  }
}
