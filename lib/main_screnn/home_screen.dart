import 'package:clone_gpt/main_screnn/ai_screen.dart';
import 'package:clone_gpt/main_screnn/post_screen.dart';
import 'package:clone_gpt/main_screnn/profile_screen.dart';
import 'package:clone_gpt/provider/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int selectedIndex = 0;
  final List<Widget> tabs = [
    const AIChatScreen(),
    const PostScreen(),
    const ProfileScreen(),
  ];
  final Color darkMode = Color.fromARGB(180, 0, 0, 0);
  final Color lightMode = Color.fromARGB(255, 0, 0, 0);
  @override
  Widget build(BuildContext context) {
    final themeStatus = Provider.of<MyThemeProvider>(context);
    Color color = themeStatus.themeType ? darkMode : lightMode;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'sontbui',
          style: TextStyle(color: themeStatus.themeType ? darkMode : lightMode),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (themeStatus.themeType) {
                themeStatus.setTheme = false;
              } else {
                themeStatus.setTheme = true;
              }
            },
            icon: Icon(
              themeStatus.themeType
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined,
              color: themeStatus.themeType ? darkMode : lightMode,
            ),
          ),
        ],
      ),
      body: tabs[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: color,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
          currentIndex: selectedIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.telegram),
              label: 'AI Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.post_add),
              label: 'Post',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_pin),
              label: 'Profile',
            ),
          ],
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          }),
    );
  }
}
