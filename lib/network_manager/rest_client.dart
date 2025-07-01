import 'package:today_news/constant/api.dart';
import 'package:today_news/model/news_channel_model.dart';
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
}
