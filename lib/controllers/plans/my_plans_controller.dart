import 'package:scan_me_plus/export.dart';

class MyPlansController extends GetxController {
  RxBool isShowMore = false.obs;
  RxBool planDataLoading = false.obs;
  RxBool renewPlanLoading = false.obs;
  RxBool cancelPlanLoading = false.obs;
  RxBool subscriptionLoading = false.obs;
  RxBool planCancelled = false.obs;
  RxBool planExpired = false.obs;

  RxString vehicleId = ''.obs;

  RxList<MembershipPlansData> planDetailData = <MembershipPlansData>[].obs;
  RxList<MembershipPlansData> upgradePlans = <MembershipPlansData>[].obs;
  Rx<MembershipPlansData> activePlan = MembershipPlansData().obs;
  Rx<MembershipPlansData> upcomingPlan = MembershipPlansData().obs;
  Razorpay razorpay = Razorpay();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      vehicleId.value = Get.arguments['vehicleId'];
      plansDetail();
    }
  }

  plansDetail() async {
    try {
      planDataLoading.value = true;
      var result = await GetRequests.fetchMembershipPlanList(vehicleId.value);
      if (result != null) {
        if (result.success!) {
          debugPrint("===>${jsonEncode(result.data?[0])}");
          debugPrint("===>${jsonEncode(result.data?[1])}");
          debugPrint("===>${jsonEncode(result.data?[2])}");
          planDetailData.clear();
          upgradePlans.clear();
          if (result.data != null) {
            planDetailData.value = result.data!;
            for (var element in planDetailData) {
              if (element.userSubscription != null) {
                if (element.userSubscription!.startAt!
                    .isAfter(DateTime.now())) {
                  upcomingPlan.value = element;
                }
                if (element.userSubscription?.status == 'active') {
                  activePlan.value = element;
                }
                if (element.userSubscription?.status == 'expired') {
                  activePlan.value = element;
                  planExpired.value = true;
                }
                else if (element.userSubscription?.status == 'halted') {
                  activePlan.value = element;
                  planExpired.value = true;
                }
                else if (element.userSubscription?.status == 'cancelled' &&
                    element.userSubscription!.endAt!
                        .isBefore(DateTime.now())) {
                  activePlan.value = element;
                  planExpired.value = true;
                }
                else if (element.userSubscription?.status == 'cancelled' &&
                    element.userSubscription!.endedAt!
                        .isBefore(DateTime.now())) {
                  activePlan.value = element;
                  planCancelled.value = true;
                }
              }
              else {
                upgradePlans.add(element);
              }
            }
            List<MembershipPlansData> finalList = [];
            if (activePlan.value.id != null) {

              for (var upgradePlansElement in upgradePlans) {

                if (upgradePlansElement.amount != null) {
                  if ((upgradePlansElement.amount!) <=
                      activePlan.value.amount!) {
                    debugPrint('upgradePlansElement  ${upgradePlansElement}');
                  }else{
                    finalList.add(upgradePlansElement);
                  }
                }
              }
            }
            upgradePlans.value = finalList ?? [];
          }
        } else {
          AppAlerts.error(message: result.message ?? '');
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {
      planDataLoading.value = false;
    }
  }

  Future<void> downloadInvoice() async {
    try {
      cancelPlanLoading.value = true;
      var response = await GetRequests.downloadInvoice(
          activePlan.value.userSubscription?.id ?? '');
      if (response != null) {
        if (response.success!) {
          if (response.data != null) {
            if (await canLaunchUrl(Uri.parse(response.data?.shortUrl ?? ''))) {
              await launchUrl(Uri.parse(response.data?.shortUrl ?? ''),
                  mode: LaunchMode.externalApplication);
            }
          }
        } else {
          AppAlerts.error(message: response.message ?? '');
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {
      cancelPlanLoading.value = false;
    }
  }

  Future<void> cancelSubscriptionPlan({id}) async {
    try {
      cancelPlanLoading.value = true;
      Map<String, dynamic> cancelSubscriptionPlanRequestBody = {
        "subscriptionId": id
      };
      var response = await PostRequests.cancelSubscriptionPlan(
          cancelSubscriptionPlanRequestBody);
      if (response != null) {
        if (response.success) {
          plansDetail();
          Get.back();
        } else {
          AppAlerts.error(message: response.message);
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {
      cancelPlanLoading.value = false;
    }
  }

  Future<void> renewSubscriptionPlan(MembershipPlansData plan) async {
    try {
      renewPlanLoading.value = true;
      Map<String, dynamic> subscriptionPlanRequestBody = {
        "planId": plan.id,
        "vehicleId": vehicleId.value
      };
      var response = await PostRequests.subscriptionPlanPurchase(
          subscriptionPlanRequestBody);
      if (response != null) {
        if (response.success!) {
          if (response.data != null) {
            upgradePremiumClick(
              subId: response.data!.id,
              name: plan.name,
              description: plan.description,
              amount: plan.amount,
            );
            // Get.to(CustomWebView(
            //   url: subscriptionPaymentLinkData.value.shortUrl ?? '',
            // ));
          }
        } else {
          AppAlerts.error(message: response.message ?? '');
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {
      renewPlanLoading.value = false;
    }
  }

  Future<void> subscriptionUpgrade(MembershipPlansData upgradePlan) async {
    try {
      subscriptionLoading.value = true;
      Map<String, dynamic> upgradeSubscriptionPlanRequestBody = {
        "planId": upgradePlan.id,
        "vehicleId": vehicleId.value,
        "currentSubscriptionId": activePlan.value.userSubscription?.id
      };
      var response = await PostRequests.upgradeSubscriptionPlan(
          upgradeSubscriptionPlanRequestBody);
      if (response != null) {
        if (response.success!) {
          if (response.data != null) {
            Get.back();
            upgradePremiumClick(
              subId: response.data!.id,
              name: upgradePlan.name,
              description: upgradePlan.description,
              amount: upgradePlan.amount,
            );
          }
        } else {
          AppAlerts.error(message: response.message ?? '');
        }
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } finally {
      subscriptionLoading.value = false;
    }
  }

  upgradePremiumClick({subId, amount, name, description}) {
    var options = {
      // 'key': 'rzp_test_hcXY1iVD3tvB36',
      'key': AppConsts.razorPayKey,
      'subscription_id': subId,
      'amount': amount,
      'name': name,
      'description': description,
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      // 'prefill': {'contact': '9999999999', 'email':'test@example.com'},
      // "readonly": { 'email': true, 'contact': true },
      'external': {
        'wallets': ['paytm']
      },
      "theme": {"color": "#F5AF2B"}
    };
    debugPrint('Payment $options');
/*Payment {key: rzp_test_Z0HPaahRvegg9P, subscription_id: sub_OJMpWB4IaCsnj8, amount: 90, name: 6 Month Plan, description: ₹90 Half Yearly, retry: {enabled: true, max_count: 1}, send_sms_hash: true, prefill: {contact: 919780440819, email: dummy@mail.com}, external: {wallets: [paytm]}}*/
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
    razorpay.open(options);
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    // Get.offAllNamed(AppRoutes.routeHome);
    // AppAlerts.alert(message: 'payment_failed'.tr);
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    paymentSuccessfulApiCall(response.data?['razorpay_subscription_id']);
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
          plansDetail();
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
}
