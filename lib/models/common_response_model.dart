class CommonResponseModel {
  int statusCode;
  String? errorMessage;
  String? response;

  CommonResponseModel(
      {required this.statusCode, this.errorMessage, this.response});
}
