import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }
  
  // Method to handle changes in connectivity status
  void _updateConnectionStatus(ConnectivityResult connectivityResult) {

    if (connectivityResult == ConnectivityResult.none){
      // If there is no internet connection
      Get.rawSnackbar(
        messageText: const Text(
          'Please Connect to the Internet',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14
          )
      ),
      isDismissible: false,
      duration: const Duration(days: 1),
      backgroundColor: Colors.red,
      icon: const Icon(Icons.wifi_off, color: Colors.white, size: 35,),
      margin: EdgeInsets.zero,
      snackStyle: SnackStyle.GROUNDED
      );
    }else {
      if (Get.isSnackbarOpen) {
        // If there is internet connection
        Get.closeCurrentSnackbar();
        }
    }
  }
}