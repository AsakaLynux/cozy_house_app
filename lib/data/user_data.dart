import '../domain/models/user_model.dart';

List<UserModel> listUser = [
  UserModel(
    id: 0,
    userName: "irfan",
    email: "irfan@email.com",
    password: "123",
    createBy: "admin",
    createAt: DateTime.now().toIso8601String(),
    updateBy: "admin",
    updateAt: DateTime.now().toIso8601String(),
  ),
  UserModel(
    id: 0,
    userName: "asaka",
    email: "asaka@email.com",
    password: "321",
    createBy: "admin",
    createAt: DateTime.now().toIso8601String(),
    updateBy: "admin",
    updateAt: DateTime.now().toIso8601String(),
  ),
  UserModel(
    id: 0,
    userName: "admin",
    email: "admin@email.com",
    password: "123",
    createBy: "admin",
    createAt: DateTime.now().toIso8601String(),
    updateBy: "admin",
    updateAt: DateTime.now().toIso8601String(),
  ),
];
