import 'package:scan_me_plus/export.dart';

class Helpers {
  Helpers._();

  static String getCompleteUrl(String? url) {
    if (url == null) return "";

    if (url.startsWith('http')) {
      return url;
    } else {
      return ApiUrls.baseUrl + url;
    }
  }

  static printLog({required String screenName, required String message}) {
    if (AppConsts.isDebug) debugPrint("$screenName ==== $message");
  }

  static bool isResponseSuccessful(int code) {
    return code >= 200 && code < 300;
  }

  static String getImgUrl(String? url) {
    debugPrint("url ======= = $url");

    if (url == null) return '';
    if (url.startsWith('http')) {
      return url;
    } else {
      return ApiUrls.baseUrl + url;
    }
  }

  static String twelveHourTimeFormat(String? time) {
    if (time != null) {
      if (time.contains(':')) {
        List<String> splitTime = time.split(':');
        int hour = int.parse(splitTime.first);
        int minute = int.parse(splitTime.last);

        if (hour <= 12) {
          return '${hour <= 9 ? '0$hour' : hour}:${minute <= 9 ? '0$minute' : minute} AM';
        } else {
          return '${(hour - 12) <= 9 ? '0${hour - 12}' : (hour - 12)}:${minute <= 9 ? '0$minute' : minute} PM';
        }
      }
      return '';
    } else {
      return '';
    }
  }

  static String getTimeAgo(DateTime? time) {
    if (time == null) return '';

    String timeAgo = '';
    var minutes = DateTime.now().difference(time).inMinutes;
    if (minutes < 60) {
      timeAgo = "${minutes.round()} minutes ago";
    } else if (minutes < 1440) {
      timeAgo = "${(minutes / 60).round()} hours ago";
    } else if (minutes < 43800) {
      timeAgo = "${(minutes / 1440).round()} days ago";
    } else if (minutes < 525800) {
      timeAgo = "${(minutes / 43800).round()} months ago";
    } else {
      timeAgo = "${(minutes / 525800).round()} years ago";
    }
    return timeAgo;
  }
}
