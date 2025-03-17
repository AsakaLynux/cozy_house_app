import 'package:flutter/material.dart';

import 'domain/services/database_service.dart';
import 'domain/services/place_service.dart';
import 'routing/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeData();
  // checkDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router(),
    );
  }
}

void initializeData() {
  PlaceService placeService = PlaceService();
  placeService.insertDummyPlace();
}

void checkDatabase() {
  DatabaseService databaseService = DatabaseService.intance;
  databaseService.deleteDatabase();
  databaseService.checkTableStructure();
}
