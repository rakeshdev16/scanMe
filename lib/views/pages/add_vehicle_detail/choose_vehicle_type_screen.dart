import 'package:scan_me_plus/export.dart';

class ChooseVehicleTypeScreen extends GetView<ChooseVehicleTypeController> {
  const ChooseVehicleTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        backgroundColor: AppColors.whiteShadeBgColor.withOpacity(0.1),
        title: 'choose_vehicle_type'.tr,
      ),
      body: ListView.separated(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) => VehicleListView(
            text: '${index + 2} - ${'wheeler'.tr}',
            onPressed: () {
              Get.toNamed(AppRoutes.routeChooseVehicleBrand,
                  arguments: {'vehicle_type': '${index + 2}WHEELER'});
            }),
        separatorBuilder: (BuildContext context, int index) => Container(
          height: 1.h,
          width: Get.width,
          color: Colors.white10,
        ),
      ).paddingSymmetric(horizontal: 15.w, vertical: 10.h),
    );
  }
}
