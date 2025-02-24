import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oev_mobile_app/presentation/providers/auth_provider.dart';
import 'package:oev_mobile_app/presentation/providers/courses_providers/courses_provider.dart';
import 'package:oev_mobile_app/presentation/widgets/course/course_card.dart';
import 'package:go_router/go_router.dart';
import 'package:oev_mobile_app/presentation/widgets/course/recommended_courses_slider.dart';

// Provider para almacenar el término de búsqueda
final searchQueryProvider = StateProvider<String>((ref) => "");

class CourseList extends ConsumerWidget {
  const CourseList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final asyncCourses = ref.watch(coursesProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final loggedUser = ref.read(authProvider).token;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Bienvenido, ${loggedUser?.name ?? 'User'}',
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const Text(
              'Tenemos sugerencias para ti basadas en tus intereses',
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 20),
            const RecommendedCoursesSlider(),
            const SizedBox(height: 10),
            TextField(
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
            const SizedBox(height: 20),
            Row(
              children: [
                const Text(
                  'Cursos',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => ref.refresh(coursesProvider),
                  icon: const Icon(Icons.refresh_rounded, color: Colors.white),
                ),
              ],
            ),
            if (loggedUser!.role == 'INSTRUCTOR')
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    context.push('/course/create');
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [Text('Crear Curso'), Icon(Icons.add)],
                  ),
                ),
              ),
            const SizedBox(height: 10),
            asyncCourses.when(
              data: (courses) {
                // Filtrar los cursos según el término de búsqueda
                final filteredCourses = courses
                    .where((course) =>
                        course.name.toLowerCase().contains(searchQuery.toLowerCase()))
                    .toList();
                if (filteredCourses.isEmpty) {
                  return const Center(
                    child: Text(
                      'No hay cursos publicados',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  );
                }

                return GridView.builder(
                  shrinkWrap: true, // Ajustar el tamaño al contenido
                  physics: const NeverScrollableScrollPhysics(), // Evita el scroll independiente
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 4 / 4.4,
                  ),
                  itemCount: filteredCourses.length,
                  itemBuilder: (context, index) {
                    return CourseCard(course: filteredCourses[index]);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ],
        ),
      ),
    );
  }
}
