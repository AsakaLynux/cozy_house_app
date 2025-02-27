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
              builder: (context, state) => HouseDetailScreen(),
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
