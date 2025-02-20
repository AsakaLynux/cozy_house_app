import 'package:flutter/material.dart';

abstract final class Dimens {
  const Dimens();

  static const paddingHorizontal = 24.0;
  static const paddingVertical = 16.0;

  // Horizontal padding for screen edges
  double get paddingScreenHorizontal;

  // Vertical padding for screen edges
  double get paddingScreenVertical;

  double get cardImageWidth;
  double get cardImageHeight;

  double get tileImageWidth;
  double get tileImageHeight;

  // Horizontal symmentric padding for screen edges
  EdgeInsets get edgeInsetsScreenHorizontal =>
      EdgeInsets.symmetric(horizontal: paddingScreenHorizontal);

  // symmentric padding for screen edges
  EdgeInsets get edgeInsetsScreenVertical => EdgeInsets.symmetric(
        horizontal: paddingScreenVertical,
        vertical: paddingScreenVertical,
      );

  static const Dimens desktop = _DimensDesktop();
  static const Dimens mobile = _DimensMobile();

  factory Dimens.of(BuildContext context) =>
      switch (MediaQuery.sizeOf(context).width) {
        > 600 && < 840 => desktop,
        _ => mobile,
      };
}

// Desktop dimensions
final class _DimensDesktop extends Dimens {
  @override
  final double paddingScreenHorizontal = Dimens.paddingHorizontal;

  @override
  final double paddingScreenVertical = Dimens.paddingVertical;

  @override
  final double cardImageWidth = 120.0;

  @override
  final double cardImageHeight = 150.0;

  @override
  final double tileImageWidth = 130.0;

  @override
  final double tileImageHeight = 110.0;

  const _DimensDesktop();
}

// Mobile dimensions
final class _DimensMobile extends Dimens {
  @override
  final double paddingScreenHorizontal = 48.0;

  @override
  final double paddingScreenVertical = 32.0;

  @override
  final double cardImageWidth = 120.0;

  @override
  final double cardImageHeight = 150.0;

  @override
  final double tileImageWidth = 130.0;

  @override
  final double tileImageHeight = 110.0;

  const _DimensMobile();
}
