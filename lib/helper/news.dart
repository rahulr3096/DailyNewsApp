import 'dart:convert';

import 'package:newsapppro/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<Article> news = [];

  Future<void> getNews() async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=in&excludeDomains=stackoverflow.com&sortBy=publishedAt&language=en&apiKey=9856683d00c14f54a4978631a8f76d20";

    var response = await http.get(Uri.parse(url));

    var jsonData = json.decode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          // if (element['author'] == null) {
          element['author'] = '';
          Article article = Article(
            title: element['title'],
            author: element['author'] ?? "",
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            url: element["url"],
          );
          news.add(article);
          // }
        }
      });
    }
  }
}

class CategoryNewsClass {
  List<Article> news = [];

  Future<void> getNews(String category) async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=9856683d00c14f54a4978631a8f76d20";
    // "https://newsapi.org/v2/top-headlines?country=us&apiKey=9856683d00c14f54a4978631a8f76d20";
    // "http://newsapi.org/v2/top-headlines?country=in&excludeDomains=stackoverflow.com&sortBy=publishedAt&language=en&apiKey=9856683d00c14f54a4978631a8f76d20";

    var response = await http.get(Uri.parse(url));

    var jsonData = json.decode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          // if (element['author'] == null) {
          element['author'] = '';
          Article article = Article(
            title: element['title'],
            author: element['author'] ?? "",
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            url: element["url"],
          );
          news.add(article);
          // }
        }
      });
    }
  }
}
