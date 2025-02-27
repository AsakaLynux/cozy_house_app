import 'package:flutter/foundation.dart';

import '../models/user_model.dart';
import 'database_service.dart';

DatabaseService databaseService = DatabaseService.intance;

class UserService {
  void getUser() async {
    final db = await databaseService.database;
    final data = await db.query(userTableName);
    if (kDebugMode) {
      print(data);
    }
  }

  void addUser(String userName, String email, String password) async {
    final db = await databaseService.database;
    await db.insert(
      userTableName,
      {
        userNameColumnName: userName,
        userEmailColumnName: email,
        userPasswordColumnName: password,
        userCreateByColumnName: userName,
        userCreateAtColumnName: DateTime.now(),
        userUpdateByColumnName: userName,
        userUpdateAtColumnName: DateTime.now(),
      },
    );
  }

  void updateUser(
      int id, String userName, String email, String password) async {
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
            createAt: e["createAt"] as DateTime,
            updateBy: e["updateBy"] as String,
            updateAt: e["updateAt"] as DateTime,
          ),
        )
        .toList()
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
  }

  void deleteUser(int id) async {
    final db = await databaseService.database;
    await db.delete(
      userTableName,
      where: "id = ?",
      whereArgs: [
        id,
      ],
    );
  }
}
