import 'package:flutter/material.dart';

import '../domain/entities/article.dart';
import '../widgets/developed_by_footer.dart';

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final article = args?['article'] as Article?;

    return Scaffold(
      appBar: AppBar(title: Text(article?.title ?? 'Article Detail')),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article?.category ?? 'General',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      article?.title ?? 'MindCare Resource',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text('${article?.readTime ?? 5} min read'),
                    const SizedBox(height: 16),
                    Text(
                      article?.content ??
                          'Detailed article content appears here.',
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.bookmark_border),
                          label: const Text('Save'),
                        ),
                        const SizedBox(width: 10),
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.share_outlined),
                          label: const Text('Share'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const DevelopedByFooter(),
          ],
        ),
      ),
    );
  }
}
