import 'package:scan_me_plus/export.dart';

class CallingScreen extends GetView<CallingController> {
  const CallingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => Column(
                children: [
                  NetworkImageWidget(
                    imageUrl: '',
                    imageHeight: 120.h,
                    imageWidth: 120.h,
                    radiusAll: 120.r,
                    imageFitType: BoxFit.fill,
                    placeHolder: AppImages.iconDummyProfile,
                  ),
                  Text(controller.callStatus.value,
                          style: Theme.of(context).textTheme.bodyMedium).paddingOnly(top: 30.h),
                  controller.start.value > 0 ? Text(controller.intToTimeLeft(controller.start.value),
                          style: Theme.of(context).textTheme.bodyMedium).paddingOnly(top: 10.h) : Container(),
                  Text(controller.userName.value,
                          style: Theme.of(context).textTheme.displaySmall)
                      .paddingSymmetric(vertical: 10.h),
                ],
              ).paddingOnly(top: 40.h),
            ),
          ),
          _callActions(),
        ],
      ).paddingSymmetric(horizontal: 25.w, vertical: 60.h),
    );
  }

  _callActions() => Obx(()=>  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Inkwell(
              onTap: () {
                controller.speakerToggle();
              },
              child: Obx(()=>  Image.asset(
                  controller.speakerStatus.value == true? AppImages.iconCallSpeakerOn :  AppImages.iconCallSpeakerOff,
                  height: 50.h,
                ),
              ),
            ),
            Inkwell(
              onTap: () {
                controller.leave();
              },
              child: Image.asset(
                AppImages.iconEndCall,
                height: 60.h,
              ),
            ),
            Inkwell(
              onTap: (){
                controller.micToggle();
              },
              child: Image.asset(
                controller.micStatus.value == true?  AppImages.iconMuteCall : AppImages.iconUnMuteCall,
                height: 50.h,
              ),
            ),
          ],
        ),
  );


}
