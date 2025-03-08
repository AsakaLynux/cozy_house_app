class UserModel {
  final int id;
  final String userName;
  final String email;
  final String password;
  final String createBy;
  final String createAt;
  final String updateBy;
  final String updateAt;

  UserModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.password,
    required this.createBy,
    required this.createAt,
    required this.updateBy,
    required this.updateAt,
  });
}
