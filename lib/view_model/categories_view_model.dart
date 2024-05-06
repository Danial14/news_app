import 'package:flutter/cupertino.dart';
import 'package:news_app/repository/categories_repository.dart';

class CategoriesViewModel with ChangeNotifier{
  CategoriesRepository _categoriesRepository = CategoriesRepository();
  var _categoriesViewModel;
  Future<void> fetchGeneralCategoryNews() async{
    _categoriesViewModel = await _categoriesRepository.fetchGeneralCategoryNews();
    notifyListeners();
  }
  Future<void> fetchSportsCategoryNews() async{
    _categoriesViewModel = await _categoriesRepository.fetchSportsCategoryNews();
    notifyListeners();
  }
  Future<void> fetchTechnologyCategoryNews() async{
    _categoriesViewModel = await _categoriesRepository.fetchTechnologyNews();
    notifyListeners();
  }
  Future<void> fetchBusinessCategoryNews() async{
    _categoriesViewModel = await _categoriesRepository.fetchBusinessCategoryNews();
    notifyListeners();
  }

  Future<void> fetchScienceCategoryNews() async{
    _categoriesViewModel = await _categoriesRepository.fetchScienceCategoryNews();
    notifyListeners();
  }
  Future<void> fetchHealthCategoryNews() async{
    _categoriesViewModel = await _categoriesRepository.fetchHealthCategoryNews();
    notifyListeners();
  }
  Future<void> fetchEntertainmentCategoryNews() async{
    _categoriesViewModel = await _categoriesRepository.fetchEntertainmentCategoryNews();
    notifyListeners();
  }
  dynamic get getCategoriesHeadLines{
    return _categoriesViewModel;
  }
  Future<bool> fetchInitialBusinessNews() async{
    try{
      await fetchBusinessCategoryNews();
      return true;
    }
    catch(e){
      return false;
    }
  }
}