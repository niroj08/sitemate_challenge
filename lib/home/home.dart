import 'dart:async';
import 'dart:developer' as developer;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fllutter_sitemate_challenge/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Obx(
          () => controller.hasInternet.value
              ? Column(
                  // Column is also a layout widget. It takes a list of children and
                  // arranges them vertically. By default, it sizes itself to fit its
                  // children horizontally, and tries to be as tall as its parent.
                  //
                  // Column has various properties to control how it sizes itself and
                  // how it positions its children. Here we use mainAxisAlignment to
                  // center the children vertically; the main axis here is the vertical
                  // axis because Columns are vertical (the cross axis would be
                  // horizontal).
                  //
                  // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
                  // action in the IDE, or press "p" in the console), to see the
                  // wireframe for each widget.
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'You have pushed the button this many times:',
                    ),
                    Text(
                      '${controller.counter.value}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                )
              : Lottie.asset('assets/no_internet.json', height: 300.00),
        ),
      ),
      floatingActionButton: Obx(() => Visibility(
            visible: controller.hasInternet.value,
            child: FloatingActionButton(
              onPressed: controller.incrementCounter,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          )), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
