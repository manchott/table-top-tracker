import 'package:flutter/material.dart';

class GameDetailScreen extends StatefulWidget {
  const GameDetailScreen({Key? key, required this.id}) : super(key: key);

  static String get routeName => 'gameDetail';

  static String get routeLocation => '/gameDetail';

  final String id;

  @override
  State<GameDetailScreen> createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('머임'),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       GoRouter.of(context).go(widget.searchPath);
        //     },
        //     icon: Icon(Icons.search),
        //   )
        // ],
        centerTitle: false,
        // backgroundColor: Colors.transparent,
        titleTextStyle: const TextStyle(color: Colors.black),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [Text(widget.id)],
        ),
      ),
    );
  }
}
