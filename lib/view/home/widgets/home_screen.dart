import 'package:cozy_house_app/view/core/themes/fonts.dart';
import 'package:flutter/material.dart';

import '../../core/themes/colors.dart';
import '../../core/themes/dimens.dart';
import '../../core/ui/popular_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget headerHome() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: Dimens.paddingHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Explore Now",
              style: blackTextStyle.copyWith(fontSize: 24),
            ),
            Text(
              "Mencari kosan yang cozy",
              style: greyTextStyle.copyWith(fontSize: 16),
            ),
          ],
        ),
      );
    }

    Widget popularCities() {
      return Container(
        height: 190,
        margin: EdgeInsets.symmetric(vertical: Dimens.paddingVertical),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: Dimens.paddingHorizontal),
              child: Text(
                "Popular Cities",
                style: blackTextStyle.copyWith(
                    fontSize: 16, fontWeight: FontWeight.normal),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      const SizedBox(width: 24),
                      PopularCard(
                        imageUrl: "assets/city1.png",
                        cityName: "city ${index + 1}",
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headerHome(),
              popularCities(),
            ],
          ),
        ),
      ),
    );
  }
}
