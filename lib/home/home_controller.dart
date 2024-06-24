import 'dart:async';
import 'dart:developer' as developer;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fllutter_sitemate_challenge/repository/base_api_service.dart';
import 'package:fllutter_sitemate_challenge/repository/end_points.dart';
import 'package:fllutter_sitemate_challenge/repository/localstorage.dart';
import 'package:fllutter_sitemate_challenge/repository/model/news_article.dart';
import 'package:fllutter_sitemate_challenge/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt counter = 0.obs;
  RxBool hasInternet = false.obs;
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  RxString searchValue = "".obs;
  TextEditingController searchController = TextEditingController(text: "");

  var latestNews = <NewsArticle>[];
  var latestNewsLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    _connectionStatus = result;
    hasInternet.value = !result.contains(ConnectivityResult.none);

    // ignore: avoid_print
    print('Connectivity changed: $_connectionStatus');
  }

  loadLatestNews() {
    manageSearchHistory();

    SystemChannels.textInput.invokeMethod('TextInput.hide');
    latestNewsLoading.value = true;

    Map<String, dynamic>? queryParameters = {
      "apiKey": EndPoints.apiKey,
      "q": searchValue.value,
      "sortBy": "popularity",
    };
    BaseApiService()
        .getArrayResponseWithParams(EndPoints.newsArticle, queryParameters)
        .then((value) {
      if (value.status) {
        latestNews.clear();
        for (var item in value.data) {
          latestNews.add(NewsArticle.fromJson(item));
        }
        latestNewsLoading.value = false;
      }
    }).catchError((error) {
      latestNewsLoading.value = false;
      handleError(error);
    });
  }

  void onSearchChanged(String value) {
    searchValue.value = value;
  }

  void manageSearchHistory() {
    List<String>? items = LocalStorage().readHistory();
    items ??= [];
    items.add(searchValue.value);

    LocalStorage().storeHistory(items);
  }
}
