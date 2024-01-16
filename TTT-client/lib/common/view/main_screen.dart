import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../game/view/search_game_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required this.navigationShell}) : super(key: key);
  final StatefulNavigationShell navigationShell;

  static String get routeName => 'main';

  static String get routeLocation => '/main';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> tabTitles = ['보드게임', '로그', '친구', '편의도구', '마이페이지'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: widget.navigationShell),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset),
            label: '게임',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_note_rounded),
            label: '로그',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt),
            label: '친구',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_fix_high),
            label: '도구',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt),
            label: '마이페이지',
          ),
        ],
        currentIndex: widget.navigationShell.currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: (int index) => _onTap(context, index),
      ),
    );
  }

  List<Widget> _buildAppBarActions() {
    if ([0, 2].contains(widget.navigationShell.currentIndex)) {
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

  /// Navigate to the current location of the branch at the provided index when
  /// tapping an item in the BottomNavigationBar.
  void _onTap(BuildContext context, int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }
}
