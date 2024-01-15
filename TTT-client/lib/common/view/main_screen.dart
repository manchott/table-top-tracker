import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:table_top_tracker/game/view/game_screen.dart';

import '../../game/view/search_game_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static String get routeName => 'main';

  static String get routeLocation => '/main';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<String> tabTitles = ['보드게임', '로그', '친구', '편의도구', '마이페이지'];
  static const List<Widget> _widgetOptions = <Widget>[
    GameScreen(),
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: Business',
      style: optionStyle,
    ),
    Text(
      'Index 3: Business',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tabTitles[_selectedIndex]),
        actions: _buildAppBarActions(),
        centerTitle: false,
        // backgroundColor: Colors.transparent,
        titleTextStyle: const TextStyle(color: Colors.black),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_note_rounded),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt),
            label: 'ass',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_fix_high),
            label: 'as',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  List<Widget> _buildAppBarActions() {
    if ([0, 2].contains(_selectedIndex)) {
      // Show search icon only when in the Home tab
      return [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            if (!mounted) return;
            context.pushNamed(SearchGameScreen.routeName);
          },
        ),
      ];
    } else {
      // Don't show any actions in other tabs
      return [];
    }
  }
}
