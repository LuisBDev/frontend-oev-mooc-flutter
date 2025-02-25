import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oev_mobile_app/domain/entities/conference/conference_model.dart';
import 'package:oev_mobile_app/presentation/providers/conferences_providers/conferences_provider.dart';

class ConferenceeDetailPage extends ConsumerWidget {
  final int conferenceId;

  const ConferenceeDetailPage({super.key, required this.conferenceId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conferenceAsync = ref.watch(conferenceByIdProvider(conferenceId));

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E2C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: conferenceAsync.when(
        data: (conference) => _buildCourseDetail(context, conference),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Text("Error: $err", style: const TextStyle(color: Colors.red)),
        ),
      ),
    );
  }

  Widget _buildCourseDetail(BuildContext context, Conference conference) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              conference.imageUrl ?? '',
              width: double.infinity,
              height: 180,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),

          // Nombre del curso
          Text(
            conference.name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),

          // Fila con cantidad de alumnos, costo y favoritos
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Icon(Icons.category, color: Colors.white70),
                    const SizedBox(height: 5),
                    Text("${conference.category}",
                        style: const TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const Icon(Icons.people, color: Colors.white70),
                    const SizedBox(height: 5),
                    Text("${conference.totalStudents}",
                        style: const TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const Icon(Icons.update, color: Colors.white70),
                    const SizedBox(height: 5),
                    Text(
                      conference.lastUpdate != null
                          ? conference.lastUpdate!
                              .toLocal()
                              .toString()
                              .split(' ')[0]
                          : '',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Nombre del creador
          Text(
            "Organizador: ${conference.creatorName}",
            style: const TextStyle(fontSize: 16, color: Colors.white70),
          ),
          const SizedBox(height: 16),

          // Última actualización
          Text(
            //"Fecha de la conferencia: ${conference.date}",
            "Fecha de la conferencia: 22 de octubre de 2021",
            style: const TextStyle(fontSize: 16, color: Colors.white70),
          ),

          const SizedBox(height: 20),

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
          _buildSection("Descripción", conference.description),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String? content) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF242636),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content ?? "No disponible.",
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
