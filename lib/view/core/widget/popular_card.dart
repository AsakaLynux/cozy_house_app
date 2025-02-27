import 'package:flutter/material.dart';

import '../themes/colors.dart';
import '../themes/dimens.dart';
import '../themes/fonts.dart';

class PopularCard extends StatelessWidget {
  final String imageUrl;
  final String cityName;
  const PopularCard({
    super.key,
    required this.imageUrl,
    required this.cityName,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: Dimens.of(context).cardImageWidth,
        height: Dimens.of(context).cardImageHeight,
        color: cardBackgroundColor,
        child: Column(
          children: [
            Image.asset(
              imageUrl,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 11),
            Text(
              cityName,
              style: blackTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
