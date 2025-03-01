import 'package:flutter/material.dart';

class RegisteredConferencesScreen extends StatelessWidget {
  const RegisteredConferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> mockConferences = [
      {"name": "Flutter Avanzado", "date": "2025-04-15"},
      {"name": "Inteligencia Artificial", "date": "2025-05-10"},
      {"name": "Desarrollo Backend", "date": "2025-06-20"},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E2C),
        title: const Text(
          'Lista de Conferencias Inscritas',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // Lista simulada de conferencias inscritas
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
            child: ListView.builder(
              itemCount: mockConferences.length,
              itemBuilder: (context, index) {
                final conference = mockConferences[index];
                return Card(
                  color: const Color(0xFF242636),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(
                      conference["name"]!,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Fecha: ${conference["date"]}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                    trailing: const Icon(Icons.event, color: Colors.blue),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
