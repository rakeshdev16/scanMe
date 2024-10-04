import 'package:scan_me_plus/export.dart';

class SendFeedbackBottomSheet {
  SendFeedbackBottomSheet.show({
    image,
  }) {
    Get.bottomSheet(SendFeedbackBottomSheetContent(image: image),
        isScrollControlled: true,
        backgroundColor: Colors.black,
        elevation: 0,
        isDismissible: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        )));
  }
}

class SendFeedbackBottomSheetContent extends StatelessWidget {
  var image;
  SendFeedbackBottomSheetContent({super.key, this.image});

  final RxList reasonsList =
      ['unscannable'.tr, 'lighting'.tr, 'damaged'.tr, 'others'.tr].obs;

  final TextEditingController carNoTextController = TextEditingController();
  final FocusNode carNoFocusNode = FocusNode();

  RxBool isRetake = false.obs;
  RxString scannedImage = "".obs;
  RxList sendReasons = [].obs;

  updateImageFile(Future<PickedFile?> imagePath) async {
    PickedFile? file = await imagePath;
    if (file != null) {
      scannedImage.value = file.path;
      scannedImage.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          )),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 2.5.h,
                width: 40.w,
                decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(20.r)),
              ).paddingOnly(bottom: 17.h),
            ),
            _feedbackHeadingAndImage(context),
            _reasonsList(context),
            _describeQr(context),
            _safeReportInfo(context),
            _submitCancelButtons(),
          ],
        ).paddingSymmetric(horizontal: 15.w, vertical: 15.h),
      ),
    );
  }

  _feedbackHeadingAndImage(context) => Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(
              'qr_not_working'.tr,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'send_feedback_to_us'.tr,
              style: Theme.of(context).textTheme.bodyMedium,
            ).paddingOnly(bottom: 18.h),
            Obx(() => Image.file(
                  File(isRetake.value ? scannedImage.value : image),
                  height: 140.h,
                  width: 110.h,
                  fit: BoxFit.fill,
                )),
            Inkwell(
              onTap: () {
                updateImageFile(imageFromCamera());
                isRetake.value = true;
              },
              child: Text(
                'retake'.tr,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.kPrimaryColor),
              ).paddingOnly(top: 10.h, bottom: 20.h),
            ),
          ],
        ),
      );

  _reasonsList(context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('select_one_more_reason'.tr,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w300, color: Colors.white70)),
          Wrap(
              children: List.generate(
                  reasonsList.length,
                  (index) => Obx(
                        () => Inkwell(
                          onTap: () {
                            if (sendReasons.contains(reasonsList[index])) {
                              sendReasons.remove(reasonsList[index]);
                            } else {
                              sendReasons.add(reasonsList[index]);
                            }
                            sendReasons.refresh();
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 8.w, bottom: 8.h),
                            decoration: BoxDecoration(
                                color: sendReasons.contains(reasonsList[index])
                                    ? AppColors.kPrimaryColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                    color: Colors.white10, width: 0.5.w)),
                            child: Text(reasonsList[index],
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.w300,
                                            color:
                                                Colors.white.withOpacity(0.85)))
                                .paddingSymmetric(
                                    horizontal: 12.w, vertical: 8.h),
                          ),
                        ),
                      ))).paddingOnly(top: 15.h, bottom: 6.h),
        ],
      );

  _describeQr(context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('describe_this_qr_code'.tr,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w300,
                  color: Colors.white.withOpacity(0.85))),
          CustomTextField(
            controller: carNoTextController,
            focusNode: carNoFocusNode,
            textCapitalization: TextCapitalization.sentences,
            hint: 'please_mention_car'.tr,
            minLines: 2,
            maxLines: 2,
            textInputAction: TextInputAction.done,
            validator: (value) => FieldChecker.fieldChecker(
                value: value, message: 'description'.tr),
          ).paddingOnly(top: 5.h, bottom: 15.h),
        ],
      );

  _safeReportInfo(context) => RichText(
          text: TextSpan(
              text: 'report_save_with_scan_me_plus'.tr,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w300, color: Colors.white70),
              children: [
            TextSpan(
                text: 'privacy_policy'.tr.toLowerCase(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w300,
                    color: AppColors.kPrimaryColor.withOpacity(0.8))),
            TextSpan(
                text: 'and'.tr,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w300, color: Colors.white70)),
            TextSpan(
                text: 'terms_of_service'.tr.toLowerCase(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w300,
                    color: AppColors.kPrimaryColor.withOpacity(0.8))),
          ])).paddingOnly(bottom: 30.h);

  _submitCancelButtons() => Row(
        children: [
          Expanded(
              child: CustomButton(
            text: 'cancel'.tr,
            padding: EdgeInsets.symmetric(vertical: 8.h),
            backgroundColor: Colors.transparent,
            borderColor: AppColors.kPrimaryColor,
            textColor: AppColors.kPrimaryColor,
            onPressed: () {
              Get.offAllNamed(AppRoutes.routeHome);
            },
          )),
          SizedBox(
            width: 8.w,
          ),
          Expanded(
              child: CustomButton(
            text: 'submit'.tr,
            isLoading: Get.find<ScanQRController>().sendQRFeedbackLoading,
            padding: EdgeInsets.symmetric(vertical: 8.h),
            onPressed: () {
              if (FieldChecker.fieldChecker(
                      value: carNoTextController.text.trim(),
                      message: 'description'.tr) ==
                  null) {
                Get.find<ScanQRController>().sendQRImage(
                    imagePath: isRetake.value ? scannedImage.value : image,
                    reason: sendReasons.value.toList(),
                    feedback: carNoTextController.text.trim());
              }
            },
          )),
        ],
      );
}
