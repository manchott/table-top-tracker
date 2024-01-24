import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:table_top_tracker/game/view/game_screen.dart';
import 'package:table_top_tracker/user/client/user_client.dart';
import 'package:table_top_tracker/user/model/user_login.dart';
import 'package:table_top_tracker/user/view/signin_screen.dart';

import '../../common/const/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static String get routeName => 'login';

  static String get routeLocation => '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late UserClient userClient;

  @override
  void initState() {
    Dio dio = Dio();
    userClient = UserClient(dio);
    super.initState();
  }

  void signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final deviceToken = await FirebaseMessaging.instance.getToken();

    // if (googleUser != null) {
    //   print('name = ${googleUser.displayName}');
    //   print('email = ${googleUser.email}');
    //   print('id = ${googleUser.id}');
    // }
    UserLogin userLogin = UserLogin(
        email: googleUser!.email,
        googleId: googleUser.id,
        deviceToken: deviceToken!);

    try {
      final resp = await userClient.login(userLogin);
      print("로그인 완료");
      // TODO: resp과 provider 연결하기?
      if (!mounted) return;
      context.goNamed(GameScreen.routeName);
    } on DioException catch (e) {
      final statusCode = e.response!.statusCode;
      if (statusCode == 404) {
        // 신규 가입
        print('404 Error: Resource not found');
        if (!mounted) return;
        context.goNamed(SigninScreen.routeName, extra: userLogin);
      } else if (statusCode == 403) {
        // 구글이 아닌 다른 것으로 회원 가입한 사용자, 계정연동 여부 물어야함
        print('403 Error: Forbidden');
      } else {
        // Handle other Dio errors
        print('DioError: $e');
      }
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
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _Title(),
                const SizedBox(
                  height: 50,
                ),
                Image.asset(
                  'asset/img/boardgames.png',
                ),
                const SizedBox(
                  height: 50,
                ),
                const _SubTitle(),
                _loginButton(
                  'google_logo',
                  signInWithGoogle,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.goNamed(GameScreen.routeName);
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
        ));
  }

  Widget _loginButton(String path, VoidCallback onTap) {
    return Card(
      elevation: 5.0,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: Ink.image(
        image: AssetImage('asset/img/$path.png'),
        width: 60,
        height: 60,
        child: InkWell(
          borderRadius: const BorderRadius.all(
            Radius.circular(35.0),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Table Top Tracker",
      style: TextStyle(
          fontSize: 34, fontWeight: FontWeight.w500, color: Colors.black),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "- Sign in with -",
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w300, color: BODY_TEXT_COLOR),
    );
  }
}
