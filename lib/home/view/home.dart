import 'package:fllutter_sitemate_challenge/home/home_controller.dart';
import 'package:fllutter_sitemate_challenge/utils/styles/styles.dart';
import 'package:fllutter_sitemate_challenge/widgets/news_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                      vertical: 60.0, horizontal: 20.0),
                  child: ListView(
                    children: <Widget>[
                      const Text(
                        'Sitemate Challenge',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10.0),
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
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Latest News',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
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
                    height: 2.0,
                  ),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      // Get.to(() => NewsDetail(
                      //       news: controller.latestNews[index],
                      //     ));
                    },
                    child: Visibility(
                      visible: !controller.latestNews[index].title!
                          .toLowerCase()
                          .contains("removed"),
                      child: NewsCard(
                        news: controller.latestNews[index],
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
