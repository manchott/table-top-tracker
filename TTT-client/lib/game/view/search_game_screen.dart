import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:table_top_tracker/common/widget/search_bar.dart';

import '../../bgg/client/bgg_client.dart';

class SearchGameScreen extends StatefulWidget {
  const SearchGameScreen({Key? key}) : super(key: key);

  static String get routeName => 'searchGame';

  static String get routeLocation => '/searchGame';

  @override
  State<SearchGameScreen> createState() => _SearchGameScreenState();
}

class _SearchGameScreenState extends State<SearchGameScreen> {
  late BggClient bggClient;
  String screenShow = '';
  Map<String, dynamic> jsonData = {};
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    Dio dio = Dio();
    bggClient = BggClient(dio);
    super.initState();
  }

  void getBggInfo() async {
    try {
      final resp = await bggClient.searchBgg(_controller.text);
      setState(() {
        screenShow = resp;
        jsonData = json.decode(resp);
      });
    } on DioException catch (e) {
      final statusCode = e.response!.statusCode;
    } catch (e) {
      // Handle non-Dio errors
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomSearchBar(
              controller: _controller,
              onChanged: (text) {
                EasyDebounce.debounce(
                    "search", Duration(milliseconds: 300), getBggInfo);
              },
            ),
            jsonData.isEmpty
                ? Center(child: Text('Empty'))
                : Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(jsonData["items"][index]["name"]),
                              );
                            },
                            itemCount: jsonData["items"].length,
                          ),
                        ),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
