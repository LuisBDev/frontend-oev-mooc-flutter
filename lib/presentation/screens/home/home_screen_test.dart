import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oev_mobile_app/presentation/providers/auth_provider.dart';

class HomeScreenTest extends ConsumerWidget {
  const HomeScreenTest({super.key});

  static const String name = 'home_screen_test';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2C),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: const Color(0xFF252836),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(17)),
        ),
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo_unmsm.png',
              height: 50,
            ),
            const SizedBox(width: 10),
            const Text('OEV Prime App', style: TextStyle(color: Colors.white)),
          ],
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.grey[700],
            child: const Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF252836),
        selectedItemColor: Colors.cyanAccent,
        unselectedItemColor: Colors.white60,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Mis Cursos'),
          BottomNavigationBarItem(icon: Icon(Icons.video_call), label: 'Conferencias'),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text(
              'Bienvenido, Luis',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const Text(
              'Aprende algo nuevo cada día',
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 20),
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: const Color(0xFF32343E),
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage('assets/images/image_carrusel.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF2A2D3A),
                hintText: 'Buscar por curso o profesor',
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Chip(
              label: Text('Courses', style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.blue,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 4 / 4,
                ),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF32343E),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 13,
                        ),
                        Container(
                            height: 120,
                            decoration: BoxDecoration(
                              color: const Color(0xFF32343E),
                              borderRadius: BorderRadius.circular(12),
                              image: const DecorationImage(
                                image: AssetImage('assets/images/fisinext.png'),
                                fit: BoxFit.cover,
                              ),
                            )),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Spring Boot API Rest Course', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                              SizedBox(height: 4),
                              Text('Carlos Soller', style: TextStyle(color: Colors.white70, fontSize: 12)),
                              SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.people, size: 16, color: Colors.white70),
                                  SizedBox(width: 4),
                                  Text('24.5k', style: TextStyle(color: Colors.white, fontSize: 12)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
