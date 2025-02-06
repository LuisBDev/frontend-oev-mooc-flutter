import 'package:flutter/material.dart';
import 'package:oev_mobile_app/domain/entities/course/course_model.dart';
import 'package:oev_mobile_app/infrastructure/shared/course_data_test.dart';
import 'package:oev_mobile_app/presentation/widgets/course_card.dart';

class MyCoursesList extends StatefulWidget {
  const MyCoursesList({super.key});

  @override
  State<MyCoursesList> createState() => _MyCoursesListState();
}

class _MyCoursesListState extends State<MyCoursesList> {
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
    var filteredCourses = _courses.where((curso) => curso.name.toLowerCase().contains(_searchTerm.toLowerCase())).toList();

    return Column(
      children: [
        const SizedBox(height: 20),
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
              decoration: const InputDecoration(
                  hintText: 'Buscar por curso o profesor',
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
                  )),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text('Cursos', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 8),
                      child: Builder(
                        builder: (BuildContext context) {
                          if (filteredCourses.isEmpty) {
                            return const Center(
                              child: Column(
                                children: <Widget>[
                                  Text('No se encontraron cursos', style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            );
                          } else {
                            return Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Wrap(
                                    children: [
                                      ...filteredCourses.map((curso) => Column(
                                            children: [
                                              CursoCard(curso),
                                              const SizedBox(
                                                height: 25,
                                              )
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
        )
      ],
    );
  }
}
