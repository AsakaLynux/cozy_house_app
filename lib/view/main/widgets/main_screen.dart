import 'package:flutter/material.dart';

import '../../core/themes/colors.dart';
import '../../favourite/widgets/favourite_screen.dart';
import '../../home/widgets/home_screen.dart';
import '../../mail/widgets/mail_screen.dart';
import '../../wallet/widgets/wallet_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: PageView(
        children: [
          HomeScreen(),
          MailScreen(),
          WalletScreen(),
          FavouriteScreen()
        ],
      ),
    );
  }
}
