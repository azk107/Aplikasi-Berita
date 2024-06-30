import 'package:flutter/material.dart';
import 'package:tugas_uas/model/model_news.dart';
import 'package:tugas_uas/network/network_services.dart';
import 'package:tugas_uas/page_detail/detail_page.dart';
import 'package:tugas_uas/utils/tools.dart';

class NewsPage extends StatefulWidget {
  final String kategori;

  const NewsPage({super.key, required this.kategori});

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<ModelNews> _allNews = [];
  List<ModelNews> _filteredNews = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchNews();
    _searchController.addListener(() {
      _filterNews();
    });
  }

  @override
  void didUpdateWidget(covariant NewsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.kategori != widget.kategori) {
      _fetchNews();
    }
  }

  void _fetchNews() async {
    final news = await NetworkService.fetchNews(widget.kategori);
    setState(() {
      _allNews = news;
      _filteredNews = news;
    });
  }

  void _filterNews() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredNews = _allNews.where((news) {
        return news.title!.toLowerCase().contains(query) ||
            news.description!.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Cari berita...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<ModelNews>>(
              future: NetworkService.fetchNews(widget.kategori),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xffe1b859)),
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      "Ups, Error!",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }

                final listData = snapshot.data ?? [];
                if (listData.isEmpty) {
                  return const Center(
                    child: Text(
                      "Tidak ada berita ditemukan",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: _filteredNews.length,
                  itemBuilder: (context, index) {
                    final news = _filteredNews[index];
                    return GestureDetector(
                      onTap: () {
                        final strLinkWeb = news.link ?? '';
                        final strTitleWeb = news.title ?? '';
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              strLink: strLinkWeb,
                              strTitle: strTitleWeb,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.all(10),
                        clipBehavior: Clip.antiAlias,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                TimeAgo.setTimeAgo(news.pubDate ?? ''),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          news.title ?? '',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                          maxLines: 2,
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          news.description ?? '',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 10),
                                    width: 80,
                                    height: 80,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: SizedBox.fromSize(
                                        size: const Size.fromRadius(20),
                                        child: Image.network(
                                          news.thumbnail ?? '',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Text(
                                SetDate.setDate(news.pubDate ?? ''),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
