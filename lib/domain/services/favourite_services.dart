import 'package:flutter/foundation.dart';

import '../models/place_model.dart';
import 'database_service.dart';

class FavouriteServices {
  DatabaseService databaseService = DatabaseService.intance;
  void showfavourite(String function, List<Map<String, Object?>> data) async {
    if (kDebugMode) {
      print("$function: $data");
    }
  }

  Future<String> addFavouritePlace(int placeId) async {
    final db = await databaseService.getDatabase();
    final insertData = await db.insert(
      favTableName,
      {
        favPlaceIdColumnName: placeId,
        favCreateAtColumnName: DateTime.now().toIso8601String(),
      },
    );
    if (insertData > 0) {
      return "Insert Favourite success";
    }
    return "Insert Favourite failed";
  }

  Future<bool> isFavourite(int placeId) async {
    final db = await databaseService.getDatabase();
    final data = await db.query(
      favTableName,
      where: "$favPlaceIdColumnName = ?",
      whereArgs: [
        placeId,
      ],
    );
    if (data.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> deleteFavouritePlace(int favId) async {
    final db = await databaseService.getDatabase();
    final deleteData = await db.delete(
      favTableName,
      where: "$favIdColumnName = ?",
      whereArgs: [
        favId,
      ],
    );
    if (deleteData > 0) {
      return "Delete Favourite success";
    }
    return "Delete Favourite failed";
  }

  Future<List<PlaceModel>> getfavouriteList() async {
    final db = await databaseService.getDatabase();
    final data = await db.rawQuery(
        "SELECT pt.* FROM $favTableName ft JOIN $placeTableName pt ON ft.$favPlaceIdColumnName = pt.$placeIdColumnName");

    final List<PlaceModel> placeData = data
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
    showfavourite("getfavouriteList()", data);
    return placeData;
  }
}
