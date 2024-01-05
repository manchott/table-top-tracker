import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_top_tracker/common/view/main_screen.dart';
import 'package:table_top_tracker/user/model/user_login.dart';
import 'package:table_top_tracker/user/view/login_screen.dart';

import '../../common/const/colors.dart';
import '../model/user_join.dart';
import '../user_client/user_client.dart';

class SigninScreen extends ConsumerStatefulWidget {
  const SigninScreen({Key? key, required this.data}) : super(key: key);

  final UserLogin data;

  static String get routeName => 'signin';

  static String get routeLocation => '/signin';

  @override
  ConsumerState<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends ConsumerState<SigninScreen> {
  late UserClient userClient;
  late UserLogin userLogin;
  final TextEditingController _nicknameController = TextEditingController();
  String _nickname = '';

  //
  @override
  void initState() {
    Dio dio = Dio();
    userClient = UserClient(dio);
    userLogin = widget.data;
    super.initState();
  }

  Future<void> joinWithNickname() async {
    try {
      final resp = await userClient.join(
        UserJoin(
            email: userLogin.email,
            googleId: userLogin.googleId,
            deviceToken: userLogin.deviceToken,
            nickname: _nickname),
      );
      print('가입 완료');
      // TODO: resp과 provider 연결하기?
      if (!mounted) return;
      context.goNamed(MainScreen.routeName);
    } on DioException catch (e) {
      // Handle Dio error
      print('DioError: $e');
    } catch (e) {
      // Handle non-Dio errors
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Text("닉네임 입력"),
              TextFormField(
                onChanged: (String value) {
                  _nickname = value;
                },
                controller: _nicknameController,
              ),
              ElevatedButton(
                onPressed: joinWithNickname,
                style: ElevatedButton.styleFrom(
                  backgroundColor: PRIMARY_COLOR,
                ),
                child: Text(
                  '회원가입',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (!mounted) return;
                  context.goNamed(LoginScreen.routeName);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: PRIMARY_COLOR,
                ),
                child: Text(
                  '홈으로',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
