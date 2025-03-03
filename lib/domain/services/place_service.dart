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
            id: e["id"] as int,
            name: e["name"] as String,
            image: e["image"] as String,
            address: e["address"] as String,
            city: e["city"] as String,
            country: e["country"] as String,
            rating: e["rating"] as int,
            price: e["price"] as int,
            createBy: e["createBy"] as String,
            createAt: e["createAt"] as String,
            updateBy: e["updateBy"] as String,
            updateAt: e["updateAt"] as String,
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
            id: e["id"] as int,
            name: e["name"] as String,
            image: e["image"] as String,
            address: e["address"] as String,
            city: e["city"] as String,
            country: e["country"] as String,
            rating: e["rating"] as int,
            price: e["price"] as int,
            createBy: e["createBy"] as String,
            createAt: e["createAt"] as String,
            updateBy: e["updateBy"] as String,
            updateAt: e["updateAt"] as String,
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
            placeCreateByColumnName: place.createBy,
            placeCreateAtColumnName: place.createAt.toString(),
            placeUpdateByColumnName: place.updateBy,
            placeUpdateAtColumnName: place.updateAt.toString(),
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
