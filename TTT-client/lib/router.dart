import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_top_tracker/common/view/main_screen.dart';
import 'package:table_top_tracker/common/view/splash_screen.dart';
import 'package:table_top_tracker/game/view/game_screen.dart';
import 'package:table_top_tracker/game/view/search_game_screen.dart';
import 'package:table_top_tracker/user/model/user_login.dart';
import 'package:table_top_tracker/user/view/login_screen.dart';
import 'package:table_top_tracker/user/view/signin_screen.dart';

final _key = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _key,
    debugLogDiagnostics: true,
    initialLocation: SearchGameScreen.routeLocation,
    routes: [
      GoRoute(
        path: SplashScreen.routeLocation,
        name: SplashScreen.routeName,
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: LoginScreen.routeLocation,
        name: LoginScreen.routeName,
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: SigninScreen.routeLocation,
        name: SigninScreen.routeName,
        builder: (context, state) {
          UserLogin userLogin =
              state.extra as UserLogin; // -> casting is important
          return SigninScreen(data: userLogin);
        },
      ),
      GoRoute(
        path: MainScreen.routeLocation,
        name: MainScreen.routeName,
        builder: (context, state) {
          return MainScreen();
        },
      ),
      GoRoute(
        path: GameScreen.routeLocation,
        name: GameScreen.routeName,
        builder: (context, state) {
          return GameScreen();
        },
      ),
      GoRoute(
        path: SearchGameScreen.routeLocation,
        name: SearchGameScreen.routeName,
        builder: (context, state) {
          return SearchGameScreen();
        },
      ),
    ],
    // Auth 상태에 따른 redirection
    // redirect: (context, state) {
    //   // If our async state is loading, don't perform redirects, yet
    //   if (authState.isLoading || authState.hasError) return null;
    //
    //   // Here we guarantee that hasData == true, i.e. we have a readable value
    //
    //   // This has to do with how the FirebaseAuth SDK handles the "log-in" state
    //   // Returning `null` means "we are not authorized"
    //   final isAuth = authState.valueOrNull != null;
    //
    //   final isSplash = state.location == SplashScreen.routeLocation;
    //   if (isSplash) {
    //     return isAuth ? HomePage.routeLocation : LoginScreen.routeLocation;
    //   }
    //
    //   final isLoggingIn = state.location == LoginScreen.routeLocation;
    //   if (isLoggingIn) return isAuth ? HomePage.routeLocation : null;
    //
    //   return isAuth ? null : SplashScreen.routeLocation;
    // },
  );
});
