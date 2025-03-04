import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../view/house_detail_screen.dart';
import '../view/main_screen.dart';
import '../view/splash_screen.dart';
import 'routes.dart';

GoRouter router() => GoRouter(
      initialLocation: "${Routes.main}/${Routes.houseDetail}",
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: Routes.splash,
          builder: (context, state) => SplashScreen(),
        ),
        GoRoute(
          path: Routes.main,
          builder: (context, state) => MainScreen(),
          routes: [
            GoRoute(
              path: Routes.houseDetail,
              pageBuilder: (context, state) {
                final id = int.parse(state.pathParameters["id"]!);
                return CustomTransitionPage(
                  key: state.pageKey,
                  child: HouseDetailScreen(placeId: id),
                  transitionDuration: const Duration(milliseconds: 300),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    // Change the opacity of the screen using a Curve based on the the animation's
                    // value
                    return FadeTransition(
                      opacity:
                          CurveTween(curve: Curves.linear).animate(animation),
                      child: child,
                    );
                  },
                );
              },
              // builder: (context, state) => HouseDetailScreen(),
            ),
            // GoRoute(
            //   path: Routes.home,
            //   builder: (context, state) => HomeScreen(),
            //   routes: [

            //   ],
            // ),
            // GoRoute(
            //   path: Routes.wallet,
            //   builder: (context, state) => WalletScreen(),
            // ),
            // GoRoute(
            //   path: Routes.favourite,
            //   builder: (context, state) => FavouriteScreen(),
            // ),
          ],
        ),
      ],
    );
