import 'package:scan_me_plus/export.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<MainController>()) {
      Get.put(MainController());
    }
    return DoubleBack(
      child: CustomScaffold(
        body: Obx(() => controller.screens[controller.selectedTab.value]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _floatingActionButton(context),
        bottomNavigationBar: _bottomAppBar(context),
      ),
    );
  }

  _bottomAppBar(context) => ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.r),
          topLeft: Radius.circular(20.r),
        ),
        child: BottomAppBar(
            padding: EdgeInsets.only(bottom: 5.h, top: 0.h),
            // shape: const CircularNotchedRectangle(),
            shape: const AutomaticNotchedShape(
              RoundedRectangleBorder(),
              StadiumBorder(
                side: BorderSide(),
              ),
            ),
            surfaceTintColor: AppColors.whiteShadeBgColor.withOpacity(0.1),
            color: AppColors.whiteShadeBgColor.withOpacity(0.1),
            elevation: 0,
            height: 55.h,
            notchMargin: 8.w,
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _navBarItem(context,
                      index: 0,
                      icon: controller.selectedTab.value == 0
                          ? AppImages.iconBottomNavHomeSelected
                          : AppImages.iconBottomNavHomeUnSelected,
                      text: 'home'.tr, onTap: () {
                    controller.selectedTab.value = 0;
                    Get.find<HomeController>().getMyVehicleList();
                    Get.find<HomeController>().getProfile();
                  }),
                  _navBarItem(context,
                      index: 1,
                      icon: controller.selectedTab.value == 1
                          ? AppImages.iconBottomNavCallSelected
                          : AppImages.iconBottomNavCallUnSelected,
                      text: 'calls'.tr, onTap: () {
                    controller.selectedTab.value = 1;
                    Get.find<CallHistoryController>().getCallHistoryList();
                  }),
                  _navBarItem(
                    context,
                    index: 2,
                    text: 'scan_qr'.tr,
                  ),
                  _navBarItem(context,
                      index: 3,
                      icon: controller.selectedTab.value == 3
                          ? AppImages.iconBottomNavPlanSelected
                          : AppImages.iconBottomNavPlanUnSelected,
                      text: 'my_plans'.tr, onTap: () {
                    controller.selectedTab.value = 3;
                    Get.find<PurchaseListController>().getMyVehicleList();
                  }),
                  _navBarItem(context,
                      index: 4,
                      icon: controller.selectedTab.value == 4
                          ? AppImages.iconBottomNavProfileSelected
                          : AppImages.iconBottomNavProfileUnSelected,
                      text: 'profile'.tr, onTap: () {
                    controller.selectedTab.value = 4;
                    Get.find<MyProfileController>().getProfile();
                  }),
                ],
              ),
            )),
      );

  Widget _navBarItem(context, {icon, text, onTap, index}) => Expanded(
        child: Inkwell(
          onTap: onTap ?? () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon != null
                  ? Image.asset(
                      icon,
                      height: 20.h,
                    )
                  : SizedBox(
                      height: 20.h,
                    ),
              SizedBox(
                height: 7.h,
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: index == controller.selectedTab.value
                          ? AppColors.kPrimaryColor
                          : Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                    ),
              )
            ],
          ),
        ),
      );

  _floatingActionButton(context) => Visibility(
      visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
      child: Inkwell(
        onTap: () {
          Get.toNamed(AppRoutes.routeScanQr);
        },
        child: Image.asset(
          AppImages.iconBottomNavScanner,
          height: 55.h,
        ),
      ));
}
