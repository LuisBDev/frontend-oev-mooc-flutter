import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Necesario para formatear la fecha

class ComprobantePagoScreen extends StatelessWidget {
  final String courseName;
  final String transactionNumber;
  final double totalAmount = 25.0; // Monto total en soles

  // Constructor para aceptar datos
  const ComprobantePagoScreen({
    super.key,
    required this.courseName, // Nombre del curso
    required this.transactionNumber, // Número de transacción
  });

  @override
  Widget build(BuildContext context) {
    // Generación de la fecha de la transacción
    String transactionDate = _getFormattedDate();

    return Scaffold(
      backgroundColor:
          const Color(0xfff7f7f7), // Fondo más claro para dar aspecto de recibo
      appBar: AppBar(
        backgroundColor: const Color(0xff1E1E2C),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Comprobante de Pago',
            style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Título de la sección, con un borde inferior
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black.withOpacity(0.2), width: 2)),
              ),
              child: Text('Comprobante de Pago', style: _titleStyle),
            ),
            const SizedBox(height: 20),

            // Información del curso, como una sección más destacada
            _buildInfoSection('Curso', courseName),
            const SizedBox(height: 20),

            // Detalles del pago
            _buildInfoSection(
                'Pago realizado con', 'Tarjeta de Crédito/Débito'),
            const SizedBox(height: 20),

            // Detalles de la transacción
            _buildInfoSection('Número de transacción', transactionNumber),
            const SizedBox(height: 20),

            // Fecha de la transacción
            _buildInfoSection('Fecha de transacción', transactionDate),
            const SizedBox(height: 20),

            // Monto total
            _buildInfoSection('Monto Total', 'S/ $totalAmount'),
            const SizedBox(height: 30),

            // Botón para regresar a la lista de cursos
            SizedBox(
              width: double
                  .infinity, // Asegura que el botón ocupe todo el ancho disponible
              child: ElevatedButton(
                onPressed: () {
                  // Redirige a la pantalla de Mis Cursos
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyCoursesScreen(),
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
                child: const Text('Regresar a lista de cursos',
                    style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Función para obtener la fecha actual formateada
  String _getFormattedDate() {
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    final DateTime now = DateTime.now();
    return dateFormat.format(now);
  }

  Widget _buildInfoSection(String title, String content) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: _infoTitleStyle),
          Text(content, style: _infoContentStyle),
        ],
      ),
    );
  }

  TextStyle get _titleStyle => const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      );

  TextStyle get _infoTitleStyle => const TextStyle(
        color: Colors.black54,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      );

  TextStyle get _infoContentStyle => const TextStyle(
        color: Colors.black87,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      );
}

// Asegúrate de tener esta pantalla en tu código.
class MyCoursesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Cursos'),
      ),
      body: Center(
        child: Text('Aquí va la lista de cursos'),
      ),
    );
  }
}
