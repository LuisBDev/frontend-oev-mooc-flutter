import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  static const String name = 'register_screen';

  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 30, 30, 44), // Fondo del AppBar
      ),
      backgroundColor: const Color.fromARGB(255, 30, 30, 44), // Fondo del Scaffold
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 15),
            const Text(
              'Seleccione su rol',
              style: TextStyle(fontSize: 16, color: Color(0xFFB0B3C6)),
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              items: <String>['Student', 'Instructor', 'Administrative'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
              onChanged: (_) {},
              hint: const Text(
                'Tipo de usuario',
                style: TextStyle(color: Color(0xFFB0B3C6)),
              ),
              isExpanded: true,
              dropdownColor: const Color.fromARGB(255, 52, 54, 70),
            ),
            const SizedBox(height: 35),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      labelStyle: const TextStyle(color: Color(0xFFB0B3C6)),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 52, 54, 70),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey[600]!,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Apellido',
                      labelStyle: const TextStyle(color: Color(0xFFB0B3C6)),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 52, 54, 70),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey[600]!,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Correo Electrónico',
                labelStyle: const TextStyle(color: Color(0xFFB0B3C6)),
                filled: true,
                fillColor: const Color.fromARGB(255, 52, 54, 70),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[600]!),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 25),
            TextField(
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Contraseña',
                labelStyle: const TextStyle(color: Color(0xFFB0B3C6)),
                filled: true,
                fillColor: const Color.fromARGB(255, 52, 54, 70),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[600]!),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 25),
            TextField(
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Confirmar contraseña',
                labelStyle: const TextStyle(color: Color(0xFFB0B3C6)),
                filled: true,
                fillColor: const Color.fromARGB(255, 52, 54, 70),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[600]!),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                // Lógica para el registro
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 52, 54, 70),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: const Text(
                'Registrate',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
