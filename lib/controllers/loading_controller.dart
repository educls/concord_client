import 'package:get/get.dart';

class LoadingController extends GetxController {
  var isLoading = false.obs;
  var isTrue = true.obs;

  void showLoading() {
    isLoading.value = true;
  }

  void hideLoading() {
    isLoading.value = false;
  }

  @override
  void onClose() {
    super.onClose();
  }
}