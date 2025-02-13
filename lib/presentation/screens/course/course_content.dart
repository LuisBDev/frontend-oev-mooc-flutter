import 'package:flutter/material.dart';
import 'package:oev_mobile_app/domain/entities/dto/course_enrolled.dart';

class Lesson {
  final String title;
  final String duration;
  final bool completed;

  Lesson({
    required this.title,
    required this.duration,
    this.completed = false,
  });
}

class CourseContent extends StatelessWidget {
  final CourseEnrolled courseEnrolled;

  const CourseContent({super.key, required this.courseEnrolled});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(courseEnrolled.courseName, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromRGBO(30, 30, 44, 0.996),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen del curso
          Image.network(
            courseEnrolled.courseImageUrl,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10),

          // Descripción
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   child: Text(
          //     course.description,
          //     style: const TextStyle(fontSize: 16, color: Colors.white70),
          //   ),
          // ),

          const SizedBox(height: 10),

          // Contenido del curso
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Contenido",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return LessonCard(
                  lesson: Lesson(
                    title: "Introducción a Flutter",
                    duration: "6:30",
                    completed: index.isEven,
                  ),
                  index: index + 1,
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromRGBO(30, 30, 44, 0.996),
    );
  }
}

// Subwidget para cada lección
class LessonCard extends StatelessWidget {
  final Lesson lesson;
  final int index;

  const LessonCard({super.key, required this.lesson, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[850],
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(
          lesson.completed ? Icons.check_circle : Icons.radio_button_unchecked,
          color: lesson.completed ? Colors.green : Colors.white,
        ),
        title: Text(
          "Clase $index: ${lesson.title}",
          style: const TextStyle(color: Colors.white),
        ),
        trailing: Text(
          lesson.duration,
          style: const TextStyle(color: Colors.white70),
        ),
        onTap: () {
          // Acción al tocar una lección
        },
      ),
    );
  }
}
