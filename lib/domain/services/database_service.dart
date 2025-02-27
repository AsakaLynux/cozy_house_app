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
    final databasePath = join(databaseDirPath, "master_db.db");
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE $userTableName ($userIdColumnName INTEGER AUTO_INCREMENT PRIMARY KEY, $userNameColumnName VARCHAR(255) NOT NULL, $userEmailColumnName VARCHAR(255) NOT NULL, $userPasswordColumnName VARCHAR(255) NOT NULL, $userCreateByColumnName VARCHAR(255) NOT NULL, $userCreateAtColumnName DATE NOUT NULL, $userUpdateByColumnName VARCHAR(255) NOT NULL, $userUpdateAtColumnName DATE NOT NULL)",
        );

        db.execute(
          "CREATE TABLE $placeTableName ($placeIdColumnName INTEGER AUTO_INCEREMENT PRIMARY KEY, $placeNameColumnName VARCHAR(255) NOT NULL, $placeImageColumnName TEXT NOT NULL, $placeAddressColumnName TEXT NOT NULL, $placeCityColumnName VARCHAR(255) NOT NULL, $placeCountryColumnName VARCHAR(255) NOT NULL, $placeRatingColumnName INTEGER NOT NULL, $placePriceColumnName INTEGER NOT NULL, $placeCreateByColumnName VARCHAR(255) NOT NULL, $placeCreateAtColumnName DATE NOUT NULL, $placeUpdateByColumnName VARCHAR(255) NOT NULL, $placeUpdateAtColumnName DATE NOT NULL)",
        );

        db.execute(
          "CREATE TABLE $historyTableName ($historyIdColumnName INTEGER AUTO_INCREMENT PRIMARY KEY, $historyUserIdColumnName INTEGER NOT NULL FOREIGN KEY REFERENCES user(id), $historyPlaceIdColumnName INTEGER NOT NULL FOREIGN KEY REFERENCES place(id), $historyCreateByColumnName VARCHAR(255) NOT NULL, $historyCreateAtColumnName DATE NOUT NULL, $historyUpdateByColumnName VARCHAR(255) NOT NULL, $historyUpdateAtColumnName DATE NOT NULL)",
        );

        db.execute(
          "CREATE TABLE $favTableName ($favIdColumnName INTEGER AUTO_INCREMENT PRIMARY KEY, $favUserIdColumnName INTEGER NOT NULL FOREIGN KEY REFERENCES user(id), $favPlaceIdColumnName INTEGER NOT NULL FOREIGN KEY REFERENCES place(id), $favCreateByColumnName VARCHAR(255) NOT NULL, $favCreateAtColumnName DATE NOUT NULL, $favUpdateByColumnName VARCHAR(255) NOT NULL, $favUpdateAtColumnName DATE NOT NULL)",
        );
      },
    );
    return database;
  }
}
