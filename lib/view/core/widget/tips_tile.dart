import 'package:flutter/material.dart';

import '../themes/fonts.dart';

class TipsTile extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String updateDate;
  const TipsTile({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.updateDate,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 341,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(imageUrl)),
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: blackTextStyle.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      updateDate,
                      style: greyTextStyle.copyWith(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_outlined,
            size: 24,
          ),
        ],
      ),
    );
  }
}
