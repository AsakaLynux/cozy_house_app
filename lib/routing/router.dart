import 'package:go_router/go_router.dart';

import '../view/favourite/widgets/favourite_screen.dart';
import '../view/home/widgets/home_screen.dart';
import '../view/house_detail/widgets/house_detail_screen.dart';
import '../view/splash/widgets/splash_screen.dart';
import '../view/wallet/widgets/wallet_screen.dart';
import 'routes.dart';

GoRouter router() => GoRouter(
      initialLocation: Routes.home,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: Routes.splash,
          builder: (context, state) {
            return SplashScreen();
          },
        ),
        GoRoute(
          path: Routes.home,
          builder: (context, state) {
            return HomeScreen();
          },
          routes: [
            GoRoute(
              path: Routes.houseDetail,
              builder: (context, state) {
                return HouseDetailScreen();
              },
            ),
            GoRoute(
              path: Routes.wallet,
              builder: (context, state) {
                return WalletScreen();
              },
            ),
            GoRoute(
              path: Routes.favourite,
              builder: (context, state) {
                return FavouriteScreen();
              },
            ),
          ],
        ),
      ],
    );
