import 'package:flutter/material.dart';
import 'package:oev_mobile_app/domain/entities/course/course_model.dart';

class CourseDetailPage extends StatelessWidget {
  final Course course;

  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E2C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                course.imageUrl ?? '',
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // Nombre del curso
            Text(
              course.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),

            // Fila con cantidad de alumnos, costo y favoritos
            const Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Icon(Icons.people, color: Colors.white70),
                      SizedBox(height: 5),
                      Text("27", style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Icon(Icons.attach_money, color: Colors.white70),
                      SizedBox(height: 5),
                      Text("\S. 49.99",
                          style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Icon(Icons.favorite, color: Colors.redAccent),
                      SizedBox(height: 5),
                      Text("320", style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Nombre del instructor
            Text(
              "Docente: Carlos Soller",
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 16),

            // Botón de Inscribirse
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Acción de inscripción
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Inscribirse',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Sección de Descripción
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF242636),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Descripción",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    course.description ?? "No hay descripción disponible.",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Sección "Lo que aprenderás"
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF242636),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Lo que aprenderás",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("• Usar las diferentes herramientas de Illustrator",
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                      SizedBox(height: 5),
                      Text("• Crear y formatear texto",
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                      SizedBox(height: 5),
                      Text("• Exportar gráficos para web",
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                      SizedBox(height: 5),
                      Text("• Preparar archivos para impresión comercial",
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                      SizedBox(height: 5),
                      Text("• Vectorizar imágenes y ajustar vectores",
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Sección "¿Para quién es este curso?"
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF242636),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "¿Para quién es este curso?",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("• Diseñadores gráficos y principiantes",
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                      SizedBox(height: 5),
                      Text("• Estudiantes de arte y diseño",
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                      SizedBox(height: 5),
                      Text(
                          "• Cualquier persona interesada en ilustración digital",
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
