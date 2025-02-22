import 'package:flutter/material.dart';

import '../themes/colors.dart';
import '../themes/fonts.dart';

class RecommendedTile extends StatelessWidget {
  final String tileName;
  final String imageUrl;
  final int rating;
  final int price;
  final String city;
  final String country;
  const RecommendedTile({
    super.key,
    required this.tileName,
    required this.imageUrl,
    required this.rating,
    required this.price,
    required this.city,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 329,
      height: 110,
      margin: EdgeInsets.only(bottom: 30),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: SizedBox(
              width: 130,
              height: 110,
              child: Stack(
                children: [
                  Image.asset(imageUrl),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 70,
                      height: 30,
                      decoration: BoxDecoration(
                        color: purpleColor,
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(20)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/icon_star.png",
                              width: 18, height: 18),
                          const SizedBox(width: 2),
                          Text(
                            "$rating/5",
                            style: whiteTextStyle.copyWith(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tileName,
                style: blackTextStyle.copyWith(fontSize: 18),
              ),
              RichText(
                text: TextSpan(
                  text: "\$$price",
                  style: purpleTextStyle.copyWith(fontSize: 18),
                  children: [
                    TextSpan(
                      text: " / month",
                      style: greyTextStyle.copyWith(fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "$city, $country",
                style: greyTextStyle.copyWith(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
