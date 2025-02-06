import 'package:flutter/material.dart';

class Course {
  final String name;
  final int progress;
  final bool hasCertificate;
  final String instructor;
  final int students;
  final int lessons;
  final int likes;
  final String imageUrl;

  Course({
    required this.name,
    required this.progress,
    required this.hasCertificate,
    required this.instructor,
    required this.students,
    required this.lessons,
    required this.likes,
    required this.imageUrl,
  });
}

class MyCoursesList extends StatefulWidget {
  const MyCoursesList({super.key});

  @override
  State<MyCoursesList> createState() => _MyCoursesListState();
}

class _MyCoursesListState extends State<MyCoursesList> {
  String _searchTerm = '';
  String _filter = 'Todos';
  bool _isLoading = false;

  final List<Course> _courses = [
    Course(
      name: "Adobe Illustrator desde cero hasta intermedio",
      progress: 65,
      hasCertificate: false,
      instructor: "Sovieshu Vikt",
      students: 24,
      lessons: 9,
      likes: 5000,
      imageUrl: 'assets/images/illustrator.png',
    ),
    Course(
      name: "Blender desde cero hasta convertirte en master",
      progress: 25,
      hasCertificate: false,
      instructor: "Jose Rodriguez",
      students: 32,
      lessons: 12,
      likes: 9000,
      imageUrl: 'assets/images/illustrator.png',
    ),
    Course(
      name: "Ecuaciones diferenciales desde cero hasta avanzado",
      progress: 65,
      hasCertificate: false,
      instructor: "Jose Rodriguez",
      students: 18,
      lessons: 15,
      likes: 7000,
      imageUrl: 'assets/images/illustrator.png',
    ),
    Course(
      name: "Álgebra Lineal desde cero hasta avanzado",
      progress: 100,
      hasCertificate: true,
      instructor: "Jose Rodriguez",
      students: 48,
      lessons: 7,
      likes: 3000,
      imageUrl: 'assets/images/illustrator.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    // Filtrar cursos según el buscador y el filtro activo
    List<Course> filteredCourses = _courses.where((curso) {
      bool matchesSearch = curso.name.toLowerCase().contains(_searchTerm.toLowerCase());
      if (_filter == 'Completados') return matchesSearch && curso.progress == 100;
      if (_filter == 'Certificados') return matchesSearch && curso.hasCertificate;
      return matchesSearch;
    }).toList();

    return Column(
      children: [
        const SizedBox(height: 20),

        // 🗷 Título "Mis Cursos"
        const Padding(
          padding: EdgeInsets.only(top: 20, bottom: 8),
          child: Center(
            child: Text(
              'Mis Cursos',
              style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),

        // 🔍 Barra de búsqueda
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
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
                ),
              ),
            ),
          ),
        ),

        // 📌 Botones de Filtro
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ['Todos', 'Completados', 'Certificados'].map((filter) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _filter = filter;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _filter == filter ? Colors.blueAccent : Colors.grey[800],
                    ),
                    child: Text(filter, style: const TextStyle(color: Colors.white)),
                  ),
                );
              }).toList(),
            ),
          ),
        ),

        // 📜 Lista de Cursos
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 tarjetas por fila
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.85, // Ajuste para evitar overflow
                    ),
                    itemCount: filteredCourses.length.clamp(0, 6), // Máximo 3 filas (6 cursos)
                    itemBuilder: (context, index) {
                      return CursoCard(filteredCourses[index]);
                    },
                  ),
                ),
        ),
      ],
    );
  }
}

// 🎨 Diseño de la Tarjeta de Curso
class CursoCard extends StatelessWidget {
  final Course curso;

  const CursoCard(this.curso, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 📸 Imagen del Curso
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                curso.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // 📜 Información del curso
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    curso.name,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    curso.instructor,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),

                  // 📊 Progreso y Certificado
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Progreso: ${curso.progress}%', style: const TextStyle(color: Colors.white, fontSize: 12)),
                      Icon(curso.hasCertificate ? Icons.check_circle : Icons.close, color: curso.hasCertificate ? Colors.green : Colors.red),
                    ],
                  ),
                  const SizedBox(height: 5),
                  LinearProgressIndicator(
                    value: curso.progress / 100,
                    backgroundColor: Colors.grey,
                    color: Colors.blueAccent,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
