import 'package:http/http.dart' as http;
import 'package:scan_me_plus/export.dart';

class RemoteService {
  static var client = http.Client();

  static const String _baseUrl = ApiUrls.baseUrl;

  static Map<String, String> getHeaders() {
    String userToken = PreferenceManager.userToken;
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json;charset=utf-8"
    };

    if (userToken.isNotEmpty) {
      headers.addAll({"Authorization": "Bearer $userToken"});
    }
    debugPrint('token = $userToken');
    return headers;
  }

  static Future<Map<String, String>> getHeadersFileUpload() async {
    String? bearerToken =
        PreferenceManager.getPref(PreferenceManager.prefKeyUserToken)
            as String?;
    Map<String, String> headers = {
      // "Accept": "application/json",
      // "Content-Type": "application/json;charset=utf-8"
    };

    if (bearerToken != null) {
      headers.addAll({"Authorization": "Bearer $bearerToken"});
    }
    return headers;
  }

  static Future<CommonResponseModel?> simplePost(
      Map<String, dynamic> requestBody, String endUrl) async {
    var isConnected = await InternetConnection.isConnected();

    if (!isConnected) {
      return null;
    }
    debugPrint('request_url = ${_baseUrl + endUrl}');
    Helpers.printLog(
        screenName: 'Remote_Service_simple_post',
        message: "request_data = $requestBody");

    var body = json.encode(requestBody);
    final response = await http.post(Uri.parse(_baseUrl + endUrl),
        headers: getHeaders(), body: body);

    debugPrint("Headers = ${getHeaders()}");
    debugPrint('request_url = ${_baseUrl + endUrl}');
    Helpers.printLog(
        screenName: 'Remote_Service_simple_post',
        message: "response = ${response.body}");

    var responseCode = response.statusCode;
    if (Helpers.isResponseSuccessful(responseCode)) {
      return CommonResponseModel(
          statusCode: responseCode, response: response.body);
    } else if (responseCode == 401 || responseCode == 403) {
      PreferenceManager.logoutUser();
      AppAlerts.logoutError(
          message: baseResponseModelFromJson(response.body).message);
    } else {
      return CommonResponseModel(
        statusCode: responseCode,
        response: response.body,
      );
    }
    return null;
  }

  static Future<CommonResponseModel?> simplePostWithImage(
      {required Map<String, String> requestBody,
      required String endUrl,
      Map<String, dynamic>? imagesData}) async {
    var isConnected = await InternetConnection.isConnected();

    if (!isConnected) {
      return null;
    }

    http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse(_baseUrl + endUrl));
    request.headers.addAll(await getHeadersFileUpload());

    if (imagesData != null) {
      for (String key in imagesData.keys) {
        request.files
            .add(await http.MultipartFile.fromPath(key, imagesData[key]!));
      }
    }

    request.fields.assignAll(requestBody);
    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    debugPrint('request_url = ${_baseUrl + endUrl}');
    debugPrint('fields = ${request.fields}');
    debugPrint('files = ${_baseUrl + endUrl}');
    Helpers.printLog(
        screenName: 'Remote_Service_simple_post_with_image',
        message: "response = ${response.body}");
    var responseCode = response.statusCode;
    if (Helpers.isResponseSuccessful(responseCode)) {
      return CommonResponseModel(
          statusCode: responseCode, response: response.body);
    } else if (responseCode == 401 || responseCode == 403) {

      PreferenceManager.logoutUser();
      AppAlerts.logoutError(
          message: baseResponseModelFromJson(response.body).message);
    } else {
      return CommonResponseModel(
        statusCode: responseCode,
        response: response.body,
      );
    }
    return null;
  }

  static Future<CommonResponseModel?> simplePut(
      {required String endUrl, Map<String, dynamic>? requestBody}) async {
    var isConnected = await InternetConnection.isConnected();

    if (!isConnected) {
      return null;
    }
    debugPrint('request_url = ${_baseUrl + endUrl}');
    Helpers.printLog(
        screenName: 'Remote_Service_simple_put',
        message: "request_data = $requestBody");
    var body = json.encode(requestBody);
    final response = await http.put(Uri.parse(_baseUrl + endUrl),
        headers: getHeaders(), body: body);

    Helpers.printLog(
        screenName: 'Remote_Service_simple_put',
        message: "response = ${response.body}");
    debugPrint('request_url = ${_baseUrl + endUrl}');
    var responseCode = response.statusCode;
    if (Helpers.isResponseSuccessful(responseCode)) {
      return CommonResponseModel(
          statusCode: responseCode, response: response.body);
    } else if (responseCode == 401 || responseCode == 403) {

      PreferenceManager.logoutUser();
      AppAlerts.logoutError(
          message: baseResponseModelFromJson(response.body).message);
    } else {
      return CommonResponseModel(
        statusCode: responseCode,
        response: response.body,
      );
    }
    return null;
  }

  static Future<CommonResponseModel?> simpleGet(String endUrl) async {
    var isConnected = await InternetConnection.isConnected();

    if (!isConnected) {
      return null;
    }

    final response =
        await http.get(Uri.parse(_baseUrl + endUrl), headers: getHeaders());
    debugPrint('request_url = ${_baseUrl + endUrl}');
    debugPrint('request_headers = ${getHeaders().toString()}');
    Helpers.printLog(
        screenName: 'Remote_Service_simple_get',
        message: "response = ${response.body}");

    var responseCode = response.statusCode;
    debugPrint('response_code = $responseCode');
    if (Helpers.isResponseSuccessful(responseCode)) {
      return CommonResponseModel(
          statusCode: responseCode, response: response.body);
    } else if (responseCode == 401 || responseCode == 403) {

      PreferenceManager.logoutUser();
      AppAlerts.logoutError(
          message: baseResponseModelFromJson(response.body).message);
    } else {
      return CommonResponseModel(
        statusCode: responseCode,
        response: response.body,
      );
    }
    return null;
  }

  static Future<CommonResponseModel?> uploadPhotos(
      {required Map<String, dynamic> imagesData,
      required String endUrl}) async {
    var isConnected = await InternetConnection.isConnected();

    if (!isConnected) {
      return null;
    }

    http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse(_baseUrl + endUrl));
    request.headers.addAll(await getHeadersFileUpload());
    for (String key in imagesData.keys) {
      request.files.add(await http.MultipartFile.fromPath(key, imagesData[key],
          contentType: MediaType('image', 'jpg')));
    }

    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    debugPrint('request_url = ${_baseUrl + endUrl}');
    Helpers.printLog(
        screenName: 'Remote_Service_upload_photos',
        message: "response = ${response.body}");
    var responseCode = response.statusCode;
    if (Helpers.isResponseSuccessful(responseCode)) {
      return CommonResponseModel(
          statusCode: responseCode, response: response.body);
    } else if (responseCode == 401 || responseCode == 403) {

      PreferenceManager.logoutUser();
      AppAlerts.logoutError(
          message: baseResponseModelFromJson(response.body).message);
    } else {
      return CommonResponseModel(
        statusCode: responseCode,
        response: response.body,
      );
    }
    return null;
  }

  static Future<CommonResponseModel?> uploadPhotosPost(
      {required List<String> paths, required String endUrl}) async {
    var isConnected = await InternetConnection.isConnected();

    if (!isConnected) {
      return null;
    }

    http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse(_baseUrl + endUrl));
    request.headers.addAll(await getHeadersFileUpload());
    for (String path in paths) {
      request.files.add(await http.MultipartFile.fromPath('file', path));
    }

    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    debugPrint('request_url = ${_baseUrl + endUrl}');
    debugPrint('${request.files}');
    debugPrint('${response.statusCode}');
    Helpers.printLog(
        screenName: 'Remote_Service_upload_photos_post',
        message: "response = ${response.body}");
    var responseCode = response.statusCode;
    if (Helpers.isResponseSuccessful(responseCode)) {
      return CommonResponseModel(
          statusCode: responseCode, response: response.body);
    } else if (responseCode == 401 || responseCode == 403) {

      PreferenceManager.logoutUser();
      AppAlerts.logoutError(
          message: baseResponseModelFromJson(response.body).message);
    } else {
      return CommonResponseModel(
        statusCode: responseCode,
        response: response.body,
      );
    }
    return null;
  }

  static Future<CommonResponseModel?> simpleDelete(String endUrl) async {
    var isConnected = await InternetConnection.isConnected();

    if (!isConnected) {
      return null;
    }

    final response =
        await http.delete(Uri.parse(_baseUrl + endUrl), headers: getHeaders());

    debugPrint('request_url = ${_baseUrl + endUrl}');
    Helpers.printLog(
        screenName: 'Remote_Service_simple_delete',
        message: "response = ${response.body}");
    var responseCode = response.statusCode;
    if (Helpers.isResponseSuccessful(responseCode)) {
      return CommonResponseModel(
          statusCode: responseCode, response: response.body);
    } else if (responseCode == 401 || responseCode == 403) {

      PreferenceManager.logoutUser();
      AppAlerts.logoutError(
          message: baseResponseModelFromJson(response.body).message);
    } else {
      return CommonResponseModel(
        statusCode: responseCode,
        response: response.body,
      );
    }
    return null;
  }
}
