import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oev_mobile_app/presentation/providers/auth_provider.dart';
import 'package:oev_mobile_app/presentation/widgets/conference/conference_list.dart';
import 'package:oev_mobile_app/presentation/widgets/course/course_list.dart';
import 'package:oev_mobile_app/presentation/widgets/course/cursos_inscritos.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String name = 'home_screen';
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: ref.read(authProvider).token?.name ?? 'xdxd test',
        home: Scaffold(
          backgroundColor: const Color(0xffe1e1e2c),
          appBar: AppBar(
            backgroundColor: const Color(0xff2a2c3e),
            leading: Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset('assets/images/logo_unmsm.png'),
            ), // Nuevo widget leading

            actions: [
              IconButton(
                onPressed: () {
                  // context.push('/profile');
                },
                icon: const CircleAvatar(
                  backgroundColor: Colors.white54,
                  child: Icon(
                    Icons.person,
                    color: Color(0xff2a2c3e),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ref.read(authProvider).token?.name ?? 'Usuario',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      ref.read(authProvider).token?.role ?? 'Role',
                      style: const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20), // Espaciado horizontal
              IconButton(
                onPressed: () {
                  ref.read(authProvider.notifier).logout();
                },
                icon: const Icon(
                  Icons.logout,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ],
          ),
          body: _buildBody(),
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: const Color(0xff2a2c3e), // Color de fondo
            ),
            child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home, color: Colors.lightBlue),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu_book, color: Colors.white),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.video_call, color: Colors.white),
                  label: '',
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              showSelectedLabels: false, // No mostrar labels seleccionados
              showUnselectedLabels: false, // No mostrar labels no seleccionados
              // selectedFontSize: 0, // 🔹 Evita el cambio de tamaño del texto
              // unselectedFontSize: 0, // 🔹 Evita el cambio de tamaño del texto
              type: BottomNavigationBarType.fixed, // 🔹 Evita la animación de movimiento
            ),
          ),
        ));
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return const Center(
          child: CourseList(),
          // child: Placeholder(),
        ); // Reemplaza con tu vista
      case 1:
        return const Center(
          child: MyCoursesList(),
        ); // Reemplaza con tu vista
      // Reemplaza con tu vista
      case 2:
        return const Center(
          child: ConferenceList(),
        ); // Reemplaza con tu vista
// Reemplaza con tu vista
      default:
        return const Center(
          child: Text('VistaDefecto', style: TextStyle(color: Colors.white)),
        ); // Reemplaza con tu vista
    }
  }
}
