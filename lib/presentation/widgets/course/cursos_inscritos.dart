import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oev_mobile_app/domain/entities/course/course_model.dart';
import 'package:oev_mobile_app/domain/entities/dto/course_enrolled.dart';
import 'package:oev_mobile_app/presentation/providers/auth_provider.dart';
import 'package:oev_mobile_app/presentation/providers/courses_providers/courses_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:oev_mobile_app/presentation/screens/course/course_content.dart';

final searchQueryProvider = StateProvider<String>((ref) => "");
final showCompletedProvider = StateProvider<bool>((ref) => false);

class MyCourses extends ConsumerWidget {
  const MyCourses({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final enrolledCoursesAsync = ref.watch(enrolledCoursesProvider);
    final publishedCoursesAsync = ref.watch(coursesPublishedByInstructorProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final showCompleted = ref.watch(showCompletedProvider);
    final loggedUser = ref.read(authProvider).token;

    final bool isStudentOrAdmin = loggedUser!.role == 'STUDENT' || loggedUser.role == 'ADMINISTRATIVE';

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
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
          child: SizedBox(
            width: 420,
            child: TextField(
              cursorColor: colors.primary,
              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).state = value;
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
              ),
            ),
          ),
        ),

        // Mostrar el switch solo si el usuario es estudiante o administrativo
        if (isStudentOrAdmin)
          SwitchListTile(
            title: const Text('Mostrar solo cursos completados', style: TextStyle(color: Colors.white)),
            value: showCompleted,
            onChanged: (value) => ref.read(showCompletedProvider.notifier).state = value,
          ),

        Expanded(
          child: isStudentOrAdmin
              // --- Para ESTUDIANTE o ADMIN ---
              ? enrolledCoursesAsync.when(
                  data: (courses) {
                    var filteredCourses = courses.where((course) =>
                        course.courseName.toLowerCase().contains(searchQuery.toLowerCase()) &&
                        (!showCompleted || course.progress == 100)).toList();
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 4 / 4.6,
                      ),
                      itemCount: filteredCourses.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => context.push('/course_content', extra: filteredCourses[index]),
                          child: EnrolledCourseCard(enrolledCourse: filteredCourses[index]),
                        );
                      },
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(child: Text('Error: $error')),
                )
              // --- Para INSTRUCTOR ---
              : publishedCoursesAsync.when(
                  data: (courses) {
                    final filteredCourses = courses.where((course) =>
                        course.name.toLowerCase().contains(searchQuery.toLowerCase())).toList();
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 4 / 4.6,
                      ),
                      itemCount: filteredCourses.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => context.push('/course_content', extra: filteredCourses[index]),
                          child: PublishedCourseCard(publishedCourse: filteredCourses[index]),
                        );
                      },
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

// --- Tarjeta de cursos PUBLICADOS por el instructor ---
class PublishedCourseCard extends StatelessWidget {
  final Course publishedCourse;

  const PublishedCourseCard({required this.publishedCourse, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black54,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del curso
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                publishedCourse.imageUrl ?? 'https://via.placeholder.com/150',
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),

            // Nombre del curso
            Text(
              publishedCourse.name,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),

            // Descripción del curso
            Text(
              publishedCourse.description ?? 'Sin descripción',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// --- Tarjeta de cursos ENROLADOS por el estudiante ---
class EnrolledCourseCard extends StatelessWidget {
  final CourseEnrolled enrolledCourse;

  const EnrolledCourseCard({required this.enrolledCourse, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseContent(courseEnrolled: enrolledCourse),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del curso
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                enrolledCourse.courseImageUrl,
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),

            // Nombre del curso
            Text(
              enrolledCourse.courseName,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),

            // Nombre del instructor
            Text(
              enrolledCourse.instructorName,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
