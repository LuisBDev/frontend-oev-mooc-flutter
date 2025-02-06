import 'package:flutter/material.dart';
import 'package:oev_mobile_app/domain/entities/course/course_model.dart';
import 'package:oev_mobile_app/infrastructure/shared/course_data_test.dart';
import 'package:oev_mobile_app/presentation/widgets/course_card.dart';

class CourseList extends StatefulWidget {
  const CourseList({super.key});

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
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
        const Text(
          'Bienvenido, Luis',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const Text(
          'Aprende algo nuevo cada día',
          style: TextStyle(color: Colors.white70),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 180,
          decoration: BoxDecoration(
            // color: const Color(0xFF32343E),
            borderRadius: BorderRadius.circular(12),
            image: const DecorationImage(
              image: AssetImage('assets/images/image_carrusel.png'),
              fit: BoxFit.fitHeight,
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
              :
              // : ListView(
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.fromLTRB(40, 0, 40, 8),
              //         child: Builder(
              //           builder: (BuildContext context) {
              //             if (filteredCourses.isEmpty) {
              //               return const Center(
              //                 child: Column(
              //                   children: <Widget>[
              //                     Text('No se encontraron cursos', style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold)),
              //                   ],
              //                 ),
              //               );
              //             } else {
              //               return Column(
              //                 children: [
              //                   const SizedBox(
              //                     height: 20,
              //                   ),
              //                   Align(
              //                     alignment: Alignment.topCenter,
              //                     child: Wrap(
              //                       children: [
              //                         ...filteredCourses.map((curso) => Column(
              //                               children: [
              //                                 CursoCard(curso),
              //                                 const SizedBox(
              //                                   height: 25,
              //                                 )
              //                               ],
              //                             ))
              //                       ],
              //                     ),
              //                   ),
              //                 ],
              //               );
              //             }
              //           },
              //         ),
              //       )
              //     ],
              //   ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 4 / 4,
                    ),
                    itemCount: courseList().length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF32343E),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 13,
                            ),
                            Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF32343E),
                                  borderRadius: BorderRadius.circular(12),
                                  image: const DecorationImage(
                                    image: AssetImage('assets/images/fisinext.png'),
                                    fit: BoxFit.cover,
                                  ),
                                )),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Spring Boot API Rest Course', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                                  SizedBox(height: 4),
                                  Text('Carlos Soller', style: TextStyle(color: Colors.white70, fontSize: 12)),
                                  SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(Icons.people, size: 16, color: Colors.white70),
                                      SizedBox(width: 4),
                                      Text('24.5k', style: TextStyle(color: Colors.white, fontSize: 12)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }
}
