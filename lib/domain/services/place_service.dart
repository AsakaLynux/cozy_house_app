import 'package:flutter/foundation.dart';

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
            createAt: e["createAt"] as DateTime,
            updateBy: e["updateBy"] as String,
            updateAt: e["updateAt"] as DateTime,
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
      print("getPlace(int id): $data");
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
            createAt: e["createAt"] as DateTime,
            updateBy: e["updateBy"] as String,
            updateAt: e["updateAt"] as DateTime,
          ),
        )
        .toList()
        .first;

    return place;
  }

  void deletePlace(int id) async {
    final db = await databaseService.database;
    final deleteData = await db.delete(
      placeTableName,
      where: "$placeIdColumnName = ?",
      whereArgs: [
        id,
      ],
    );
    if (deleteData == 1) {
      if (kDebugMode) {
        print("deletePlace(int id): Delete Place successed");
      }
    } else {
      if (kDebugMode) {
        print("deletePlace(int id): Delete Place Failed");
      }
    }
  }
}
