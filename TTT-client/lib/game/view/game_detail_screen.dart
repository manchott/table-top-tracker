import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:xml2json/xml2json.dart';

import '../../bgg/client/bgg_client.dart';
import '../../bgg/model/bgg_detail.dart';

class GameDetailScreen extends StatefulWidget {
  const GameDetailScreen({Key? key, required this.id}) : super(key: key);

  static String get routeName => 'gameDetail';

  static String get routeLocation => '/gameDetail';

  final String id;

  @override
  State<GameDetailScreen> createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> {
  late BggClient bggClient;
  String nameKR = '';
  String description = '';
  String thumbnail = '';
  late Future<void> _bggDetailFuture;

  @override
  void initState() {
    Dio dio = Dio();
    bggClient = BggClient(dio);
    _bggDetailFuture = getBggDetail();
    // getBggDetail();
    super.initState();
  }

  Future<void> getBggDetail() async {
    try {
      final resp = await bggClient.getBgg(widget.id);
      final Xml2Json xml2Json = Xml2Json();
      xml2Json.parse(resp);
      final Map<String, dynamic> jsonMap = json.decode(xml2Json.toBadgerfish());
      // print(jsonMap.toString());
      final BggDetail dataModel = BggDetail.fromJson(jsonMap);
      setState(() {
        nameKR = dataModel.nameKR;
        description = dataModel.description;
        // nameKR = (dataModel.categoryIdList).toString();
        thumbnail = dataModel.thumbnail;
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
      appBar: AppBar(
        title: Text(nameKR),
        centerTitle: false,
        // backgroundColor: Colors.transparent,
        titleTextStyle: const TextStyle(color: Colors.black),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: Future.delayed(Duration(seconds: 2), () {}),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              // Your actual widget hierarchy
              return Column(
                children: [
                  Text(widget.id),
                  Text(nameKR),
                  thumbnail.isNotEmpty
                      ? FractionallySizedBox(
                          widthFactor: 0.25,
                          child: Image.network(
                            thumbnail,
                            fit: BoxFit.fill,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              }
                            },
                            errorBuilder: (context, error, stackTrace) {
                              print(error);
                              return Icon(Icons.error);
                            },
                          ),
                        )
                      : Container(
                          child: Text("no image"),
                          width: MediaQuery.of(context).size.width * .3,
                          height: MediaQuery.of(context).size.width * .4,
                        ),
                  Text("description"),
                  Text(description),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
