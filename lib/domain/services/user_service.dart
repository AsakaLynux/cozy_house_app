import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/user_data.dart';
import '../models/user_model.dart';
import 'database_service.dart';
import 'shared_services.dart';

class UserService {
  DatabaseService databaseService = DatabaseService.intance;

  void showUser(String functionName, List<Map<String, Object?>> data) {
    if (kDebugMode) {
      print("$functionName: $data");
    }
  }

  Future<List<UserModel>> getUserList() async {
    final db = await databaseService.database;
    final data = await db.query(userTableName);

    final userData = data
        .map(
          (e) => UserModel(
            id: e["id"] as int,
            userName: e["userName"] as String,
            email: e["email"] as String,
            password: e["password"] as String,
            createBy: e["createBy"] as String,
            createAt: e["createAt"] as String,
            updateBy: e["updateBy"] as String,
            updateAt: e["updateAt"] as String,
          ),
        )
        .toList();

    showUser("getUserList()", data);

    return userData;
  }

  Future<UserModel?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt("userId");
    final db = await databaseService.database;
    if (userId != null) {
      final data = await db.query(
        userTableName,
        where: "$userIdColumnName = ?",
        whereArgs: [
          userId,
        ],
      );
      final userData = data
          .map(
            (e) => UserModel(
              id: e["id"] as int,
              userName: e["userName"] as String,
              email: e["email"] as String,
              password: e["password"] as String,
              createBy: e["createBy"] as String,
              createAt: e["createAt"] as String,
              updateBy: e["updateBy"] as String,
              updateAt: e["updateAt"] as String,
            ),
          )
          .first;
      showUser("getUser()", data);
      return userData;
    }

    return null;
  }

  void addUser(
    String userName,
    String email,
    String password,
  ) async {
    final db = await databaseService.database;
    await db.insert(
      userTableName,
      {
        userNameColumnName: userName,
        userEmailColumnName: email,
        userPasswordColumnName: password,
        userCreateByColumnName: userName,
        userCreateAtColumnName: DateTime.now().toIso8601String(),
        userUpdateByColumnName: userName,
        userUpdateAtColumnName: DateTime.now().toIso8601String(),
      },
    );

    final data = await db.query(userTableName);
    showUser("addUser()", data);
  }

  void updateUser(
    int id,
    String userName,
    String email,
    String password,
  ) async {
    final db = await databaseService.database;
    final userData = await db.query(
      userTableName,
      where: "id = ?",
      whereArgs: [
        id,
      ],
    );

    final user = userData
        .map(
          (e) => UserModel(
            id: e["id"] as int,
            userName: e["userName"] as String,
            email: e["email"] as String,
            password: e["password"] as String,
            createBy: e["createBy"] as String,
            createAt: e["createAt"] as String,
            updateBy: e["updateBy"] as String,
            updateAt: e["updateAt"] as String,
          ),
        )
        .first;

    await db.update(
      userTableName,
      {
        userNameColumnName: userName.isEmpty ? user.userName : userName,
        userEmailColumnName: email.isEmpty ? user.email : email,
        userPasswordColumnName: password.isEmpty ? user.password : password,
        userCreateByColumnName: userName.isEmpty ? user.userName : userName,
        userCreateAtColumnName: DateTime.now(),
        userUpdateByColumnName: userName.isEmpty ? user.userName : userName,
        userUpdateAtColumnName: DateTime.now(),
      },
      where: "id = ?",
      whereArgs: [
        id,
      ],
    );

    showUser("updateUser()", userData);
  }

  void deleteUser(
    int id,
  ) async {
    final db = await databaseService.database;
    await db.delete(
      userTableName,
      where: "$userIdColumnName = ?",
      whereArgs: [
        id,
      ],
    );
  }

  void insertDummyUser() async {
    final db = await databaseService.database;
    final data = await db.query(userTableName);

    if (data.isEmpty) {
      if (kDebugMode) {
        print("insertDummyUser(): User table data is empty, insert the data:");
      }
      for (UserModel userData in listUser) {
        await db.insert(
          userTableName,
          {
            userNameColumnName: userData.userName,
            userEmailColumnName: userData.email,
            userPasswordColumnName: userData.password,
            userCreateByColumnName: userData.createBy,
            userCreateAtColumnName: userData.createAt,
            userUpdateByColumnName: userData.updateBy,
            userUpdateAtColumnName: userData.updateAt,
          },
        );
      }
      if (kDebugMode) {
        print("inserDummyUser(): Insert data success");
      }
    } else {
      if (kDebugMode) {
        print("inserDummyUser(): User table data already exist");
      }
    }
    showUser("insertDummyUser()", data);
  }

  Future<String> userLogin(String userName, String password) async {
    final db = await databaseService.database;
    final data = await db.query(
      userTableName,
      where: "$userNameColumnName LIKE ? AND $userPasswordColumnName LIKE ?",
      whereArgs: [
        userName,
        password,
      ],
    );
    if (data.isNotEmpty) {
      final user = data
          .map(
            (e) => UserModel(
              id: e["id"] as int,
              userName: e["userName"] as String,
              email: e["email"] as String,
              password: e["password"] as String,
              createBy: e["createBy"] as String,
              createAt: e["createAt"] as String,
              updateBy: e["updateBy"] as String,
              updateAt: e["updateAt"] as String,
            ),
          )
          .first;
      SharedServices().cacheUserInfo(user.id);
      return "Login Succesful";
    }
    return "Login Failed";
  }

  Future<String> userRegister(
      String userName, String email, String password) async {
    final db = await databaseService.database;
    final existUser = await db.query(
      userTableName,
      where: "$userNameColumnName LIKE ? AND $userEmailColumnName LIKE ?",
      whereArgs: [
        userName,
        email,
      ],
    );
    if (existUser.isEmpty) {
      await db.insert(
        userTableName,
        {
          userNameColumnName: userName,
          userEmailColumnName: email,
          userPasswordColumnName: password,
          userCreateByColumnName: userName,
          userCreateAtColumnName: DateTime.now().toIso8601String(),
          userUpdateByColumnName: userName,
          userUpdateAtColumnName: DateTime.now().toIso8601String(),
        },
      );
      return "Register Succesful";
    }
    return "Register Failed";
  }
}
