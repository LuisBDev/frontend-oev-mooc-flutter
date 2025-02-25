import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oev_mobile_app/presentation/providers/auth_provider.dart';
import 'package:oev_mobile_app/presentation/providers/courses_providers/courses_provider.dart';
import 'package:oev_mobile_app/presentation/widgets/course/course_card.dart';
import 'package:go_router/go_router.dart';
import 'package:oev_mobile_app/presentation/widgets/course/recommended_courses_slider.dart';

// Provider para almacenar el término de búsqueda
final searchQueryProvider = StateProvider<String>((ref) => "");
final selectedCategoryProvider = StateProvider<String?>((ref) => null);

class CourseList extends ConsumerWidget {
  const CourseList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final asyncCourses = ref.watch(coursesProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final loggedUser = ref.read(authProvider).token;

    // Reiniciar filtros cuando el usuario inicia sesión
    ref.listen(authProvider, (previous, next) {
      ref.read(selectedCategoryProvider.notifier).state = null;
    });

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Bienvenido, ${loggedUser?.name ?? 'User'}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const Text(
              'Tenemos sugerencias para ti basadas en tus intereses',
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 20),
            const RecommendedCoursesSlider(),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
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

              PopupMenuButton<String>(
                icon: const Icon(Icons.filter_list, color: Colors.white),
                onSelected: (value) {
                  ref.read(selectedCategoryProvider.notifier).state = value;
                },
                itemBuilder: (context) => [
                  const PopupMenuItem<String>(
                    enabled: false,
                    child: Text(
                      'Seleccionar categoría',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  ...[
                    'Tecnología y Programación',
                    'Negocios y Emprendimiento',
                    'Diseño',
                    'Ciencias y Matemáticas',
                    'Idiomas',
                    'Desarrollo Personal'
                  ].map((category) {
                    return PopupMenuItem(
                      value: category,
                      child: Text(category, style: const TextStyle(color: Colors.white)),
                    );
                  }).toList(),
                ],
                color: Colors.black, // Fondo negro para el menú desplegable
                ),



              ],
            ),
            if (selectedCategory != null)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF207090),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      selectedCategory,
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        ref.read(selectedCategoryProvider.notifier).state = null;
                      },
                      child: const Icon(Icons.close, color: Colors.white, size: 16),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Text(
                  'Cursos',
                  style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
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
                final filteredCourses = courses.where((course) {
                  final matchesSearch = course.name.toLowerCase().contains(searchQuery.toLowerCase());
                  final matchesCategory = selectedCategory == null || course.category == selectedCategory;
                  return matchesSearch && matchesCategory;
                }).toList();

                if (filteredCourses.isEmpty) {
                  return const Center(
                    child: Text(
                      'No hay cursos publicados',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  );
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
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
