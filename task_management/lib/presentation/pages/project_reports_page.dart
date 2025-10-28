import 'package:flutter/material.dart';

class ProjectReportsPage extends StatelessWidget {
  final String projectId;

  const ProjectReportsPage({
    super.key,
    required this.projectId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Reports'),
      ),
      body: const Center(
        child: Text('Project Reports Page - Coming Soon'),
      ),
    );
  }
}
