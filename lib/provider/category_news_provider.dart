// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:today_news/model/category_news_model.dart';
import 'package:today_news/network_manager/rest_client.dart';

class CategoryNewsProvider with ChangeNotifier {
  bool isLoading = false;
  CategoryNewsModel model = CategoryNewsModel();

  void getCategoryNews(String category) async {
    isLoading = true;
    notifyListeners();
    RestClient.getCategoryNews(category)
        .then((value) {
          model = value;
          isLoading = false;
          notifyListeners();
        })
        .onError((error, stackTrace) {
          print("Error is ${error.toString()}");
          isLoading = false;
          notifyListeners();
        });
  }
}
