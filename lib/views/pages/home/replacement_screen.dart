import 'package:scan_me_plus/export.dart';

class ReplacementScreen extends GetView<ReplacementController> {
  const ReplacementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        backgroundColor: AppColors.whiteShadeBgColor.withOpacity(0.1),
        title: 'replacement'.tr,
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _carDetails(context),
              _selectReason(),
              controller.reasonNotSelected.value == 1
                  ? Text('select_reason_to_proceed'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red))
                      .paddingOnly(top: 5.h, left: 10.w)
                  : const SizedBox(),
              _comments(),
              _selectAddress(context),
              _addressList(context),
              controller.addressNotSelected.value == 1
                  ? Text('select_address_to_proceed'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red))
                      .paddingOnly(bottom: 20.h, left: 10.w)
                  : const SizedBox(),
              _submitButton(),
            ],
          ).paddingSymmetric(horizontal: 15.w, vertical: 20.h),
        ),
      ),
    );
  }

  _carDetails(context) => Container(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
        decoration: BoxDecoration(
            color: AppColors.whiteShadeBgColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10.r)),
        child: Row(
          children: [
            NetworkImageWidget(
              imageUrl: controller.vehicleData.value.vehicleModel?.image ?? '',
              imageHeight: 60.h,
              imageWidth: 80.w,
              imageFitType: BoxFit.fitWidth,
            ).paddingOnly(right: 10.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                  color: AppColors.whiteShadeBgColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5.r)),
              child: NetworkImageWidget(
                imageUrl:
                    controller.vehicleData.value.vehicleBrand?.image ?? '',
                imageHeight: 15.h,
                imageWidth: 25.w,
                imageFitType: BoxFit.contain,
              ),
            ).paddingOnly(right: 10.w),
            Expanded(
              child: Text(
                  '${controller.vehicleData.value.vehicleBrand?.name ?? ''} \n${controller.vehicleData.value.vehicleModel?.name ?? ''} \n${controller.vehicleData.value.vehicleNumber ?? ''}',
                  style: Theme.of(context).textTheme.headlineMedium),
            ),
          ],
        ).paddingSymmetric(vertical: 10.h),
      ).paddingOnly(bottom: 20.h);

  _selectReason() => Obx(
        () => CustomDropdown<String>(
          dropdownItems: controller.reasonsList.value,
          focusNode: controller.reasonsFocusNode,
          dropdownValue: controller.selectedReason.value == ''
              ? null
              : controller.selectedReason.value,
          label: 'select_reason'.tr,
          hint: 'select'.tr,
          onChanged: (reason) {
            controller.selectedReason.value = reason;
            controller.reasonNotSelected.value = 0;
            controller.selectedReason.refresh();
          },
        ),
      );

  _comments() => CustomTextField(
        controller: controller.commentsTextController,
        focusNode: controller.commentsFocusNode,
        label: 'comments'.tr,
        textCapitalization: TextCapitalization.sentences,
        minLines: 3,
        maxLines: 3,
      ).paddingSymmetric(vertical: 15.h);

  _selectAddress(context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('select_address'.tr,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(fontWeight: FontWeight.w500)),
          Inkwell(
            onTap: () async {
              var data = await Get.toNamed(AppRoutes.routeShippingAddress,
                  arguments: {'fromReplacement': true});
              if (data != null) {
                controller.getShippingAddressesList();
              }
            },
            child: Text('+${'add_new_address'.tr}',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.kPrimaryColor)),
          ),
        ],
      ).paddingSymmetric(vertical: 5.h);

  _addressList(context) => Obx(
        () => controller.addressLoading.value
            ? const CommonProgressBar().paddingSymmetric(vertical: 40.h)
            : controller.shippingAddressList.isNotEmpty
                ? ListView.separated(
                    itemCount: controller.shippingAddressList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                            value: controller
                                .shippingAddressList[index].isSelected,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r)),
                            visualDensity: const VisualDensity(
                                horizontal: 0, vertical: -4),
                            materialTapTargetSize:
                                MaterialTapTargetSize.padded,
                            side: MaterialStateBorderSide.resolveWith(
                              (states) => BorderSide(
                                color: controller
                                        .shippingAddressList[index].isSelected
                                    ? AppColors.kPrimaryColor
                                    : AppColors.whiteShadeBgColor,
                                strokeAlign: 0,
                                width: 1.2,
                              ),
                            ),
                            checkColor: Colors.white,
                            onChanged: (value) {
                              for (var element
                                  in controller.shippingAddressList) {
                                if (element.id ==
                                    controller
                                        .shippingAddressList[index].id) {
                                  element.isSelected = true;
                                  controller.addressNotSelected.value = 0;
                                } else {
                                  element.isSelected = false;
                                }
                              }
                              var selectedIndex = controller
                                  .shippingAddressList
                                  .indexWhere((element) =>
                                      element.isSelected == true);
                              if (selectedIndex != -1) {
                                controller.selectedAddress.value = controller
                                    .shippingAddressList[selectedIndex].id!;
                              }
                              controller.shippingAddressList.refresh();
                            }).paddingOnly(right: 2.w),
                        Expanded(
                          child: Text(
                            '${controller.shippingAddressList[index].address ?? ''}, ${controller.shippingAddressList[index].city ?? ''}, ${controller.shippingAddressList[index].state ?? ''}, ${controller.shippingAddressList[index].pinCode ?? ''}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(
                      height: 10.h,
                    ),
                  ).paddingSymmetric(vertical: 15.h)
                : const EmptyStateWidget().paddingSymmetric(vertical: 50.h),
      );

  _submitButton() => CustomButton(
      text: 'submit'.tr,
      isLoading: controller.replacementRequestLoading,
      onPressed: () {
        if (controller.selectedReason.value != '' &&
            controller.selectedAddress.value != '') {
          controller.reasonNotSelected.value = 0;
          controller.addressNotSelected.value = 0;
          controller.replacementRequest();
        } else{
          controller.addressNotSelected.value = 1;
          controller.reasonNotSelected.value = 1;
        }
      });
}
