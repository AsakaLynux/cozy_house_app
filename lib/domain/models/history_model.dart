class HistoryModel {
  final int id;
  final int userId;
  final int placeId;
  final String createBy;
  final String createAt;
  final String updateBy;
  final String updateAt;

  const HistoryModel({
    required this.id,
    required this.userId,
    required this.placeId,
    required this.createBy,
    required this.createAt,
    required this.updateBy,
    required this.updateAt,
  });
}
