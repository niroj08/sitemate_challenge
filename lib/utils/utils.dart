import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:fllutter_sitemate_challenge/utils/styles/styles.dart';
import 'package:flutter/material.dart';
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

void handleError(error) {
  if (error is DioError) {
    try {
      String message = json.decode(error.response.toString())['message'] ??
          'Something went wrong';
      showSnackBar('Error', message.isEmpty ? 'Something went wrong' : message);
    } catch (error) {
      showSnackBar('Error', 'Something went wrong');
    }
  } else {
    if (error.message == "No internet connection") {
      //Display no internet view
      showSnackBar('Error', 'No internet connection');
    } else {
      showSnackBar('Error', error.message ?? 'Something went wrong');
    }
  }
}

showSnackBar(title, message) {
  Get.snackbar(title, message,
      margin: EdgeInsets.all(DesignDimens.itemPadding));
}
