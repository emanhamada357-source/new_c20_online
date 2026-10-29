
import 'package:flutter/material.dart';
import '../../data/models/news_response.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ArticleDetailsScreen extends StatelessWidget {
  final Articles article;

  const ArticleDetailsScreen({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      drawer: Drawer(
        backgroundColor: Colors.black,
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Center(
                child: const Text(
                  "News App",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 34,
                    ),
                    SizedBox(width: 16),
                    Text(
                      "GO To Home",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          children: [
            Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(Icons.menu),
                );
              },
            ),

            Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Text(
                'abc',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(width: 8),

            const Text(
              'NEWS',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // عنوان الخبر
            Text(
              article.title ?? '',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // اسم الكاتب



            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'By: ',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                IntrinsicWidth(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        (article.author == null ||
                            article.author!.trim().isEmpty)
                            ? 'Unknown'
                            : article.author!.trim(),
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                        ),
                      ),
                      Container(
                        height: 1.5,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ],
            ),



            const SizedBox(height: 8),

            // تاريخ الخبر
            Text(
              article.publishedAt != null &&
                  article.publishedAt!.length >= 10
                  ? article.publishedAt!.substring(0, 10)
                  : '',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 16),

            // Social Media Icons
            Row(
              children: [
                const Icon(
                  Icons.facebook,
                  color: Colors.black,
                  size: 28,
                ),

                const SizedBox(width: 16),

                const Icon(
                  Icons.email,
                  color: Colors.black,
                  size: 28,
                ),

                const SizedBox(width: 16),

                const FaIcon(
                  FontAwesomeIcons.xTwitter,
                  color: Colors.black,
                  size: 28,
                ),

                const SizedBox(width: 16),

                const Icon(
                  Icons.link,
                  color: Colors.black,
                  size: 28,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // صورة الخبر
            Center(
              child: Image.network(
                article.urlToImage ?? '',
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    height: 220,
                    width: double.infinity,
                    child: Center(
                      child: Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // وصف الخبر
            Text(
              article.description ?? '',
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 17,
              ),
            ),

            const SizedBox(height: 16),

            // باقي محتوى الخبر
            Text(
              article.content ?? '',
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
