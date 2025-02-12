import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oev_mobile_app/presentation/providers/courses_providers/courses_provider.dart';

class CertificateScreen extends ConsumerWidget {
  const CertificateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enrolledCoursesAsync = ref.watch(enrolledCoursesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis Certificados"),
      ),
      body: enrolledCoursesAsync.when(
        data: (courses) {
          final completedCourses = courses.where((course) => course.progress == 100).toList();
          
          if (completedCourses.isEmpty) {
            return const Center(
              child: Text(
                "Aún no tienes cursos completados",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            itemCount: completedCourses.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(completedCourses[index].courseName),
                  leading: const Icon(Icons.assignment_turned_in),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
