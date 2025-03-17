import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//Place Table
final String placeTableName = "place";
final String placeIdColumnName = "id";
final String placeNameColumnName = "name";
final String placeImageColumnName = "image";
final String placeAddressColumnName = "address";
final String placeCityColumnName = "city";
final String placeCountryColumnName = "country";
final String placeRatingColumnName = "rating";
final String placePriceColumnName = "price";
final String placeCreateAtColumnName = "createAt";

// Favouite Table
final String favTableName = "favourite";
final String favIdColumnName = "id";
final String favPlaceIdColumnName = "place_id";
final String favCreateAtColumnName = "createAt";

class DatabaseService {
  static Database? db;
  static final DatabaseService intance = DatabaseService._constructor();

  DatabaseService._constructor();

  Future<Database> get database async {
    if (db != null) return db!;
    db = await getDatabase();
    return db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "master.db");
    final database = await openDatabase(
      databasePath,
      version: 1,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE $placeTableName ("
          "$placeIdColumnName INTEGER PRIMARY KEY, "
          "$placeNameColumnName VARCHAR(255) NOT NULL, "
          "$placeImageColumnName TEXT NOT NULL, "
          "$placeAddressColumnName TEXT NOT NULL, "
          "$placeCityColumnName VARCHAR(255) NOT NULL, "
          "$placeCountryColumnName VARCHAR(255) NOT NULL, "
          "$placeRatingColumnName INTEGER NOT NULL, "
          "$placePriceColumnName INTEGER NOT NULL, "
          "$placeCreateAtColumnName TEXT NOT NULL"
          ")",
        );

        db.execute(
          "CREATE TABLE $favTableName ("
          "$favIdColumnName INTEGER PRIMARY KEY,"
          "$favPlaceIdColumnName INTEGER NOT NULL,"
          "$favCreateAtColumnName TEXT NOT NULL,"
          "FOREIGN KEY ($placeIdColumnName) REFERENCES place ($placeIdColumnName) ON DELETE NO ACTION ON UPDATE NO ACTION"
          ")",
        );
      },
    );
    return database;
  }

  Future<void> deleteDatabase() async {
    if (kDebugMode) {
      print("delete databse");
    }
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "master.db");
    databaseFactory.deleteDatabase(databasePath);
  }

  void checkTableStructure() async {
    final db = await database;

    final placeTableInfo =
        await db.rawQuery('PRAGMA table_info($placeTableName)');
    final favTableInfo = await db.rawQuery("PRAGMA table_info($favTableName)");
    if (kDebugMode) {
      print("Place Table Info: $placeTableInfo");
      print("Favourite Table Info: $favTableInfo");
    }
  }
}
