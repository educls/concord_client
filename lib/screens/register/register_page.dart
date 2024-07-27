import 'package:concord_client/widgets/modal_register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../controllers/loading_controller.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final LoadingController controller = Get.put(LoadingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 3, 12, 34),
      body: Stack(
        children: [
          Positioned.fill(
            child: WaveWidget(
              config: CustomConfig(
                gradients: [
                  [const Color.fromARGB(255, 26, 97, 155), const Color.fromARGB(237, 14, 63, 223)],
                  [Colors.blue[800]!, const Color.fromARGB(166, 24, 12, 201)],
                  [Colors.blue[600]!, const Color.fromARGB(188, 29, 30, 124)],
                  [const Color.fromARGB(255, 11, 75, 128), const Color.fromARGB(123, 10, 45, 201)]
                ],
                durations: [35000, 19440, 10800, 6000],
                heightPercentages: [0.74, 0.75, 0.80, 0.86],
                blur: const MaskFilter.blur(BlurStyle.solid, 10),
                gradientBegin: Alignment.bottomLeft,
                gradientEnd: Alignment.topRight,
              ),
              waveAmplitude: 0,
              size: const Size(double.infinity, double.infinity),
            ),
          ),
          Center(
            child: ModalRegister(),
          ),
        ],
      ),
    );
  }
}



      