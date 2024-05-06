import 'dart:convert';
import 'dart:io';

import 'package:news_app/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/news_headlines_model.dart';

class NewsRepository{
  Future<NewsHeadlinesModel> fetchBbcHeadlinesNews() async{
    String url = "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=${Constants.API_KEY}";
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      return NewsHeadlinesModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("error");
  }
  Future<NewsHeadlinesModel> fetchCnnHeadlinesNews() async{
    String url = "https://newsapi.org/v2/top-headlines?sources=cnn&apiKey=${Constants.API_KEY}";
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      return NewsHeadlinesModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("error");
  }
  Future<NewsHeadlinesModel> fetchAlJazeeraHeadlinesNews() async{
    String url = "https://newsapi.org/v2/top-headlines?sources=al-jazeera-english&apiKey=${Constants.API_KEY}";
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      return NewsHeadlinesModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("error");
  }
  Future<NewsHeadlinesModel> fetchIndependentHeadlinesNews() async{
    String url = "https://newsapi.org/v2/top-headlines?sources=independent&apiKey=${Constants.API_KEY}";
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      return NewsHeadlinesModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("error");
  }
  Future<NewsHeadlinesModel> fetchReutersHeadlinesNews() async{
    String url = "https://newsapi.org/v2/top-headlines?sources=reuters&apiKey=${Constants.API_KEY}";
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      return NewsHeadlinesModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("error");
  }
}