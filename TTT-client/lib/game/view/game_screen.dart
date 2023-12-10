import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:table_top_tracker/user/view/login_screen.dart';

import '../../common/const/colors.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  static String get routeName => 'game';

  static String get routeLocation => '/game';

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Text("Game Screen"),
              ElevatedButton(
                onPressed: () {
                  if (!mounted) return;
                  context.goNamed(LoginScreen.routeName);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: PRIMARY_COLOR,
                ),
                child: Text(
                  'Game Page',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
