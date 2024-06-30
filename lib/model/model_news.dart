class ModelNews {
  String? link;
  String? title;
  String? pubDate;
  String? description;
  String? thumbnail;

  ModelNews({this.link, this.title, this.pubDate, this.description, this.thumbnail});

  ModelNews.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    title = json['title'];
    pubDate = json['pubDate'];
    description = json['description'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['link'] = link;
    data['title'] = title;
    data['pubDate'] = pubDate;
    data['description'] = description;
    data['thumbnail'] = thumbnail;
    return data;
  }

  static List<ModelNews> fromJsonList(List list) {
    if (list.isEmpty) return List<ModelNews>.empty();
    return list.map((item) => ModelNews.fromJson(item)).toList();
  }
}