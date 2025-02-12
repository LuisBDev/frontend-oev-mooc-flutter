import 'package:flutter/material.dart';
import 'package:oev_mobile_app/domain/entities/dto/course_enrolled.dart';

class CourseContent extends StatelessWidget {
  final CourseEnrolled courseEnrolled;

  const CourseContent({super.key, required this.courseEnrolled});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1E1E2C), // 🎨 Fondo oscuro
      appBar: AppBar(
        //title: Text(courseEnrolled.courseName),
        backgroundColor: const Color(0xff1E1E2C), // Color de la AppBar
        iconTheme: const IconThemeData(color: Colors.white), // 🔙 Botón de regreso en blanco
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 📸 Imagen del curso
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  courseEnrolled.courseImageUrl,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),

              // 📜 Información del curso
              Text(
                courseEnrolled.courseName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Texto en blanco
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Instructor: ${courseEnrolled.instructorName}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70, // Texto gris claro
                ),
              ),
              const SizedBox(height: 16),

              // 📊 Progreso del curso
              Text(
                'Progreso: ${courseEnrolled.progress}%',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white, // Texto en blanco
                ),
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: courseEnrolled.progress / 100,
                backgroundColor: Colors.grey[700], // Fondo gris oscuro para barra
                color: Colors.blueAccent, // Color del progreso
                minHeight: 8,
              ),
              const SizedBox(height: 20),

              // 📝 Mensaje Placeholder (A falta de módulos)
              const Center(
                child: Text(
                  'No hay contenido disponible para este curso.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70, // Texto gris claro
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
