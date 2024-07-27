import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/app_routes.dart';
import 'widgets/background_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const BackgroundPage(),
      locale: const Locale('pt', 'BR'),
      getPages: AppRoutes.routes,
      initialRoute: AppRoutes.initialRoute,
    );
  }
}

