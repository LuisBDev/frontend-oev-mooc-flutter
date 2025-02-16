import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oev_mobile_app/domain/entities/course/course_model.dart';
import 'package:oev_mobile_app/domain/entities/lesson/lesson_model.dart';
import 'package:oev_mobile_app/presentation/providers/courses_providers/lesson_provider.dart';

class CourseEditableContent extends ConsumerWidget {
  final Course course;

  const CourseEditableContent({super.key, required this.course});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonProviderAsync = ref.watch(lessonProvider(course.id));

    return Scaffold(
      backgroundColor: const Color.fromRGBO(30, 30, 44, 0.996),
      appBar: AppBar(
        title: Text(course.name, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromRGBO(30, 30, 44, 0.996),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                course.imageUrl!,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              course.category ?? "Sin categoría",
              style: const TextStyle(color: Colors.blueAccent, fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              course.name,
              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              course.description!,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 16),
            const Text(
              "Contenido",
              style: TextStyle(color: Colors.blueAccent, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            lessonProviderAsync.when(
                data: (lessons) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: lessons.length,
                    itemBuilder: (context, index) {
                      final lesson = lessons[index];
                      return _CustomCard(lesson: lesson);
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error: $error'))),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text("Agregar recurso"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomCard extends StatelessWidget {
  const _CustomCard({
    required this.lesson,
  });

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[850],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        title: Text(lesson.title, style: const TextStyle(color: Colors.white)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(lesson.duration?.toString() ?? '', style: const TextStyle(color: Colors.white70)),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.remove_circle, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
