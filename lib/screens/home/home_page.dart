
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/loading_controller.dart';
import '../../controllers/server_controller.dart';
import '../../widgets/custom_create_or_enjoy_server.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/custom_home_server.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ServerController instServer = Get.put(ServerController());
  final LoadingController instLoading= Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (instLoading.isLoading.value) {
        return const Scaffold(
          backgroundColor: Color.fromARGB(73, 8, 28, 85),
          body: Center(child: CircularProgressIndicator()),
        );
      } else {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 79, 137, 190),
          endDrawer: CustomDrawer(),
          body: instServer.serverToken.isEmpty || instServer.server.value.name == null
                ? CustomCreateOrEnjoyServer()
                : CustomHomeServer(),
        );
      }
    });
  }
}
