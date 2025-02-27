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
        print("deletePlace(): Delete Place successed");
      }
    } else {
      if (kDebugMode) {
        print("deletePlace(): Delete Place Failed");
      }
    }
  }

  void insertPlace() async {
    final db = await databaseService.database;
    int countData = 1;
    for (PlaceModel place in listPlace) {
      final insertData = await db.insert(
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
          placeCreateAtColumnName: place.createAt,
          placeUpdateByColumnName: place.updateBy,
          placeUpdateAtColumnName: place.updateAt,
        },
      );
      if (insertData == 1) {
        if (kDebugMode) {
          print("inserPlaceData() $countData: Insert Place successed");
        }
      } else {
        if (kDebugMode) {
          print("inserPlaceData() $countData: Insert Place Failed");
        }
      }
      countData++;
    }
  }

  void deleteAllPlace() async {
    final db = await databaseService.database;
    final deleteData = await db.delete(placeTableName);

    if (deleteData == 1) {
      if (kDebugMode) {
        print("deleteAllPlace(): Delete Place successed");
      }
    } else {
      if (kDebugMode) {
        print("deleteAllPlace(): Delete Place Failed");
      }
    }
  }
}
