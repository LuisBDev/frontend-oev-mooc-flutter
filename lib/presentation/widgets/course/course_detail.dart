import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oev_mobile_app/domain/entities/course/course_model.dart';
import 'package:oev_mobile_app/presentation/providers/courses_providers/courses_provider.dart';
import 'package:oev_mobile_app/presentation/providers/courses_providers/lesson_provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/courses_providers/enrollment_provider.dart';

class CourseDetailPage extends ConsumerWidget {
  final int courseId;

  const CourseDetailPage({super.key, required this.courseId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courseAsync = ref.watch(courseByIdProvider(courseId));
    final loggedUser = ref.read(authProvider).token;
    final isInstructor = loggedUser?.role == 'INSTRUCTOR';

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E2C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (isInstructor)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.white),
              onPressed: () => _showDeleteConfirmation(context, ref, courseId),
            ),
        ],
      ),
      body: courseAsync.when(
        data: (course) => _buildCourseDetail(context, ref, course),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Text("Error: $err", style: const TextStyle(color: Colors.red)),
        ),
      ),
    );
  }

  Widget _buildCourseDetail(BuildContext context, WidgetRef ref, Course course) {
    final loggedUser = ref.read(authProvider).token;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              course.imageUrl ?? '',
              width: double.infinity,
              height: 180,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),

          // Nombre del curso
          Text(
            course.name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),

          // Fila con cantidad de alumnos, costo y favoritos
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Icon(Icons.people, color: Colors.white70),
                    const SizedBox(height: 5),
                    Text("${course.totalStudents}", style: const TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const Icon(Icons.attach_money, color: Colors.white70),
                    const SizedBox(height: 5),
                    Text("S/. ${course.price}", style: const TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const Icon(Icons.favorite, color: Colors.redAccent),
                    const SizedBox(height: 5),
                    Text("${course.favorite}", style: const TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Nombre del instructor
          Text(
            "Docente: ${course.instructorName}",
            style: const TextStyle(fontSize: 16, color: Colors.white70),
          ),
          const SizedBox(height: 16),

          // Botón de Inscribirse
          Visibility(
            visible: loggedUser?.role == 'STUDENT',
            child: Center(
              child: ElevatedButton(
                onPressed: () => _showEnrollmentConfirmation(context, ref, course.id),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Inscribirse',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Sección de Descripción
          _buildSection("Descripción", course.description),
          const SizedBox(height: 16),

          // Sección "Lo que aprenderás"
          _buildSection("Lo que aprenderás", course.benefits),
          const SizedBox(height: 16),

          // Sección "¿Para quién es este curso?"
          _buildSection("¿Para quién es este curso?", course.targetAudience),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Confirmation Modal
  void _showEnrollmentConfirmation(BuildContext context, WidgetRef ref, int courseId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF242636),
          title: const Text('Confirmación', style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold)),
          content: const Text('¿Seguro que quieres inscribirte el curso?', style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.normal)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: const Text('Cancelar', style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold)),
            ),
            FilledButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                // Aquí puedes añadir tu lógica para agregar el curso a la cesta
                Navigator.of(context).pop(); // Cierra el diálogo
                _enrollUser(ref, courseId);
              },
              child: const Text('Aceptar', style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  // Enroll User Function
  void _enrollUser(WidgetRef ref, int courseId) {
    final userId = ref.read(authProvider).token?.id;
    if (userId == null) {
      ScaffoldMessenger.of(ref.context).showSnackBar(
        const SnackBar(content: Text('Error: Usuario no autenticado')),
      );
      return;
    }

    final enrollmentData = {'userId': userId, 'courseId': courseId};
    ref.read(enrollmentProvider(enrollmentData).future).then((success) {
      if (success) {
        // Show success message
        ScaffoldMessenger.of(ref.context).showSnackBar(
          const SnackBar(content: Text('Inscripción exitosa!')),
        );
      } else {
        // Show error message
        ScaffoldMessenger.of(ref.context).showSnackBar(
          const SnackBar(content: Text('Error al inscribirse')),
        );
      }
    }).catchError((error) {
      // Show error message
      ScaffoldMessenger.of(ref.context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    });
  }

  Widget _buildSection(String title, String? content) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF242636),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content ?? "No disponible.",
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
  Future<void> _showDeleteConfirmation(BuildContext context, WidgetRef ref, int courseId) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E2C),
          title: const Text('Confirmar eliminación', style: TextStyle(color: Colors.white)),
          content: const Text(
            'Esta acción eliminará el curso, todas sus lecciones y las inscripciones de los estudiantes. ¿Estás seguro de continuar?',
            style: TextStyle(color: Colors.white70)
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar', style: TextStyle(color: Colors.white70)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (result ?? false) {
      // Mostrar diálogo de progreso 

      try {
        // 1. Obtener y eliminar estudiantes inscritos
        final enrolledUsers = await ref.read(enrolledUsersProvider(courseId).future);
        for (var user in enrolledUsers) {
          await ref.read(deleteEnrollmentProvider.notifier).deleteEnrollment(user['id']);
        }

        // 2. Obtener y eliminar lecciones
        final lessons = await ref.read(lessonProvider(courseId).future);
        for (var lesson in lessons) {
          await ref.read(lessonDeleteProvider(lesson.id).future);
        }

        // 3. Eliminar el curso
        await ref.read(deleteCourseProvider.notifier).deleteCourse(courseId);

        // Cerrar diálogo de progreso y mostrar mensaje de éxito
        if (context.mounted) {
          Navigator.pop(context); // Cerrar diálogo de progreso
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Curso eliminado correctamente')),
          );
          context.go('/home'); // Navegar a la página principal
        }
      } catch (e) {
        // Manejar error
        if (context.mounted) {
          Navigator.pop(context); // Cerrar diálogo de progreso
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al eliminar el curso: $e')),
          );
        }
      }
    }
  }
}
