import 'package:flutter/material.dart';
import 'package:oev_mobile_app/domain/entities/dto/course_enrolled.dart';
import 'package:oev_mobile_app/presentation/screens/course/certificado_pago.dart'; // Importa la pantalla de pago

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
      backgroundColor: const Color(0xff1E1E2C), // 🎨 Fondo oscuro
      appBar: AppBar(
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
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 440, // Set a fixed height for the ListView
                child: ListView.builder(
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return LessonCard(lesson: Lesson(title: 'Lección $index', duration: '10:00'), index: index + 1);
                  },
                ),
              ),
              const SizedBox(height: 20),

              // 💳 Botón para pagar certificado
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CertificadoPagoScreen(courseEnrolled: courseEnrolled),
                      ),
                    );
                  },
                  icon: const Icon(Icons.payment, color: Colors.white),
                  label: const Text('Pagar Certificado'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Color del botón
                    foregroundColor: Colors.white, // Texto blanco
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              // 📝 Mensaje Placeholder (A falta de módulos)
            ],
          ),
        ),
      ),
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
      color: Colors.grey[900],
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
