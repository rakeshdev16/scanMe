import 'package:scan_me_plus/export.dart';

class BlockedUsersListScreen extends GetView<BlockedUsersListController> {
  const BlockedUsersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: 'blocked_users'.tr,
        backgroundColor: AppColors.whiteShadeBgColor.withOpacity(0.1),
      ),
      body: Obx(
        () => controller.usersLoading.value
            ? const CommonProgressBar().paddingSymmetric(vertical: 180.h)
            : controller.blockedUsersList.isNotEmpty
                ? ListView.separated(
                    itemCount: controller.blockedUsersList.length,
                    itemBuilder: (BuildContext context, int index) => Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 12.h,
                      ),
                      child: Row(
                        children: [
                          NetworkImageWidget(
                            imageUrl: '',
                            imageHeight: 40.h,
                            imageWidth: 40.h,
                            radiusAll: 50.r,
                            placeHolder: AppImages.iconDummyProfile,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                                '@${controller.blockedUsersList[index].blockedUser?.userId ?? ""}',
                                style: Theme.of(context).textTheme.bodyLarge),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Inkwell(
                            onTap: () {
                              controller.unblockUser(
                                  controller.blockedUsersList[index]);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: AppColors.kPrimaryColor),
                              child: Text(
                                'unblock'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontSize: 10.sp),
                              ).paddingSymmetric(
                                  vertical: 6.h, horizontal: 15.w),
                            ),
                          )
                        ],
                      ),
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                      color: Colors.white10,
                    ),
                  ).paddingSymmetric(vertical: 10.h, horizontal: 15.w)
                : const EmptyStateWidget().paddingSymmetric(vertical: 120.h),
      ),
    );
  }
}
