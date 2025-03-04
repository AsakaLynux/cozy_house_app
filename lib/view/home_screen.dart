import 'dart:async';

import 'package:cozy_house_app/view/core/themes/colors.dart';
import 'package:cozy_house_app/view/core/themes/fonts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../domain/models/place_model.dart';
import '../domain/services/place_service.dart';
import '../routing/routes.dart';
import 'core/themes/dimens.dart';
import 'core/widget/popular_card.dart';
import 'core/widget/recommended_tile.dart';
import 'core/widget/tips_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<PlaceModel>> futurePlacelist;
  PlaceService placeService = PlaceService();

  @override
  void initState() {
    futurePlacelist = getDelayedPlaceList();
    super.initState();
  }

  Future<List<PlaceModel>> getDelayedPlaceList() async {
    final dataFuture = placeService.getPlaceList();

    // await Future.delayed(const Duration(seconds: 2));
    final data = await dataFuture;
    final imageFutures = data.map((place) {
      return precacheImage(NetworkImage(place.image), context);
    }).toList();

    await Future.wait(imageFutures);

    return data;
  }

  Future<void> refreshData() async {
    setState(() {
      futurePlacelist = getDelayedPlaceList();
    });
  }

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
            FutureBuilder(
              future: futurePlacelist, // Has function to delayed for 2 seconds
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
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          context
                              .go("${Routes.main}/${snapshot.data![index].id}");
                        },
                        child: RecommendedTile(
                          tileName: snapshot.data![index].name,
                          imageUrl: snapshot.data![index].image,
                          rating: snapshot.data![index].rating,
                          price: snapshot.data![index].price,
                          city: snapshot.data![index].city,
                          country: snapshot.data![index].country,
                        ),
                      );
                    },
                  );
                }
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
      child: RefreshIndicator(
        backgroundColor: whiteColor,
        color: purpleColor,
        onRefresh: () => refreshData(),
        child: SingleChildScrollView(
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
      ),
    );
  }
}
