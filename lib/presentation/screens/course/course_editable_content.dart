import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oev_mobile_app/domain/entities/course/course_model.dart';
import 'package:oev_mobile_app/domain/entities/lesson/lesson_model.dart';
import 'package:oev_mobile_app/infrastructure/helpers/video_uploader.dart';
import 'package:oev_mobile_app/presentation/providers/courses_providers/lesson_provider.dart';

final snackbarMessageProvider = StateProvider<String?>((ref) => null);

class CourseEditableContent extends ConsumerWidget {
  final Course course;

  const CourseEditableContent({super.key, required this.course});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonProviderAsync = ref.watch(lessonProvider(course.id));

    ref.listen<String?>(snackbarMessageProvider, (previous, next) {
      if (next != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next, style: const TextStyle(color: Colors.white)),
            backgroundColor: Colors.blueAccent,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );
        ref.read(snackbarMessageProvider.notifier).state = null; // Limpiar mensaje
      }
    });

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
              course.category!,
              style: const TextStyle(color: Colors.blueAccent, fontSize: 16, fontWeight: FontWeight.bold),
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
            Row(
              children: [
                const Text(
                  "Contenido",
                  style: TextStyle(color: Colors.blueAccent, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => ref.refresh(lessonProvider(course.id)),
                  icon: const Icon(Icons.refresh, color: Colors.blueAccent),
                ),
              ],
            ),
            const SizedBox(height: 8),
            lessonProviderAsync.when(
                data: (lessons) {
                  if (lessons.isEmpty) {
                    return const Center(
                      child: Text(
                        "No hay lecciones en este curso",
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    );
                  }
                  return SizedBox(
                    height: 440, // Set a fixed height for the ListView
                    child: ListView.builder(
                      itemCount: lessons.length,
                      itemBuilder: (context, index) {
                        return _CustomLessonCard(lesson: lessons[index]);
                      },
                    ),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error: $error'))),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                onPressed: () => _showAddResourceModal(context, ref, course.id),
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

void _showAddResourceModal(BuildContext context, WidgetRef ref, int courseId) {
  final TextEditingController titleController = TextEditingController();
  File? selectedVideo;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        // Use StatefulBuilder for state changes within the dialog
        builder: (context, setState) {
          // Add setState for updating the button
          return AlertDialog(
            backgroundColor: Colors.grey[900],
            title: const Text(
              'Agregar Lección',
              style: TextStyle(color: Colors.white),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Título de la lección',
                    labelStyle: TextStyle(color: Colors.grey),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final picker = ImagePicker();
                        final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

                        if (pickedFile != null) {
                          setState(() {
                            // Update the state when a video is selected
                            selectedVideo = File(pickedFile.path);
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedVideo != null ? Colors.blue : Colors.grey,
                      ),
                      child: Text(
                        selectedVideo != null ? 'Video Seleccionado' : 'Seleccionar Video', // Conditional text
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Visibility(
                        visible: selectedVideo != null,
                        child: const Icon(
                          Icons.done_all_rounded,
                          color: Colors.blue,
                        )),
                  ],
                ),
              ],
            ),
            actions: [
              OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.grey,
                ),
                child: const Text('Cancelar'),
              ),
              FilledButton(
                onPressed: () async {
                  if (titleController.text.isNotEmpty && selectedVideo != null) {
                    final VideoUploader uploader = VideoUploader();
                    await uploader.uploadLessonVideo(courseId, titleController.text, selectedVideo);
                    ref.invalidate(lessonProvider(courseId));
                    Navigator.of(context).pop();
                  }
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueAccent,
                ),
                child: const Text('Guardar'),
              ),
            ],
          );
        },
      );
    },
  );
}

class _CustomLessonCard extends ConsumerWidget {
  const _CustomLessonCard({required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              onPressed: () async {
                await ref.read(lessonDeleteProvider(lesson.id).future);
                ref.invalidate(lessonProvider(lesson.courseId));
                ref.read(snackbarMessageProvider.notifier).state = "Lección eliminada correctamente";
              },
            ),
          ],
        ),
      ),
    );
  }
}
