import 'package:flutter/foundation.dart';

import '../../data/place_data.dart';
import '../models/place_model.dart';
import 'database_service.dart';

class PlaceService {
  DatabaseService databaseService = DatabaseService.intance;

  Future<List<PlaceModel>> getPlaceList() async {
    final db = await databaseService.database;

    final data = await db.query(placeTableName);
    if (kDebugMode) {
      print("getPlaceList(): $data");
    }
    final List<PlaceModel> placeList = data
        .map(
          (e) => PlaceModel(
            id: e[placeIdColumnName] as int,
            name: e[placeNameColumnName] as String,
            image: e[placeImageColumnName] as String,
            address: e[placeAddressColumnName] as String,
            city: e[placeCityColumnName] as String,
            country: e[placeCountryColumnName] as String,
            rating: e[placeRatingColumnName] as int,
            price: e[placePriceColumnName] as int,
            createAt: e[placeCreateAtColumnName] as String,
          ),
        )
        .toList();

    return placeList;
  }

  Future<PlaceModel> getPlace(int id) async {
    final db = await databaseService.database;
    final data = await db.query(
      placeTableName,
      where: "$placeIdColumnName = ?",
      whereArgs: [
        id,
      ],
    );
    if (kDebugMode) {
      print("getPlace(): $data");
    }
    final place = data
        .map(
          (e) => PlaceModel(
            id: e[placeIdColumnName] as int,
            name: e[placeNameColumnName] as String,
            image: e[placeImageColumnName] as String,
            address: e[placeAddressColumnName] as String,
            city: e[placeCityColumnName] as String,
            country: e[placeCountryColumnName] as String,
            rating: e[placeRatingColumnName] as int,
            price: e[placePriceColumnName] as int,
            createAt: e[placeCreateAtColumnName] as String,
          ),
        )
        .toList()
        .first;

    return place;
  }

  void deletePlace(int id) async {
    final db = await databaseService.database;
    await db.delete(
      placeTableName,
      where: "$placeIdColumnName = ?",
      whereArgs: [
        id,
      ],
    );
  }

  void showPlaceAllData(String? function) async {
    final db = await databaseService.database;
    final data = await db.query(placeTableName);
    if (kDebugMode) {
      function == null
          ? print("showPlaceAllData(): $data")
          : print("$function: $data");
    }
  }

  void insertDummyPlace() async {
    final db = await databaseService.database;

    final data = await db.query(placeTableName);
    if (data.isEmpty) {
      if (kDebugMode) {
        print(
            "insertDummyPlace(): Place table data is empty, insert the data:");
      }
      for (PlaceModel place in listPlace) {
        await db.insert(
          placeTableName,
          {
            placeNameColumnName: place.name,
            placeImageColumnName: place.image,
            placeAddressColumnName: place.address,
            placeCityColumnName: place.city,
            placeCountryColumnName: place.country,
            placeRatingColumnName: place.rating,
            placePriceColumnName: place.price,
            placeCreateAtColumnName: place.createAt.toString(),
          },
        );
      }
      if (kDebugMode) {
        print("insertDummyPlace(): Insert data success");
      }
    } else {
      if (kDebugMode) {
        print("insertDummyPlace(): Place table data already exist");
      }
    }
    showPlaceAllData("insertDummyPlace()");
  }

  void deleteAllPlace() async {
    final db = await databaseService.database;
    await db.delete(placeTableName);
    if (kDebugMode) {
      print("deleteAllPlace(): Delete all data successed");
    }
    showPlaceAllData("deleteAllPlace()");
  }
}
