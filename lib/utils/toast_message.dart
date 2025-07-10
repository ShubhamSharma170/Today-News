import 'package:fluttertoast/fluttertoast.dart';
import 'package:today_news/constant/colors.dart';

toastMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: AllColors.orangeFF8C42,
    gravity: ToastGravity.BOTTOM,
    toastLength: Toast.LENGTH_LONG,
    fontSize: 16,
    textColor: AllColors.black,
  );
}
