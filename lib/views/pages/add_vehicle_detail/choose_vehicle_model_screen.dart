import 'package:scan_me_plus/export.dart';

class ChooseVehicleModelScreen extends GetView<ChooseVehicleModelController> {
  const ChooseVehicleModelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        backgroundColor: AppColors.whiteShadeBgColor.withOpacity(0.1),
        title: 'choose_vehicle_model'.tr,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _selectedBrand(context),
            _searchTextField(),
            _modelsList(),
          ],
        ).paddingSymmetric(horizontal: 15.w, vertical: 15.h),
      ),
    );
  }

  _searchTextField() => CustomTextField(
        hint: 'search_your_vehicle_model'.tr,
        textCapitalization: TextCapitalization.sentences,
        prefixIcon: Image.asset(
          AppImages.iconSearch,
          height: 8.h,
        ).paddingSymmetric(vertical: 16.h, horizontal: 20.w),
        textInputAction: TextInputAction.done,
        maxLines: 1,
        controller: controller.searchTextController,
        focusNode: controller.searchFocusNode,
        onChange: (value) {
          if (controller.vehicleModelsList.isNotEmpty) {
            if (value != '') {
              controller.vehicleModelsListToShow.value = controller
                  .vehicleModelsList
                  .where((element) => (element.name!
                      .toLowerCase()
                      .contains(value.toLowerCase())))
                  .toList();
              controller.vehicleModelsListToShow.refresh();
            } else {
              controller.vehicleModelsListToShow.value =
                  controller.vehicleModelsList;
            }
          }
        },
      ).paddingSymmetric(vertical: 10.h);

  _selectedBrand(context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 2.h),
            decoration: BoxDecoration(
                color: AppColors.whiteShadeBgColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5.r)),
            child: NetworkImageWidget(
              imageUrl: controller.vehicleBrand.value.image ?? '',
              imageHeight: 50.h,
              imageWidth: 60.w,
              imageFitType: BoxFit.contain,
            ),
          ).paddingOnly(bottom: 6.w),
          Text(
            controller.vehicleBrand.value.name ?? '',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: AppColors.kPrimaryColor, fontWeight: FontWeight.w400),
          )
        ],
      ).paddingSymmetric(vertical: 12.h);

  _modelsList() => Obx(
        () => controller.isLoading.value
            ? const CommonProgressBar().paddingSymmetric(vertical: 180.h)
            : controller.vehicleModelsListToShow.isNotEmpty
                ? ListView.separated(
                    itemCount: controller.vehicleModelsListToShow.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) =>
                        VehicleListView(
                            text: controller
                                    .vehicleModelsListToShow[index].name ??
                                '',
                            onPressed: () {
                              Get.toNamed(AppRoutes.routeConfirmVehicleDetails,
                                  arguments: {
                                    'vehicle_brand_data':
                                        controller.vehicleBrand.value,
                                    'vehicle_model_data': controller
                                        .vehicleModelsListToShow[index]
                                  });
                            }),
                    separatorBuilder: (BuildContext context, int index) =>
                        Container(
                      height: 1.h,
                      width: Get.width,
                      color: Colors.white10,
                    ),
                  )
                : const EmptyStateWidget().paddingSymmetric(vertical: 120.h),
      );
}
