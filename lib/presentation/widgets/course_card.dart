import 'package:flutter/material.dart';
import 'package:oev_mobile_app/domain/entities/course/course_model.dart';

class CursoCard extends StatelessWidget {
  final Course curso;
  const CursoCard(this.curso, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => CourseDetailPage(curso),
        //   ),
        // );
      },
      child: Container(
        height: 350,
        decoration: BoxDecoration(
          color: const Color(0xFF2A2C3E),
          borderRadius: BorderRadius.circular(10.0), // Redondez de los bordes
        ),
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 210,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0), // Redondez de los bordes
                  image: DecorationImage(
                    image: NetworkImage(curso.imageUrl ?? 'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  curso.name,
                  style: const TextStyle(color: Colors.white, height: 0.9, fontSize: 20.0, fontWeight: FontWeight.w400, overflow: TextOverflow.ellipsis),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 0, 0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 30,
                    ),
                    const SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                      child: Text('${curso.userId}', style: const TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.w400)),
                    ),
                  ],
                )),
            const SizedBox(height: 8),
            const Row(
              children: [
                Spacer(),
                Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite_border,
                          color: Color(0xFF6B6D7F),
                          size: 15,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(4, 0, 8, 0),
                          child: Text('4.5k', style: TextStyle(color: Color(0xFF6B6D7F), fontSize: 15.0, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
