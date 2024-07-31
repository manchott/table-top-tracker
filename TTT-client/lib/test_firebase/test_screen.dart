import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_top_tracker/user/provider/user_provider.dart';

import 'firestore_service.dart';

class TestScreen extends ConsumerStatefulWidget {
  static String get routeName => 'test';

  static String get routeLocation => '/test';
  final FirestoreService _firestoreService = FirestoreService();
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends ConsumerState<TestScreen> {
  final _focusNode = FocusNode();
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    List rows = [
      {"name": '', "date": '', "month": '', "status": ''},
      {"name": '', "date": '', "month": '', "status": ''},
      {"name": '', "date": '', "month": '', "status": ''},
      {"name": '', "date": '', "month": '', "status": ''},
    ];
//Headers or Columns
    List headers = [
      {"title": 'Name', 'index': 1, 'key': 'name'},
      {"title": 'Date', 'index': 2, 'key': 'date'},
      {"title": 'Month', 'index': 3, 'key': 'month'},
      {"title": 'Status', 'index': 4, 'key': 'status'},
    ];
    List<List<String>> data = [
      ["Row 1", "1", "2"],
      ["Row 2", "3", "4"],
      ["Row 3", "5", "6"],
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Score Tracking App'),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            _isEditing = false;
          });
          _focusNode.unfocus();
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              DataTable(
                columns: [
                  DataColumn(label: Text('')),
                  DataColumn(label: Text('Column 1')),
                  DataColumn(label: Text('Column 2')),
                ],
                rows: List<DataRow>.generate(
                  data.length,
                  (index) => DataRow(
                    cells: List<DataCell>.generate(
                      data[index].length,
                      (cellIndex) => cellIndex == 0
                          ? DataCell(
                              Text(data[index][cellIndex]),
                            )
                          : DataCell(
                              EditableCell(
                                focusNode: _focusNode,
                                isEditing: _isEditing,
                                initialValue: data[index][cellIndex],
                                onSubmitted: (newValue) {
                                  setState(() {
                                    _isEditing = false;
                                    data[index][cellIndex] = newValue;
                                  });
                                },
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // Column(
      //   children: [
      //     Text(ref.watch(userProvider)),
      //     Text("test"),
      //     Flexible(
      //       child: Editable(
      //         columns: headers,
      //         rows: rows,
      //         showCreateButton: true,
      //         tdStyle: TextStyle(fontSize: 20),
      //         showSaveIcon: false,
      //         borderColor: Colors.grey.shade300,
      //       ),
      //     ),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var userId = ref.watch(userProvider);
          var db = FirebaseFirestore.instance;
          final user = <String, String>{
            "userId": userId,
            "state": "CA",
            "country": "USA"
          };

          db
              .collection("1234")
              .doc("round2")
              .set(user)
              .onError((e, _) => print("Error writing document: $e"));
          // final newRound = await showDialog<Round>(
          //   context: context,
          //   builder: (BuildContext context) {
          //     return NewRoundDialog();
          //   },
          // );
          //
          // if (newRound != null) {
          //   await _firestoreService.addRound(newRound);
          // }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class EditableCell extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String> onSubmitted;
  final FocusNode focusNode;
  bool isEditing;

  EditableCell(
      {super.key,
      required this.initialValue,
      required this.onSubmitted,
      required this.focusNode,
      required this.isEditing});

  @override
  _EditableCellState createState() => _EditableCellState();
}

class _EditableCellState extends State<EditableCell> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return widget.isEditing
        ? TextField(
            controller: _controller,
            autofocus: true,
            focusNode: widget.focusNode,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            onSubmitted: (newValue) {
              setState(() {
                widget.isEditing = false;
                widget.onSubmitted(newValue);
              });
            },
          )
        : GestureDetector(
            onTap: () {
              setState(() {
                widget.isEditing = true;
              });
            },
            child: Container(
              color: Colors.blue,
              child: Text(_controller.text),
            ),
          );
  }

  @override
  void dispose() {
    _controller.dispose();
    widget.focusNode.dispose();
    super.dispose();
  }
}
