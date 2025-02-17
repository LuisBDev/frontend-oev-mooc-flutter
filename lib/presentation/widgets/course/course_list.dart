import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oev_mobile_app/presentation/providers/auth_provider.dart';
import 'package:oev_mobile_app/presentation/providers/courses_providers/courses_provider.dart';
import 'package:oev_mobile_app/presentation/widgets/course/course_card.dart';

import 'package:go_router/go_router.dart';

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

    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          'Bienvenido, ${loggedUser?.name ?? 'User'}',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const Text(
          'Tenemos sugerencias para ti basadas en tus intereses',
          style: TextStyle(color: Colors.white70),
        ),
        const SizedBox(height: 20),
        Container(
          height: 180,
          width: 410,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: const DecorationImage(
              image: AssetImage('assets/images/image_carrusel.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
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
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
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
              const Text(
                'Cursos',
                style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () => {
                  ref.refresh(coursesProvider),
                },
                icon: const Icon(Icons.refresh_rounded, color: Colors.white),
              ),
            ],
          ),
        ),
        Visibility(
            visible: loggedUser!.role == 'INSTRUCTOR',
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  context.push('/course/create');
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [Text('Crear Curso'), Icon(Icons.add)],
                ),
              ),
            )),
        const SizedBox(height: 10),
        Expanded(
          child: asyncCourses.when(
            data: (courses) {
              // Filtrar los cursos según el término de búsqueda
              final filteredCourses = courses.where((course) => course.name.toLowerCase().contains(searchQuery.toLowerCase())).toList();
              if (filteredCourses.isEmpty) {
                return const Center(
                  child: Text(
                    'No hay cursos publicados',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.builder(
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
