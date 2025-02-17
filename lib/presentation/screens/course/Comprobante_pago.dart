import 'package:flutter/material.dart';

class ComprobantePagoScreen extends StatelessWidget {
  final String courseName;
  final String transactionNumber;

  // Constructor para aceptar datos
  const ComprobantePagoScreen({
    super.key,
    required this.courseName, // Nombre del curso
    required this.transactionNumber, // Número de transacción
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1E1E2C),
      appBar: AppBar(
        backgroundColor: const Color(0xff1E1E2C),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Comprobante de Pago',
            style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título del comprobante
            Text('Comprobante de Pago', style: _titleStyle),
            const SizedBox(height: 20),

            // Información del curso
            Text('Curso: $courseName', style: _textStyle),
            const SizedBox(height: 20),

            // Detalles del pago
            Text('Pago realizado con:', style: _titleStyle),
            Text('Tarjeta de Crédito/Débito', style: _textStyle),
            const SizedBox(height: 20),

            // Detalles de la transacción
            Text('Número de transacción: $transactionNumber',
                style: _textStyle),
            const SizedBox(height: 20),

            // Botón para navegar a otra pantalla
            ElevatedButton(
              onPressed: () {
                // Redirige al contenido del curso
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CursoContentScreen(
                        courseName:
                            courseName), // Aquí pasa el nombre del curso
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Ver Contenido del Curso',
                  style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle get _titleStyle => const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );

  TextStyle get _textStyle => const TextStyle(
        color: Colors.white70,
        fontSize: 14,
      );
}

// Asegúrate de tener esta pantalla en tu código.
class CursoContentScreen extends StatelessWidget {
  final String courseName;

  const CursoContentScreen({super.key, required this.courseName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contenido del Curso: $courseName')),
      body: Center(
        child: Text('Aquí va el contenido del curso: $courseName'),
      ),
    );
  }
}
