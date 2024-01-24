import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
      child: Slidable(
        key: ValueKey(id),
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              autoClose: false,
              onPressed: (context) {
                addToFav(id);
              },
              backgroundColor: Color(0xFF7BC043),
              foregroundColor: Colors.white,
              icon: Icons.archive,
              label: '즐겨찾기',
            ),
            SlidableAction(
              onPressed: addToMine,
              backgroundColor: Color(0xFF0392CF),
              foregroundColor: Colors.white,
              icon: Icons.save,
              label: '소유 게임',
            ),
          ],
        ),
        child: ListTile(
          title: Text(name),
          trailing: Text(yearpublished.toString()),
        ),
      ),
    );
  }
}

void addToFav(String id) {
  print(id);
}

void addToMine(BuildContext context) {}
