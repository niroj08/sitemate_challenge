import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

Future<bool> isConnectionAvailable() async {
  final List<ConnectivityResult> connectivityResult =
      await (Connectivity().checkConnectivity());

// This condition is for demo purposes only to explain every connection type.
// Use conditions which work for your requirements.
  if (connectivityResult.contains(ConnectivityResult.mobile) ||
      connectivityResult.contains(ConnectivityResult.wifi) ||
      connectivityResult.contains(ConnectivityResult.vpn)) {
    return true;
  } else {
    Get.snackbar("Opps!", "Seems like you are not connected to internet.");
    return false;
  }
}
