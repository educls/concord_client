
import 'package:concord_client/screens/login/login_page.dart';
import 'package:concord_client/screens/register/register_page.dart';
import 'package:get/get.dart';

import '../screens/forgotPassword/forgot_password_page.dart';
import '../screens/home/home_page.dart';

class AppRoutes {
  static const String initialRoute = '/login';
  static final List<GetPage> routes = [
    GetPage(
      name: '/login',
      page: () => const LoginPage(),
      // transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 100),
    ),
    GetPage(
      name: '/register',
      page: () => RegisterPage(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 100),
    ),
    GetPage(
      name: '/forgotPassword',
      page: () => const ForgotPasswordPage(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 100),
    ),
    GetPage(
      name: '/home',
      page: () => const HomePage(),
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 200),
    ),
  ];
}