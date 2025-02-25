import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oev_mobile_app/presentation/providers/auth_provider.dart';
import 'package:oev_mobile_app/presentation/screens/chatbot/chatbot_screen.dart';
import 'package:oev_mobile_app/presentation/widgets/conference/conference_list.dart';
import 'package:oev_mobile_app/presentation/widgets/course/course_list.dart';
import 'package:oev_mobile_app/presentation/widgets/course/my_courses.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String name = 'home_screen';
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;
  final Color selectedColor = Color(0xFF12CDD9);
  final Color unselectedColor = Colors.white;
  final Color backgroundColor = Color(0xFF252836);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ref.read(authProvider).token?.name ?? 'xdxd test',
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(30, 30, 44, 0.996),
        appBar: AppBar(
          backgroundColor: const Color(0xff2a2c3e),
          leading: Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset('assets/images/logo_unmsm.png'),
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.push('/profile');
              },
              icon: const CircleAvatar(
                backgroundColor: Colors.white54,
                child: Icon(
                  Icons.person,
                  color: Color(0xff2a2c3e),
                ),
              ),
            ),
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
        body: Column(
          children: [
            Expanded(
              child: _buildBody(),
            ),
          ],
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: const Color(0xff2a2c3e),
          ),
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: _selectedIndex == 0 ? selectedColor : unselectedColor),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book, color: _selectedIndex == 1 ? selectedColor : unselectedColor),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.video_call, color: _selectedIndex == 2 ? selectedColor : unselectedColor),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.smart_toy_rounded, color: _selectedIndex == 3 ? selectedColor : unselectedColor),
                label: '',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return const Center(
          child: CourseList(),
        );
      case 1:
        return const Center(
          child: MyCourses(),
        );
      case 2:
        return const Center(
          child: ConferenceList(),
        );
      case 3:
        return Center(child: ChatScreen());
      default:
        return const Center(
          child: Text('VistaDefecto', style: TextStyle(color: Colors.white)),
        );
    }
  }
}
