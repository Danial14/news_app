import 'dart:convert';

import 'package:news_app/constants/constants.dart';

import '../models/categories_news_model.dart';
import 'package:http/http.dart' as http;

class CategoriesRepository{
  Future<CategoriesNewsModel> fetchGeneralCategoryNews() async{
    String url = "https://newsapi.org/v2/top-headlines?q=business&apiKey=${Constants.API_KEY}";
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      return CategoriesNewsModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("error in fetching general category news");
  }
  Future<CategoriesNewsModel> fetchSportsCategoryNews() async{
    String url = "https://newsapi.org/v2/top-headlines?q=sports&apiKey=${Constants.API_KEY}";
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      return CategoriesNewsModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("error in fetching sports category news");
  }
  Future<CategoriesNewsModel> fetchEntertainmentCategoryNews() async{
    String url = "https://newsapi.org/v2/top-headlines?q=sports&apiKey=${Constants.API_KEY}";
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      return CategoriesNewsModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("error in fetching sports category news");
  }
  Future<CategoriesNewsModel> fetchHealthCategoryNews() async{
    String url = "https://newsapi.org/v2/top-headlines?q=health&apiKey=${Constants.API_KEY}";
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      return CategoriesNewsModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("error in fetching health category news");
  }
  Future<CategoriesNewsModel> fetchScienceCategoryNews() async{
    String url = "https://newsapi.org/v2/top-headlines?q=science&apiKey=${Constants.API_KEY}";
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      return CategoriesNewsModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("error in fetching science category news");
  }
  Future<CategoriesNewsModel> fetchBusinessCategoryNews() async{
    String url = "https://newsapi.org/v2/top-headlines?q=business&apiKey=${Constants.API_KEY}";
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      return CategoriesNewsModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("error in fetching business category news");
  }
  Future<CategoriesNewsModel> fetchTechnologyNews() async{
    String url = "https://newsapi.org/v2/top-headlines?q=technology&apiKey=${Constants.API_KEY}";
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      return CategoriesNewsModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("error in fetching technology category news");
  }
}