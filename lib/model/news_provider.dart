import 'package:flutter/material.dart';
import 'package:tugas_uas/model/model_news.dart';
import 'package:tugas_uas/network/network_services.dart';

class NewsProvider with ChangeNotifier {
  List<ModelNews> _newsList = [];

  List<ModelNews> get newsList => _newsList;

  Future<void> fetchNews(String kategori) async {
    _newsList = await NetworkService.fetchNews(kategori);
    notifyListeners();
  }
}
