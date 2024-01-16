import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_top_tracker/common/view/main_screen.dart';
import 'package:table_top_tracker/friend/view/friend_screen.dart';
import 'package:table_top_tracker/game/view/game_detail_screen.dart';
import 'package:table_top_tracker/game/view/game_screen.dart';
import 'package:table_top_tracker/log/view/log_screen.dart';
import 'package:table_top_tracker/mypage/view/mypage_screen.dart';
import 'package:table_top_tracker/tool/view/tool_screen.dart';
import 'package:table_top_tracker/user/model/user_login.dart';
import 'package:table_top_tracker/user/view/login_screen.dart';
import 'package:table_top_tracker/user/view/signin_screen.dart';

import 'common/view/splash_screen.dart';
import 'game/view/search_game_screen.dart';

final _rootKey = GlobalKey<NavigatorState>();
final _searchKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
      navigatorKey: _rootKey,
      debugLogDiagnostics: true,
      initialLocation: GameScreen.routeLocation,
      // initialLocation: MainScreen.routeLocation,
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
        StatefulShellRoute.indexedStack(
          // 메인 루트
          builder: (BuildContext context, GoRouterState state,
              StatefulNavigationShell navigationShell) {
            return MainScreen(navigationShell: navigationShell);
          },
          branches: <StatefulShellBranch>[
            // Game 브랜치
            StatefulShellBranch(
              navigatorKey: _searchKey,
              routes: <RouteBase>[
                GoRoute(
                  path: GameScreen.routeLocation,
                  name: GameScreen.routeName,
                  builder: (BuildContext context, GoRouterState state) =>
                      const GameScreen(),
                  routes: <RouteBase>[
                    GoRoute(
                      path: SearchGameScreen.routeName,
                      builder: (BuildContext context, GoRouterState state) =>
                          const SearchGameScreen(),
                    ),
                    GoRoute(
                      path: '${GameDetailScreen.routeName}/:id',
                      builder: (BuildContext context, GoRouterState state) =>
                          GameDetailScreen(id: state.pathParameters["id"]!),
                    ),
                  ],
                ),
              ],
            ),
            // Log 브랜치
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: LogScreen.routeLocation,
                  name: LogScreen.routeName,
                  builder: (BuildContext context, GoRouterState state) =>
                      const LogScreen(),
                  // routes: <RouteBase>[
                  //   GoRoute(
                  //     path: 'details/:param',
                  //     builder: (BuildContext context, GoRouterState state) =>
                  //         DetailsScreen(
                  //       label: 'B',
                  //       param: state.pathParameters['param'],
                  //     ),
                  //   ),
                  // ],
                ),
              ],
            ),
            // Friend 브랜치
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: FriendScreen.routeLocation,
                  builder: (BuildContext context, GoRouterState state) =>
                      const FriendScreen(),
                  // routes: <RouteBase>[
                  //   GoRoute(
                  //     path: 'details/:param',
                  //     builder: (BuildContext context, GoRouterState state) =>
                  //         DetailsScreen(
                  //       label: 'C',
                  //       param: state.pathParameters['param'],
                  //     ),
                  //   ),
                  // ],
                ),
              ],
            ),
            // Tool 브랜치
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: ToolScreen.routeLocation,
                  builder: (BuildContext context, GoRouterState state) =>
                      const ToolScreen(),
                  // routes: <RouteBase>[
                  //   GoRoute(
                  //     path: 'details/:param',
                  //     builder: (BuildContext context, GoRouterState state) =>
                  //         DetailsScreen(
                  //       label: 'D',
                  //       param: state.pathParameters['param'],
                  //     ),
                  //   ),
                  // ],
                ),
              ],
            ),
            // MyPage 브랜치
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: MyPageScreen.routeLocation,
                  builder: (BuildContext context, GoRouterState state) =>
                      const MyPageScreen(),
                  // routes: <RouteBase>[
                  //   GoRoute(
                  //     path: 'details',
                  //     builder: (BuildContext context, GoRouterState state) =>
                  //         DetailsScreen(
                  //       label: 'E',
                  //       extra: state.extra,
                  //     ),
                  //   ),
                  // ],
                ),
              ],
            ),
          ],
        ),
      ]);
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
  // );
});
