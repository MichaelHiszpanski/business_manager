import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  static RxBool isNetworkConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    _checkInitialConnection();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResults) {
    isNetworkConnected.value = connectivityResults != ConnectivityResult.none;
    if (!isNetworkConnected.value) {
      Get.rawSnackbar(
        messageText: const Align(
          alignment: Alignment.center,
          child: Text(
            "Please connect to the Internet!",
            style: TextStyle(color: Colors.white, fontSize: 15),
            textAlign: TextAlign.center,
          ),
        ),
        isDismissible: false,
        duration: const Duration(days: 1),
        backgroundColor: Colors.red,
        icon: const Icon(
          Icons.wifi,
          color: Colors.white,
          size: 35,
        ),
        margin: EdgeInsets.zero,
        snackStyle: SnackStyle.GROUNDED,
      );
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }

  Future<void> _checkInitialConnection() async {
    ConnectivityResult connectivityResult =
        await _connectivity.checkConnectivity();
    _updateConnectionStatus(connectivityResult);
  }
}
