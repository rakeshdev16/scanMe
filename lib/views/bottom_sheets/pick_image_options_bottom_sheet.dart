import 'package:scan_me_plus/export.dart';

enum ImageSourceOptions { camera, gallery }

class PickImageOptionsBottomSheet {
  PickImageOptionsBottomSheet.show(
      {required Function() cameraFunction,
      required Function() galleryFunction}) {
    Get.bottomSheet(
        PickImageOptionsBottomSheetContent(
          cameraFunction: cameraFunction,
          galleryFunction: galleryFunction,
        ),
        backgroundColor: Colors.transparent);
  }
}

class PickImageOptionsBottomSheetContent extends StatelessWidget {
  final Function() cameraFunction;
  final Function() galleryFunction;
  const PickImageOptionsBottomSheetContent(
      {Key? key, required this.galleryFunction, required this.cameraFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(15.r)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Inkwell(
                onTap: cameraFunction,
                child: Text(
                  'take_a_photo'.tr,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.black),
                ),
              ),
              const Divider(
                color: Colors.black12,
              ).paddingSymmetric(vertical: 10.h),
              Inkwell(
                onTap: () => galleryFunction(),
                child: Text(
                  'choose_from_gallery'.tr,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.black),
                ),
              ),
            ],
          ).paddingSymmetric(vertical: 20.h, horizontal: 15.w),
        ),
        CustomButton(
            text: 'cancel'.tr,
            backgroundColor: Colors.grey.shade300,
            borderColor: Colors.grey.shade300,
            textColor: AppColors.redColor,
            onPressed: () {
              Get.back();
            }).paddingSymmetric(vertical: 15.h)
      ],
    ).paddingSymmetric(horizontal: 10.w, vertical: 10.h);
  }
}
