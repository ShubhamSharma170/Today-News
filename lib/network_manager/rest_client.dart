import 'package:today_news/constant/api.dart';
import 'package:today_news/model/category_news_model.dart';
import 'package:today_news/model/news_channel_model.dart';
import 'package:today_news/model/topic_news_model.dart';
import 'package:today_news/network_manager/http_helper.dart';

class RestClient {
  static final HttpHelper httpHelper = HttpHelper();

  Future<dynamic> getHeadlineNews() async {
    Map<String, dynamic> response = await httpHelper.getAPI(
      url: "${newsHeadlinesAPI}us&apiKey=$apiKey",
    );
    return response;
  }

  // get top headline news from source
  static Future<NewsChannelModel> getTopHeadlineNewsFromSource(
    String source,
  ) async {
    Map<String, dynamic> response = await httpHelper.getAPI(
      url: "$topHeadlineApiURL=$source&apiKey=$apiKey",
    );
    return NewsChannelModel.fromJson(response);
  }

  static Future<CategoryNewsModel> getCategoryNews(String category) async {
    Map<String, dynamic> response = await httpHelper.getAPI(
      url: "$categoryNewsAPI$category&pageSize=15&apiKey=$apiKey",
    );
    return CategoryNewsModel.fromJson(response);
  }

  static Future<TopicNewsModel> getTopicNews(String topic) async {
    Map<String, dynamic> response = await httpHelper.getAPI(
      url: "$topicNewsAPI$topic&pageSize=15&apiKey=$apiKey",
    );
    return TopicNewsModel.fromJson(response);
  }
}
