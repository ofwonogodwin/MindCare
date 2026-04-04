import 'package:flutter/material.dart';

import '../core/constants/app_routes.dart';
import '../data/repositories/mindcare_repository.dart';
import '../domain/entities/article.dart';
import '../widgets/developed_by_footer.dart';

class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({super.key});

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  static const _categories = [
    'All',
    'Anxiety',
    'Depression',
    'Stress',
    'Self-Care',
    'Relationships',
    'Sleep',
    'Mindfulness',
  ];

  final _repository = const MindCareRepository();
  String _selected = 'All';
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final allArticles = _repository.articles();
    final filtered = allArticles.where((article) {
      final categoryMatch = _selected == 'All' || article.category == _selected;
      final queryMatch =
          _query.isEmpty ||
          article.title.toLowerCase().contains(_query.toLowerCase());
      return categoryMatch && queryMatch;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Self-Help Resources')),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
              child: TextField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search resources',
                ),
                onChanged: (value) => setState(() => _query = value),
              ),
            ),
            SizedBox(
              height: 44,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: _categories
                    .map(
                      (category) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: ChoiceChip(
                          label: Text(category),
                          selected: _selected == category,
                          onSelected: (_) =>
                              setState(() => _selected = category),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 10),
            if (allArticles.isNotEmpty)
              _FeaturedArticle(article: allArticles.first),
            Expanded(
              child: ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final article = filtered[index];
                  return ListTile(
                    title: Text(article.title),
                    subtitle: Text(
                      '${article.category} • ${article.readTime} min read',
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.pushNamed(
                      context,
                      AppRoutes.articleDetail,
                      arguments: {'article': article},
                    ),
                  );
                },
              ),
            ),
            const DevelopedByFooter(),
          ],
        ),
      ),
    );
  }
}

class _FeaturedArticle extends StatelessWidget {
  const _FeaturedArticle({required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ListTile(
        leading: const Icon(Icons.auto_stories_outlined),
        title: Text(article.title),
        subtitle: Text(article.summary),
      ),
    );
  }
}
