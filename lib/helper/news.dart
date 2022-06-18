

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:news_api/models/article_model.dart';


class News {

  List<ArticleModel> news = [];
  Future<void> getNews() async{
    String url = "http://newsapi.org/v2/top-headlines?country=in&excludeDomains=stackoverflow.com&sortBy=publishedAt&language=en&apiKey";
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);
    if(jsonData['status']=="ok"){
      jsonData["articles"].forEach((element){
        if (element["urlToImage"] != null && element['description'] != null){
          ArticleModel articleModel = ArticleModel(
            title: element["title"],
            author: element["author"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element ["content"]
          );
          news.add(articleModel);
        }
      });

    }
  }
}
class CategoryNewsClass {

  List<ArticleModel> news = [];
  Future<void> getNews(String category) async{
    String url = "https://newsapi.org/v2/top-headlines?category=$category&country=in&&apiKey=84fdd07dd59c4b399adccd3606fac0f1";
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);
    if(jsonData['status']=="ok"){
      jsonData["articles"].forEach((element){
        if (element["urlToImage"] != null && element['description'] != null){
          ArticleModel articleModel = ArticleModel(
              title: element["title"],
              author: element["author"],
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"],
              content: element ["content"]
          );
          news.add(articleModel);
        }
      });

    }
  }
}





