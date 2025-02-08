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
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController nameController;
  late TextEditingController paternalSurnameController;
  late TextEditingController maternalSurnameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    // Initialize with dummy data - replace with actual user data
    nameController = TextEditingController(text: ref.read(authProvider).token?.name ?? '');
    paternalSurnameController = TextEditingController(text: 'Paternal Surname');
    maternalSurnameController = TextEditingController(text: 'Maternal Surname');
    emailController = TextEditingController(text: 'email@example.com');
    passwordController = TextEditingController(text: '********');
    phoneController = TextEditingController(text: '+1234567890');
  }

  @override
  void dispose() {
    nameController.dispose();
    paternalSurnameController.dispose();
    maternalSurnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe1e1e2c),
      appBar: AppBar(
        backgroundColor: const Color(0xff2a2c3e),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(
              isEditing ? Icons.save : Icons.edit,
              color: Colors.white,
            ),
            onPressed: () {
              if (isEditing && _formKey.currentState!.validate()) {
                // Save profile logic here
                setState(() => isEditing = false);
              } else {
                setState(() => isEditing = true);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Color(0xff2a2c3e),
                      child: Icon(Icons.person, size: 50, color: Colors.white),
                    ),
                    if (isEditing)
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
              ),
              const SizedBox(height: 24),
              _buildTextField(
                'Name',
                nameController,
                isEditing,
                (value) => value?.isEmpty == true ? 'Name is required' : null,
              ),
              _buildTextField(
                'Paternal Surname',
                paternalSurnameController,
                isEditing,
                (value) => value?.isEmpty == true ? 'Paternal surname is required' : null,
              ),
              _buildTextField(
                'Maternal Surname',
                maternalSurnameController,
                isEditing,
                (value) => value?.isEmpty == true ? 'Maternal surname is required' : null,
              ),
              _buildTextField(
                'Email',
                emailController,
                isEditing,
                (value) {
                  if (value?.isEmpty == true) return 'Email is required';
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              _buildTextField(
                'Password',
                passwordController,
                isEditing,
                (value) => value?.isEmpty == true ? 'Password is required' : null,
                isPassword: true,
              ),
              _buildTextField(
                'Phone',
                phoneController,
                isEditing,
                (value) => value?.isEmpty == true ? 'Phone is required' : null,
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    bool enabled,
    String? Function(String?)? validator, {
    bool isPassword = false,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        obscureText: isPassword,
        keyboardType: keyboardType,
        validator: validator,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: enabled ? Colors.white : Colors.white70,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white70),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}