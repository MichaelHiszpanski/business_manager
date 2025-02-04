import 'package:business_manager/core/tools/network_controler.dart';
import 'package:get/get.dart';
class DependencyInjection{

  static void init(){
    Get.put<NetworkController>(NetworkController(),permanent: true);
  }
}