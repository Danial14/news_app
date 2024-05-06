import 'package:flutter/material.dart';
import 'package:news_app/repository/news_repository.dart';

class NewsViewModel with ChangeNotifier{
  NewsRepository _newsRepository = NewsRepository();
  var _newsHeadlinesModel;
  Future<void> fetchBbcHeadlinesNews() async{
   _newsHeadlinesModel = await _newsRepository.fetchBbcHeadlinesNews();
    notifyListeners();
  }
  Future<bool> fetchInitialHeadlinesNews(String source) async{
    try{
      await fetchBbcHeadlinesNews();
      return true;
    }
    catch(e){
      return false;
    }
  }
  Future<void> fetchAlJazeeraHeadlinesNews() async{
    _newsHeadlinesModel = await _newsRepository.fetchAlJazeeraHeadlinesNews();
    notifyListeners();
  }
  Future<void> fetchCnnHeadlinesNews() async{
   _newsHeadlinesModel = await _newsRepository.fetchCnnHeadlinesNews();
   print("cnn");
    notifyListeners();
  }
  Future<void> fetchIndependentHeadlinesNews() async{
   _newsHeadlinesModel = await _newsRepository.fetchIndependentHeadlinesNews();
    notifyListeners();
  }
  Future<void> fetchReutersHeadlinesNews() async{
   _newsHeadlinesModel = await _newsRepository.fetchReutersHeadlinesNews();
    notifyListeners();
  }
  dynamic get getHeadlines{
    return _newsHeadlinesModel;
  }

}