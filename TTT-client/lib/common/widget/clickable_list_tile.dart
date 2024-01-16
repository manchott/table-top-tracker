import 'package:flutter/material.dart';

class ClickableListTile extends StatelessWidget {
  final int index;
  final String name;
  final String id;
  final int yearpublished;
  final VoidCallback onTap;
  const ClickableListTile(
      {Key? key,
      required this.index,
      required this.name,
      required this.id,
      required this.yearpublished,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        title: Text(name),
        trailing: Text(yearpublished.toString()),
      ),
    );
  }
}
