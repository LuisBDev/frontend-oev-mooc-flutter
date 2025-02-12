import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oev_mobile_app/domain/entities/dto/course_enrolled.dart';
import 'package:oev_mobile_app/presentation/providers/auth_provider.dart';
import 'package:oev_mobile_app/presentation/providers/courses_providers/courses_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:oev_mobile_app/presentation/screens/course/course_content.dart';

// Provider para almacenar el término de búsqueda
final searchQueryProvider = StateProvider<String>((ref) => "");

class MyCourses extends ConsumerWidget {
  const MyCourses({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final enrolledCoursesAsync = ref.watch(enrolledCoursesProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final loggedUser = ref.read(authProvider).token;

    return Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          'Sección de cursos',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const Text(
          'Continúa donde lo dejaste',
          style: TextStyle(color: Colors.white70),
        ),
        const SizedBox(height: 20),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
          child: SizedBox(
            width: 420,
            child: TextField(
              cursorColor: colors.primary,
              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).update((state) => value);
              },
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Buscar por curso',
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Color(0xff343646),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                (loggedUser!.role == 'STUDENT' || loggedUser.role == 'ADMINISTRATIVE') ? 'Cursos Inscritos' : 'Cursos Impartidos',
                style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () => {
                  ref.refresh(enrolledCoursesProvider),
                },
                icon: const Icon(Icons.refresh_rounded, color: Colors.white),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: enrolledCoursesAsync.when(
            data: (courses) {
              // Filtrar los cursos según el término de búsqueda
              final filteredCourses = courses.where((course) => course.courseName.toLowerCase().contains(searchQuery.toLowerCase())).toList();

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 4 / 4.6,
                  ),
                  itemCount: filteredCourses.length,
                  itemBuilder: (context, index) {
                    return _EnrolledCourseCard(enrolledCourse: filteredCourses[index]);
                  },
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Error: $error')),
          ),
        ),
      ],
    );
  }
}

// 🎨 Diseño de la Tarjeta de Curso
class _EnrolledCourseCard extends StatelessWidget {
  final CourseEnrolled enrolledCourse;

  const _EnrolledCourseCard({required this.enrolledCourse});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseContent(courseEnrolled: enrolledCourse),
          ),
        )
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📸 Imagen del Curso
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  enrolledCourse.courseImageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // 📜 Información del curso
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      enrolledCourse.courseName,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      enrolledCourse.instructorName,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),

                    // 📊 Progreso y Certificado
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Progreso: ${enrolledCourse.progress}%', style: const TextStyle(color: Colors.white, fontSize: 12)),
                        // Icon(curso.hasCertificate ? Icons.check_circle : Icons.close, color: curso.hasCertificate ? Colors.green : Colors.red),
                      ],
                    ),
                    const SizedBox(height: 5),
                    LinearProgressIndicator(
                      value: enrolledCourse.progress / 100,
                      backgroundColor: Colors.grey,
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
