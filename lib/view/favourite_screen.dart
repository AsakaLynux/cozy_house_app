import 'package:cozy_house_app/view/core/themes/fonts.dart';
import 'package:flutter/material.dart';

import '../domain/models/place_model.dart';
import '../domain/services/favourite_services.dart';
import 'core/themes/colors.dart';
import 'core/themes/dimens.dart';
import 'core/widget/recommended_tile.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  late Future<List<PlaceModel>> futurePlacelist;
  FavouriteServices favouriteServices = FavouriteServices();

  @override
  void initState() {
    futurePlacelist = getDelayedPlaceList();
    super.initState();
  }

  Future<List<PlaceModel>> getDelayedPlaceList() async {
    final dataFuture = favouriteServices.getfavouriteList();

    final data = await dataFuture;
    final imageFutures = data.map((place) {
      return precacheImage(NetworkImage(place.image), context);
    }).toList();

    await Future.wait(imageFutures);

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Dimens.paddingHorizontal,
            vertical: Dimens.paddingVertical),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: SizedBox(
            child: FutureBuilder(
              future: getDelayedPlaceList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: whiteColor,
                      color: purpleColor,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Center(
                    child: Text("No data"),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Favourite",
                        style: blackTextStyle.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      ListView.builder(
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => RecommendedTile(
                          tileName: snapshot.data![index].name,
                          imageUrl: snapshot.data![index].image,
                          rating: snapshot.data![index].rating,
                          price: snapshot.data![index].price,
                          city: snapshot.data![index].city,
                          country: snapshot.data![index].country,
                          isFavourite: true,
                          onTap: () async {
                            await FavouriteServices()
                                .deleteFavouritePlace(snapshot.data![index].id);
                            setState(() {});
                          },
                        ),
                      )
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
