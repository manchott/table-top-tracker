import 'package:flutter/material.dart';

class ToolScreen extends StatefulWidget {
  const ToolScreen({Key? key}) : super(key: key);

  static String get routeName => 'tool';

  static String get routeLocation => '/tool';

  @override
  State<ToolScreen> createState() => _ToolScreenState();
}

class _ToolScreenState extends State<ToolScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Text('tool')],
      ),
    );
  }
}
