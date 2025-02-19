import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tugas_uas/page_news/news_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  String strKategori = 'terbaru', strTitle = "Berita Utama";
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(initialIndex: 0, length: 6, vsync: this);
    tabController!.addListener(() {
      switch (tabController!.index) {
        case 0:
          setState(() {
            strKategori = 'terbaru';
            strTitle = "Berita Utama";
          });
          break;
        case 1:
          setState(() {
            strKategori = 'lifestyle';
            strTitle = "Gaya Hidup";
          });
          break;
        case 2:
          setState(() {
            strKategori = 'tekno';
            strTitle = "Teknologi";
          });
          break;
        case 3:
          setState(() {
            strKategori = 'ekonomi';
            strTitle = "Bisnis";
          });
          break;
        case 4:
          setState(() {
            strKategori = 'olahraga';
            strTitle = "Olahraga";
          });
          break;
        case 5:
          setState(() {
            strKategori = 'otomotif';
            strTitle = "Otomotif";
          });
          break;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        elevation: 0,
        title: Row(
          children: [
            Lottie.asset(
              'assets/raw/news.json',
              width: 60,
              height: 60,
              fit: BoxFit.fill,
            ),
            const SizedBox(width: 20),
            Text(
              strTitle,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          RotatedBox(
            quarterTurns: 1,
            child: TabBar(
              controller: tabController,
              indicatorColor: Colors.pink[200],
              labelColor: const Color(0xffff80ab),
              unselectedLabelColor: Colors.grey,
              tabs: [
                getItem(
                  icon: const Icon(Icons.local_fire_department_sharp),
                  text: const Text("Berita\nUtama", textAlign: TextAlign.center),
                ),
                getItem(
                  icon: const Icon(Icons.style_outlined),
                  text: const Text("Gaya\nHidup", textAlign: TextAlign.center),
                ),
                getItem(
                  icon: const Icon(Icons.computer),
                  text: const Text("Teknologi"),
                ),
                getItem(
                  icon: const Icon(Icons.business_sharp),
                  text: const Text("Bisnis"),
                ),
                getItem(
                  icon: const Icon(Icons.sports_baseball_outlined),
                  text: const Text("Olahraga"),
                ),
                getItem(
                  icon: const Icon(Icons.motorcycle_sharp),
                  text: const Text("Otomotif"),
                ),
              ],
            ),
          ),
          Expanded(
            child: NewsPage(kategori: strKategori), // Kategori diteruskan ke NewsPage
          )
        ],
      ),
    );
  }

  getItem({required Icon icon, required Text text}) {
    return RotatedBox(
      quarterTurns: -1,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [icon, text],
        ),
      ),
    );
  }
}
