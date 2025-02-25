import 'package:cozy_house_app/view/core/themes/fonts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../routing/routes.dart';
import '../../core/themes/dimens.dart';
import '../../core/ui/popular_card.dart';
import '../../core/ui/recommended_tile.dart';
import '../../core/ui/tips_tile.dart';

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

    Widget recommendedSpace() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: Dimens.paddingHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Recommended Space",
              style: blackTextStyle.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    context.go("${Routes.main}/${Routes.houseDetail}");
                  },
                  child: RecommendedTile(
                    tileName: "Kuretakeso Hott",
                    imageUrl: "assets/space1.png",
                    rating: 4,
                    price: 52,
                    city: "Bandung",
                    country: "Indonesia",
                  ),
                );
              },
            ),
          ],
        ),
      );
    }

    Widget tipsGuidance() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: Dimens.paddingHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tips & Guidance",
              style: blackTextStyle.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 16),
            TipsTile(
              title: "City Guidelines",
              imageUrl: "assets/tips1.png",
              updateDate: "Updated 20 Apr",
            ),
            const SizedBox(height: 20),
            TipsTile(
              title: "Jakarta Fairship",
              imageUrl: "assets/tips2.png",
              updateDate: "Updated 11 Dec",
            ),
          ],
        ),
      );
    }

    return SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headerHome(),
                popularCities(),
                const SizedBox(height: 20),
                recommendedSpace(),
                const SizedBox(height: 20),
                tipsGuidance(),
                const SizedBox(height: 120),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
