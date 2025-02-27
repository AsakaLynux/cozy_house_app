import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routing/routes.dart';
import 'core/themes/colors.dart';
import 'core/themes/dimens.dart';
import 'core/themes/fonts.dart';
import 'core/widget/custom_button.dart';

class HouseDetailScreen extends StatefulWidget {
  const HouseDetailScreen({super.key});

  @override
  State<HouseDetailScreen> createState() => _HouseDetailScreenState();
}

class _HouseDetailScreenState extends State<HouseDetailScreen> {
  bool isLoveButtonClick = false;
  @override
  Widget build(BuildContext context) {
    Widget mainFacilities() {
      Widget iconDetail(String imageUrl, int qty, String text) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/$imageUrl.png", width: 32, height: 32),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                text: "$qty",
                style: purpleTextStyle,
                children: [TextSpan(text: " $text", style: blackTextStyle)],
              ),
            ),
          ],
        );
      }

      return SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Main Facilities",
              style: blackTextStyle.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                iconDetail("icon_kitchen", 2, "kitchen"),
                iconDetail("icon_bedroom", 3, "bedroom"),
                iconDetail("icon_cupboard", 3, "big drawer"),
              ],
            )
          ],
        ),
      );
    }

    Widget detailTitle() {
      return SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Kuretakeso Hott",
                  style: blackTextStyle.copyWith(fontSize: 22),
                ),
                const SizedBox(height: 2),
                RichText(
                  text: TextSpan(
                    text: "\$52",
                    style: purpleTextStyle.copyWith(fontSize: 16),
                    children: [
                      TextSpan(
                        text: "/ month",
                        style: greyTextStyle.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              child: Row(
                children: [
                  Image.asset(
                    "assets/icon_star.png",
                    width: 20,
                    height: 20,
                  ),
                  Image.asset(
                    "assets/icon_star.png",
                    width: 20,
                    height: 20,
                  ),
                  Image.asset(
                    "assets/icon_star.png",
                    width: 20,
                    height: 20,
                  ),
                  Image.asset(
                    "assets/icon_star.png",
                    width: 20,
                    height: 20,
                  ),
                  Image.asset(
                    "assets/icon_star.png",
                    width: 20,
                    height: 20,
                    color: greyColor,
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget photos() {
      return SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Photos",
              style: blackTextStyle.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 88,
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    width: 110,
                    height: 88,
                    margin: const EdgeInsets.only(right: 18),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: greyColor),
                  );
                },
              ),
            )
          ],
        ),
      );
    }

    Widget location() {
      return SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Location",
              style: blackTextStyle.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 6),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Jln. Kappan Sukses No. 20", style: greyTextStyle),
                      Text("Palembang", style: greyTextStyle),
                    ],
                  ),
                  Image.asset(
                    "assets/btn_map.png",
                    width: 40,
                    height: 40,
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget bottomButton() {
      return SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomButton(
              buttonText: "Book Now",
              buttonWidth: 255,
              onPressed: () => context.go(Routes.main),
            ),
            GestureDetector(
              onTap: () {
                setState(() => isLoveButtonClick
                    ? isLoveButtonClick = false
                    : isLoveButtonClick = true);
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: cardBackgroundColor,
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Center(
                  child: Image.asset(
                    "assets/icon_love.png",
                    width: 26,
                    height: 26,
                    color: isLoveButtonClick ? redColor : greyColor,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/city3.png",
            // width: 375,
            height: 350,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 554,
              padding: EdgeInsets.symmetric(
                  horizontal: Dimens.paddingHorizontal, vertical: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                color: whiteColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  detailTitle(),
                  mainFacilities(),
                  photos(),
                  location(),
                  bottomButton(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
