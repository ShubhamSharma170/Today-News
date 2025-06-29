import 'package:today_news/constant/api.dart';
import 'package:today_news/network_manager/http_helper.dart';

class RestClient {
  static final HttpHelper httpHelper = HttpHelper();

  Future<dynamic> getHeadlineNews() async {
    Map<String, dynamic> response = await httpHelper.getAPI(
      url: "${newsHeadlinesAPI}us&apiKey=$apiKey",
    );
    return response;
  }
}
