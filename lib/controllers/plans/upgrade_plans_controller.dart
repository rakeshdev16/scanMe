import 'package:scan_me_plus/export.dart';

class UpgradePlansController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool subscriptionLoading = false.obs;

  RxList<MembershipPlansData> subscriptionPlansList = <MembershipPlansData>[].obs;

  Rx<MembershipPlansData> selectedMembershipPlan = MembershipPlansData().obs;

  Rx<SubscriptionPaymentLinkData> subscriptionPaymentLinkData =
      SubscriptionPaymentLinkData().obs;

  Razorpay razorpay = Razorpay();

  RxString vehicleId = ''.obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      vehicleId.value = Get.arguments['vehicleId'];
      getMemberPlansList();
    }
    super.onInit();
  }

  getMemberPlansList() async {
    try {
      isLoading.value = true;
      var result = await GetRequests.fetchMembershipPlanList(vehicleId.value);
      if (result != null) {
        if (result.success!) {
          if (result.data != null) {
            subscriptionPlansList.value = result.data!;
            selectedMembershipPlan.value = subscriptionPlansList.first;
            subscriptionPlansList.first.isSelected = true;
            subscriptionPlansList.refresh();
          }
        } else {
          AppAlerts.error(message: result.message ?? '');
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> subscriptionPurchase() async {
    try {
      subscriptionLoading.value = true;
      Map<String, dynamic> subscriptionPlanRequestBody = {
        "planId": selectedMembershipPlan.value.id,
        "vehicleId": vehicleId.value
      };
      var response = await PostRequests.subscriptionPlanPurchase(
          subscriptionPlanRequestBody);
      if (response != null) {
        if (response.success!) {
          if (response.data != null) {
            subscriptionPaymentLinkData.value = response.data!;
            // Get.to(CustomWebView(
            //   url: subscriptionPaymentLinkData.value.shortUrl ?? '',
            // ));
            upgradePremiumClick();
          }
        } else {
          AppAlerts.error(message: response.message ?? '');
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {}
  }

  upgradePremiumClick() {
    var options = {
      'key': AppConsts.razorPayKey,
      'subscription_id': subscriptionPaymentLinkData.value.id,
      'amount': selectedMembershipPlan.value.amount,
      'name': selectedMembershipPlan.value.name,
      'description': selectedMembershipPlan.value.description,
      'retry': {'enabled': true, 'max_count': 1},
      "notify": {"sms": true, "email": true},
      'send_sms_hash': true,
      'prefill': {'contact': '9999999999', 'email':'test@example.com'},
      "readonly": { 'email': true, 'contact': true },
      'external': {
        'wallets': ['paytm']
      },
      // "options": {
      //   "checkout": {
      //     "method": {
      //       "netbanking": "1",
      //       "card": "1",
      //       "upi": "1",
      //       "wallet": "1",
      //       "paylater": "1"
      //     }
      //   }
      // },
      "theme": {
        "color": "#F5AF2B"
      }
    };
    debugPrint('Payment $options');
    /*Payment {key: rzp_test_Z0HPaahRvegg9P, subscription_id: sub_OJN3NdKz1JbfAQ, amount: 15, name: Monthly Plan, description: ₹15 Monthly, retry: {enabled: true, max_count: 1}, send_sms_hash: true, prefill: {contact: 447893929402, email: dummy@mail.com}, external: {wallets: [paytm]}}*/
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
    razorpay.open(options);
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    AppAlerts.error(message: 'payment_failed'.tr);
    Get.offAllNamed(AppRoutes.routeHome);
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    Future.delayed(const Duration(seconds: 5), () {
      paymentSuccessfulApiCall(response.data?['razorpay_subscription_id']);
    });
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {}

  Future<void> paymentSuccessfulApiCall(subscriptionId) async {
    try {
      Map<String, dynamic> paymentSuccessfulRequestBody = {
        "subscriptionId": subscriptionId,
      };
      var response =
          await PostRequests.paymentSuccessful(paymentSuccessfulRequestBody);
      if (response != null) {
        if (response.success) {
          Get.offAllNamed(AppRoutes.routeThanksForChoosingUs, arguments: {
          'vehicleId' : vehicleId.value
          });
        } else {
          AppAlerts.error(message: response.message);
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {
      subscriptionLoading.value = false;
    }
  }

  @override
  void onClose() {
    razorpay.clear();
    super.onClose();
  }
}
