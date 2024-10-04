import 'package:scan_me_plus/export.dart';

class ChooseVehicleBrandScreen extends GetView<ChooseVehicleBrandController> {
  const ChooseVehicleBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        backgroundColor: AppColors.whiteShadeBgColor.withOpacity(0.1),
        title: 'choose_vehicle_brand'.tr,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _searchTextField(),
            _brandsList(),
          ],
        ).paddingSymmetric(horizontal: 15.w, vertical: 15.h),
      ),
    );
  }

  _searchTextField() => CustomTextField(
        hint: 'search_vehicle_brand'.tr,
        textCapitalization: TextCapitalization.sentences,
        prefixIcon: Image.asset(
          AppImages.iconSearch,
          height: 8.h,
        ).paddingSymmetric(vertical: 16.h, horizontal: 20.w),
        controller: controller.searchTextController,
        focusNode: controller.searchFocusNode,
        onChange: (value) {
          if (controller.vehicleBrandsList.isNotEmpty) {
            if (value != '') {
              controller.vehicleBrandsListToShow.value = controller
                  .vehicleBrandsList
                  .where((element) => (element.name!
                      .toLowerCase()
                      .contains(value.toLowerCase())))
                  .toList();
              controller.vehicleBrandsListToShow.refresh();
            } else {
              controller.vehicleBrandsListToShow.value =
                  controller.vehicleBrandsList;
            }
          }
        },
      ).paddingSymmetric(vertical: 10.h);

  _brandsList() => Obx(
        () => controller.isLoading.value
            ? const CommonProgressBar().paddingSymmetric(vertical: 180.h)
            : controller.vehicleBrandsListToShow.isNotEmpty
                ? ListView.separated(
                    itemCount: controller.vehicleBrandsListToShow.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) =>
                        VehicleListView(
                            text: controller
                                    .vehicleBrandsListToShow[index].name ??
                                '',
                            onPressed: () {
                              Get.toNamed(AppRoutes.routeChooseVehicleModel,
                                  arguments: {
                                    'vehicle_brand_data': controller
                                        .vehicleBrandsListToShow[index]
                                  });
                            }),
                    separatorBuilder: (BuildContext context, int index) =>
                        Container(
                      height: 1.h,
                      width: Get.width,
                      color: Colors.white10,
                    ),
                  ).paddingSymmetric(vertical: 10.h)
                : const EmptyStateWidget().paddingSymmetric(vertical: 120.h),
      );
}
