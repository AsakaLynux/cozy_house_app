import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// User Table
final String userTableName = "user";
final String userIdColumnName = "id";
final String userNameColumnName = "userName";
final String userEmailColumnName = "email";
final String userPasswordColumnName = "password";
final String userCreateByColumnName = "createBy";
final String userCreateAtColumnName = "createAt";
final String userUpdateByColumnName = "updateBy";
final String userUpdateAtColumnName = "updateAt";

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
final String placeCreateByColumnName = "createBy";
final String placeCreateAtColumnName = "createAt";
final String placeUpdateByColumnName = "updateBy";
final String placeUpdateAtColumnName = "updateAt";

// Favouite Table
final String favTableName = "favourite";
final String favIdColumnName = "id";
final String favUserIdColumnName = "user_id";
final String favPlaceIdColumnName = "place_id";
final String favCreateByColumnName = "createBy";
final String favCreateAtColumnName = "createAt";
final String favUpdateByColumnName = "updateBy";
final String favUpdateAtColumnName = "updateAt";

// History Table
final String historyTableName = "history";
final String historyIdColumnName = "id";
final String historyUserIdColumnName = "user_id";
final String historyPlaceIdColumnName = "place_id";
final String historyCreateByColumnName = "createBy";
final String historyCreateAtColumnName = "createAt";
final String historyUpdateByColumnName = "updateBy";
final String historyUpdateAtColumnName = "updateAt";

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
          "CREATE TABLE $userTableName ("
          "$userIdColumnName INTEGER PRIMARY KEY,"
          "$userNameColumnName VARCHAR(255) NOT NULL,"
          "$userEmailColumnName VARCHAR(255) NOT NULL,"
          "$userPasswordColumnName VARCHAR(255) NOT NULL,"
          "$userCreateByColumnName VARCHAR(255) NOT NULL,"
          "$userCreateAtColumnName TEXT NOT NULL,"
          "$userUpdateByColumnName VARCHAR(255) NOT NULL,"
          "$userUpdateAtColumnName TEXT NOT NULL"
          ")",
        );

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
          "$placeCreateByColumnName VARCHAR(255) NOT NULL, "
          "$placeCreateAtColumnName TEXT NOT NULL, "
          "$placeUpdateByColumnName VARCHAR(255) NOT NULL, "
          "$placeUpdateAtColumnName TEXT NOT NULL"
          ")",
        );

        db.execute(
          "CREATE TABLE $historyTableName ("
          "$historyIdColumnName INTEGER PRIMARY KEY,"
          "$historyUserIdColumnName INTEGER NOT NULL,"
          "$historyPlaceIdColumnName INTEGER NOT NULL,"
          "$historyCreateByColumnName VARCHAR(255) NOT NULL,"
          "$historyCreateAtColumnName TEXT NOT NULL,"
          "$historyUpdateByColumnName VARCHAR(255) NOT NULL,"
          "$historyUpdateAtColumnName TEXT NOT NULL,"
          "FOREIGN KEY($historyUserIdColumnName) REFERENCES user($userIdColumnName) ON DELETE NO ACTION ON UPDATE NO ACTION,"
          "FOREIGN KEY($historyPlaceIdColumnName) REFERENCES place($placeIdColumnName) ON DELETE NO ACTION ON UPDATE NO ACTION,"
          ")",
        );

        db.execute(
          "CREATE TABLE $favTableName ("
          "$favIdColumnName INTEGER PRIMARY KEY,"
          "$favUserIdColumnName INTEGER NOT NULL,"
          "$favPlaceIdColumnName INTEGER NOT NULL,"
          "$favCreateByColumnName VARCHAR(255) NOT NULL,"
          "$favCreateAtColumnName TEXT NOT NULL,"
          "$favUpdateByColumnName VARCHAR(255) NOT NULL,"
          "$favUpdateAtColumnName TEXT NOT NULL,"
          "FOREIGN KEY($historyUserIdColumnName) REFERENCES user($userIdColumnName) ON DELETE NO ACTION ON UPDATE NO ACTION,"
          "FOREIGN KEY($historyPlaceIdColumnName) REFERENCES place($placeIdColumnName) ON DELETE NO ACTION ON UPDATE NO ACTION,"
          ")",
        );
      },
    );
    return database;
  }

  Future<void> deleteDatabase(String path) async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "master.db");
    databaseFactory.deleteDatabase(databasePath);
  }

  void checkTableStructure() async {
    final db = await database;

    final userTableInfo =
        await db.rawQuery("PRAGMA table_info($userTableName)");
    final placeTableInfo =
        await db.rawQuery('PRAGMA table_info($placeTableName)');
    final historyTableInfo =
        await db.rawQuery("PRAGMA table_info($historyTableName)");
    final favTableInfo = await db.rawQuery("PRAGMA table_info($favTableName)");
    if (kDebugMode) {
      print("User Table Info: $userTableInfo");
      print("Place Table Info: $placeTableInfo");
      print("History Table Info: $historyTableInfo");
      print("Favourite Table Info: $favTableInfo");
    }
  }
}
