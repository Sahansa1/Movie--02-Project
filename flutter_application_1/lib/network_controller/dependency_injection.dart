// File name: dependency_injection.dart

import 'package:get/get.dart';
import 'network_controller.dart';

class dependency_injection{
  static void init() {
    Get.put<NetworkController>(NetworkController(),permanent: true);
  }
}

