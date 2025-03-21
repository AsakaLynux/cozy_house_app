import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../domain/models/place_model.dart';
import '../domain/services/favourite_services.dart';
import '../domain/services/place_service.dart';
import '../routing/routes.dart';
import 'core/themes/colors.dart';
import 'core/themes/dimens.dart';
import 'core/themes/fonts.dart';
import 'core/widget/custom_button.dart';

class HouseDetailScreen extends StatefulWidget {
  final int placeId;
  const HouseDetailScreen({
    super.key,
    required this.placeId,
  });

  @override
  State<HouseDetailScreen> createState() => _HouseDetailScreenState();
}

class _HouseDetailScreenState extends State<HouseDetailScreen> {
  late Future<PlaceModel> futurePlace;
  PlaceService placeService = PlaceService();

  @override
  void initState() {
    futurePlace = getDelayedPlaceList();
    super.initState();
  }

  Future<PlaceModel> getDelayedPlaceList() async {
    await Future.delayed(Duration(seconds: 2));
    return placeService.getPlace(widget.placeId);
  }

  int randomQtyFurniture() {
    int value = Random().nextInt(5) + 1;
    return value;
  }

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
                iconDetail("icon_kitchen", randomQtyFurniture(), "kitchen"),
                iconDetail("icon_bedroom", randomQtyFurniture(), "bedroom"),
                iconDetail("icon_cupboard", randomQtyFurniture(), "big drawer"),
              ],
            )
          ],
        ),
      );
    }

    Widget detailTitle(PlaceModel place) {
      return SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place.name,
                  style: blackTextStyle.copyWith(fontSize: 22),
                ),
                const SizedBox(height: 2),
                RichText(
                  text: TextSpan(
                    text: "\$${place.price}",
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
              width: 100,
              height: 20,
              child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final int fav = place.rating;
                  if (fav > index) {
                    return Image.asset(
                      "assets/icon_star.png",
                      width: 20,
                      height: 20,
                    );
                  } else {
                    return Image.asset(
                      "assets/icon_star.png",
                      width: 20,
                      height: 20,
                      color: greyColor,
                    );
                  }
                },
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

    Widget location(PlaceModel place) {
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
                      Text(place.address, style: greyTextStyle),
                      Text(place.city, style: greyTextStyle),
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

    Widget bottomButton(PlaceModel place) {
      return SizedBox(
        child: Center(
          child: FutureBuilder(
            future: FavouriteServices().isFavourite(place.id),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Text("No Data");
              } else {
                return CustomButton(
                  buttonText: snapshot.data!
                      ? "Already in favourite"
                      : "Add to favourite",
                  buttonWidth: 255,
                  onPressed: () async {
                    final insertData =
                        await FavouriteServices().addFavouritePlace(place.id);
                    if (snapshot.data == false) {
                      if (insertData.contains("Insert Favourite success")) {
                        if (context.mounted) {
                          context.go(Routes.main);
                        }
                      }
                    }
                  },
                );
              }
            },
          ),
        ),
      );
    }

    return Scaffold(
      body: FutureBuilder(
        future: futurePlace,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: whiteColor,
                color: purpleColor,
              ),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Text("No Data");
          } else {
            final PlaceModel? placeModel = snapshot.data;
            return Stack(
              children: [
                Image.network(
                  placeModel!.image,
                  height: 350,
                  fit: BoxFit.cover,
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
                        detailTitle(placeModel),
                        mainFacilities(),
                        photos(),
                        location(placeModel),
                        bottomButton(placeModel),
                      ],
                    ),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
