import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oev_mobile_app/domain/entities/course/course_model.dart';
import 'package:oev_mobile_app/infrastructure/shared/course_data_test.dart';
import 'package:oev_mobile_app/presentation/providers/auth_provider.dart';
import 'package:oev_mobile_app/presentation/widgets/course/course_card.dart';

class CourseList extends ConsumerStatefulWidget {
  const CourseList({super.key});

  @override
  ConsumerState<CourseList> createState() => _CourseListState();
}

class _CourseListState extends ConsumerState<CourseList> {
  String _searchTerm = '';
  bool _isLoading = false;
  List<Course> _courses = courseList();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    var filteredCourses = _courses
        .where((curso) =>
            curso.name.toLowerCase().contains(_searchTerm.toLowerCase()))
        .toList();

    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          'Bienvenido, ${ref.read(authProvider).token?.name}',
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const Text(
          'Tenemos sugerencias para ti basadas en tus intereses',
          style: TextStyle(color: Colors.white70),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 180,
          width: 410,
          decoration: BoxDecoration(
            // color: const Color(0xFF32343E),
            borderRadius: BorderRadius.circular(12),
            image: const DecorationImage(
              image: AssetImage('assets/images/image_carrusel.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
          child: SizedBox(
            width: 420,
            child: TextField(
              cursorColor: colors.primary,
              onChanged: (value) {
                setState(() {
                  _searchTerm = value;
                });
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
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text('Cursos',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 4 / 4.6,
                    ),
                    itemCount: filteredCourses.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CourseCard(course: filteredCourses[index]),
                        ],
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }
}
