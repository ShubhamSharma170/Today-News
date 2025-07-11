// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:today_news/model/topic_news_model.dart';
import 'package:today_news/network_manager/rest_client.dart';

class TopicNewsProvider with ChangeNotifier {
  bool isLoading = false;
  TopicNewsModel model = TopicNewsModel();

  void topicNewsProvider(String topic) async {
    isLoading = true;
    notifyListeners();
    RestClient.getTopicNews(topic)
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
