import 'package:flutter/material.dart';

import 'routing/router.dart';
import 'view/core/ui/scroll_behavior.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      scrollBehavior: AppCustomScrollBehavior(),
      routerConfig: router(),
    );
  }
}
