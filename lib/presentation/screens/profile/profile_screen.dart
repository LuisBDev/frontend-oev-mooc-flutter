import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oev_mobile_app/presentation/providers/auth_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  static const String name = 'profile_screen';
  
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool isEditing = false;
  bool isDarkMode = true;
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController nameController;
  late TextEditingController paternalSurnameController;
  late TextEditingController maternalSurnameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: ref.read(authProvider).token?.name ?? '');
    paternalSurnameController = TextEditingController(text: 'Paternal Surname');
    maternalSurnameController = TextEditingController(text: 'Maternal Surname');
    emailController = TextEditingController(text: 'email@example.com');
    phoneController = TextEditingController(text: '+1234567890');
  }

  @override
  void dispose() {
    nameController.dispose();
    paternalSurnameController.dispose();
    maternalSurnameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    if (isEditing) {
      final shouldPop = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xff2a2c3e),
          title: const Text('Unsaved Changes', 
            style: TextStyle(color: Colors.white)),
          content: const Text('Do you want to save your changes?',
            style: TextStyle(color: Colors.white70)),
          actions: [
            TextButton(
              child: const Text('Discard', 
                style: TextStyle(color: Colors.red)),
              onPressed: () => Navigator.of(context).pop(true),
            ),
            TextButton(
              child: const Text('Save', 
                style: TextStyle(color: Colors.blue)),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Save changes logic here
                  Navigator.of(context).pop(true);
                }
              },
            ),
          ],
        ),
      );
      return shouldPop ?? false;
    }
    return true;
  }

  Future<void> _showPasswordChangeDialog() async {
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xff2a2c3e),
        title: const Text('Change Password',
          style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'New Password',
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Cancel',
              style: TextStyle(color: Colors.red)),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text('Change',
              style: TextStyle(color: Colors.blue)),
            onPressed: () {
              if (newPasswordController.text == confirmPasswordController.text) {
                // Implement password change logic here
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Passwords do not match')),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: const Color(0xff1a1b26),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () async {
              if (await _onWillPop()) {
                if (context.mounted) context.pop();
              }
            },
          ),
          actions: [
            if (!isEditing)
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.white),
                onPressed: () => setState(() => isEditing = true),
              ),
          ],
          title: const Text('Mi perfil',
            style: TextStyle(color: Colors.white, fontSize: 24)),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey,
                            child: Icon(Icons.person, size: 50, color: Colors.white),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 18,
                              child: IconButton(
                                icon: const Icon(Icons.camera_alt, size: 18),
                                onPressed: () {
                                  // Add photo change logic
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () {
                          // Add photo removal logic
                        },
                        child: const Text('Eliminar foto',
                          style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildTextField('Nombre:', nameController, isEditing),
                _buildTextField('Apellido Paterno:', paternalSurnameController, isEditing),
                _buildTextField('Apellido Materno:', maternalSurnameController, isEditing),
                const SizedBox(height: 24),
                const Text('Datos adicionales',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text(
                  'Llenar estos campos no es obligatorio, sin embargo, te pueden ayudar a personalizar los resultados que muestra la plataforma y aumentar la seguridad de tu cuenta.',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 16),
                _buildTextField('Número de teléfono:', phoneController, isEditing),
                _buildTextField('Correo:', emailController, isEditing),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Cambiar contraseña:',
                    style: TextStyle(color: Colors.white70)),
                  trailing: TextButton(
                    onPressed: _showPasswordChangeDialog,
                    child: const Text('Modificar',
                      style: TextStyle(color: Colors.blue)),
                  ),
                ),
                const SizedBox(height: 24),
                const Text('Tema de la aplicación',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Modo Oscuro',
                    style: TextStyle(color: Colors.white70)),
                  trailing: Switch(
                    value: isDarkMode,
                    onChanged: (value) => setState(() => isDarkMode = value),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size(200, 45),
                    ),
                    onPressed: () {
                      // Implement logout logic
                      ref.read(authProvider.notifier).logout();
                    },
                    child: const Text('Cerrar Sesión'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    bool enabled,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        enabled: enabled,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: enabled ? Colors.white : Colors.white70,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white70),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white24),
          ),
        ),
      ),
    );
  }
}