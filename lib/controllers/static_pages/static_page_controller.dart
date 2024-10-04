import 'package:scan_me_plus/export.dart';

class StaticPageController extends GetxController {

  Rx<StaticPagesData> staticPageData = StaticPagesData().obs;

  RxBool isLoading = false.obs;
  RxString pageHeading = ''.obs;

  @override
  void onInit() {
    if(Get.arguments != null){
      pageHeading.value = Get.arguments['pageType'];
      getStaticPageData(pageHeading.value);
    }
    super.onInit();
  }


  getStaticPageData(page) async {
    isLoading.value = true;
    try {
      Map<String, dynamic> staticPageRequestBody = {
        "title": page,
      };
      var result = await PostRequests.staticPages(staticPageRequestBody);
      if (result != null) {
        if (result.success!) {
          if (result.data != null) {
            staticPageData.value = result.data!;
          }
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {
      isLoading.value = false;
    }
  }



}
