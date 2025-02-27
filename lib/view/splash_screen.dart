import 'package:cozy_house_app/view/core/themes/dimens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routing/routes.dart';
import 'core/themes/colors.dart';
import 'core/themes/fonts.dart';
import 'core/widget/custom_button.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimens.of(context).paddingScreenHorizontal,
                vertical: Dimens.of(context).paddingScreenVertical,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/logo.png", width: 50, height: 50),
                  const SizedBox(height: 30),
                  Text(
                    "Find Cozy House to Stay and Happy",
                    style: blackTextStyle.copyWith(fontSize: 24),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Stop membuang banyak waktu pada tempat yang tidak habitable",
                    style: greyTextStyle.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 40),
                  CustomButton(
                    buttonText: "Explore Now",
                    buttonWidth: 210,
                    onPressed: () => context.go(Routes.main),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                child: Image.asset("assets/splash_image.png"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
