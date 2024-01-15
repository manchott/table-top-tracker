import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:table_top_tracker/bgg/client/bgg_client.dart';
import 'package:table_top_tracker/user/view/login_screen.dart';
import 'package:xml2json/xml2json.dart';

import '../../bgg/model/bgg_detail.dart';
import '../../common/const/colors.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  static String get routeName => 'game';

  static String get routeLocation => '/game';

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late BggClient bggClient;
  String jsonDataInScreen = '';
  String imageUrl = '';

  @override
  void initState() {
    Dio dio = Dio();
    bggClient = BggClient(dio);
    super.initState();
  }

  void getBggInfo() async {
    try {
      final resp = await bggClient.getBgg();
      // print(resp);
      final Xml2Json xml2Json = Xml2Json();
      xml2Json.parse(resp);
      final Map<String, dynamic> jsonMap = json.decode(xml2Json.toBadgerfish());
      print(jsonMap);
      final BggDetail dataModel = BggDetail.fromJson(jsonMap);
      print(dataModel.nameKR);
      print("??");
      setState(() {
        jsonDataInScreen = dataModel.nameKR;
        imageUrl = dataModel.thumbnail;
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
    return Container(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
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
              ),
              ElevatedButton(
                onPressed: getBggInfo,
                child: Text('get bgg'),
              ),
              imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return CircularProgressIndicator();
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.error);
                      },
                    )
                  : Text('Press the button to load an image'),
              Text(jsonDataInScreen)
            ],
          ),
        ),
      ),
    );
  }
}
