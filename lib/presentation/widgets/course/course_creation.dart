import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oev_mobile_app/domain/entities/dto/request/course_dto.dart';
import 'package:oev_mobile_app/presentation/providers/auth_provider.dart';
import 'package:oev_mobile_app/presentation/providers/courses_providers/courses_provider.dart';

class AddCourseScreen extends ConsumerStatefulWidget {
  const AddCourseScreen({super.key});

  @override
  _AddCourseScreenState createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends ConsumerState<AddCourseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final addCourseState = ref.watch(addCourseProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Curso')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre del curso'),
                validator: (value) => value!.isEmpty ? 'El nombre es obligatorio' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                validator: (value) => value!.isEmpty ? 'La descripción es obligatoria' : null,
              ),
              const SizedBox(height: 20),
              addCourseState.isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final newCourse = CourseRequestDTO(
                            name: _nameController.text,
                            description: _descriptionController.text,
                          );
                          int id = ref.read(authProvider).token?.id ?? 0;
                          await ref.read(addCourseProvider.notifier).addCourse(id, newCourse);

                          ref.invalidate(coursesProvider);

                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Curso agregado con éxito')),
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Agregar Curso'),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
