import 'database_service.dart';
import 'user_service.dart';

class HistoryServices {
  final DatabaseService databaseService = DatabaseService.intance;

  Future<String> addBooking(int placeId) async {
    final db = await databaseService.getDatabase();
    final userData = await UserService().getUser();

    if (userData != null) {
      await db.insert(
        historyTableName,
        {
          favUserIdColumnName: userData.id,
          favPlaceIdColumnName: placeId,
          favCreateByColumnName: userData.userName,
          favCreateAtColumnName: DateTime.now().toIso8601String(),
          favUpdateByColumnName: userData.userName,
          favUpdateAtColumnName: DateTime.now().toIso8601String(),
        },
      );
    }
    return "Booking Failed";
  }
}
