import 'package:flutter/material.dart';
import 'package:livingtechassignment/screens/dashboard/model/news_model.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsCard extends StatelessWidget {
  final NewsModel news;

  const NewsCard({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final Uri url = Uri.parse(news.url ?? '');
        if (!await launchUrl(url)) {
          throw Exception('Could not launch $url');
        }
      },
      child: Card(
        elevation: 3,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: news.urlToImage != null
                  ? Image.network(
                      news.urlToImage!,
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                      // if the image is null
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: const SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: Icon(Icons.broken_image_outlined),
                          ),
                        );
                      },
                    )
                  : Text('N./A'),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Text(
                news.title ?? '',
                maxLines: 2,
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Text(
                news.description ?? '',
                maxLines: 2,
                style: const TextStyle(color: Colors.black54, fontSize: 14),
              ),
            )
          ],
        ),
      ),
    );
  }
}
