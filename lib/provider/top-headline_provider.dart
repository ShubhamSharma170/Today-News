// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:today_news/model/news_channel_model.dart';
import 'package:today_news/network_manager/rest_client.dart';

class TopheadlineProvider with ChangeNotifier {
  bool isLoading = false;
  NewsChannelModel model = NewsChannelModel();

  void getTopHeadlineProvider(String source) async {
    isLoading = true;
    notifyListeners();
    RestClient.getTopHeadlineNewsFromSource(source).then((value) {
      model = value;
      isLoading = false;
      notifyListeners();
    }).onError((error, stackTrace) {
      isLoading = false;
      notifyListeners();
    });
  }
}
