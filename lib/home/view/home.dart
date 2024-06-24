import 'package:fllutter_sitemate_challenge/home/home_controller.dart';
import 'package:fllutter_sitemate_challenge/widgets/news_card.dart';
import 'package:flutter/material.dart';
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
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 40.0, horizontal: 20.0),
                  child: ListView(
                    children: <Widget>[
                      const Text(
                        'Sitemate Challenge',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),
                      ),
                      const SizedBox(height: 20.0),
                      SearchBar(
                        hintText: "Type something to search",
                        controller: controller.searchController,
                        onChanged: (value) {
                          controller.onSearchChanged(value);
                        },
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      latestNews(),
                    ],
                  ),
                )
              : Lottie.asset('assets/no_internet.json', height: 300.00),
        ),
      ),
      floatingActionButton: Obx(() => Visibility(
            visible: controller.hasInternet.value &&
                controller.searchValue.value.isNotEmpty,
            child: FloatingActionButton(
              onPressed: controller.loadLatestNews,
              tooltip: 'Increment',
              child: const Icon(Icons.search),
            ),
          )), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  latestNews() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => controller.latestNewsLoading.value
              ? const SizedBox(
                  height: 24.0,
                  width: 24.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.0,
                  ),
                )
              : ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.latestNews.length,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 4.0,
                  ),
                  itemBuilder: (context, index) => Visibility(
                    visible: !controller.latestNews[index].title!
                        .toLowerCase()
                        .contains("removed"),
                    child: NewsCard(
                      news: controller.latestNews[index],
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
