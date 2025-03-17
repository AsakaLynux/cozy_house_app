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
  final bool isFavourite;
  final Function()? onTap;
  const RecommendedTile({
    super.key,
    required this.tileName,
    required this.imageUrl,
    required this.rating,
    required this.price,
    required this.city,
    required this.country,
    required this.onTap,
    this.isFavourite = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      height: 110,
      margin: EdgeInsets.only(bottom: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: SizedBox(
              width: 130,
              height: 110,
              child: Stack(
                children: [
                  Image.network(imageUrl, fit: BoxFit.fill),
                  // Image.asset("assets/photo1.png"),
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
          const SizedBox(width: 15),
          SizedBox(
            width: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tileName,
                  style: blackTextStyle.copyWith(fontSize: 18),
                  overflow: TextOverflow.ellipsis,
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
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          isFavourite
              ? GestureDetector(
                  onTap: onTap,
                  child: Icon(
                    Icons.delete_forever,
                    size: 26,
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
