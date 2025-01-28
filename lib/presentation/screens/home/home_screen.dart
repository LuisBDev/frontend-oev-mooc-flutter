import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oev_mobile_app/presentation/providers/auth_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const String name = 'home_screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido, ${ref.read(authProvider).token?.name ?? 'Usuario'}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Aprende algo nuevo cada día',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Español',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const ListTile(
              title: Text('Blooming Phantropies Spark'),
              subtitle: Text('¿Qué sigue en materia de innovación en los gobiernos locales?'),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Talleres',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Cursos',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            _buildCourseItem('Adobe Photoshop', 'Aigebra Lineal desde cero hasta avanzado', 'Jose Rodriguez'),
            _buildCourseItem('Adobe Photoshop', 'desde cero hasta intermedio', 'Javier Ellie Trovi'),
            _buildCourseItem('Adobe Photoshop', 'desde cero hasta intermedio', 'Javier Ellie Trovi'),
            _buildCourseItem('Adobe Photoshop', 'desde cero hasta intermedio', 'Javier Ellie Trovi'),
            _buildCourseItem('Adobe Photoshop', 'desde cero hasta avanzado', 'Javier Ellie Trovi'),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    '--- Home ---',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Logout',
                        style: TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        onPressed: () {
                          ref.watch(authProvider.notifier).logout();
                        },
                        icon: const Icon(Icons.logout_outlined),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseItem(String title, String subtitle, String instructor) {
    return ListTile(
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subtitle),
          Text(instructor),
        ],
      ),
    );
  }
}
