import 'package:cached_network_image/cached_network_image.dart';
import 'package:fllutter_sitemate_challenge/repository/model/news_article.dart';
import 'package:fllutter_sitemate_challenge/utils/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsCard extends StatelessWidget {
  final NewsArticle news;
  const NewsCard({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DesignDimens.itemRadius),
      ),
      elevation: 4,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(DesignDimens.itemRadius),
              bottomLeft: Radius.circular(DesignDimens.itemRadius),
            ),
            child: CachedNetworkImage(
              imageUrl: '${news.urlToImage}',
              width: 100.0,
              height: 100.0,
              fit: BoxFit.cover,
              placeholder: (context, url) => const SizedBox(
                height: 20.0,
                width: 20.0,
                child: LinearProgressIndicator(
                  minHeight: 1.0,
                  color: Color.fromARGB(20, 0, 48, 102),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                decoration: BoxDecoration(gradient: DesignColors.bgGradient),
                child: const Icon(
                  Icons.image,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 16.0,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  news.title!,
                  maxLines: 1,
                  style: Get.textTheme.titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Text(
                  news.description!,
                  style: Get.textTheme.bodyMedium,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          const SizedBox(
            width: 3.0,
          ),
        ],
      ),
    );
  }
}
