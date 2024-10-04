import 'package:scan_me_plus/export.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<HomeController>()) {
      Get.put(HomeController());
    }
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _appBar(context),
              controller.onAddVehicleTapped.value == true
                  ? _addVehicle(context)
                  : _banners(),
              controller.onAddVehicleTapped.value == true
                  ? const SizedBox()
                  : _pageIndicator(),
              _yourVehicleText(context),
              _vehiclesList(),
              _searchTextField(),
            ],
          ).paddingOnly(top: 40.h, bottom: 20.h),
        ),
      ),
    );
  }

  _appBar(context) =>  Row(
          children: [
            Inkwell(
              onTap: (){
                Get.find<MainController>().selectedTab.value = 4 ;
                Get.find<MainController>().selectedTab.refresh();
              },
              child: Obx(()=>  NetworkImageWidget(
                  imageUrl: controller.user.value?.image ?? '',
                  imageHeight: 44.h,
                  imageWidth: 44.h,
                  radiusAll: 100.r,
                  imageFitType: BoxFit.fill,
                  placeHolderWidget: Container(
                    height: 44.h,
                    width: 44.h,
                    decoration: BoxDecoration(
                      color: AppColors.kPrimaryColor,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      controller.user.value?.userId?.split('').first.toUpperCase() ?? '',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 16.w,
            ),
            _addVehicleButton(context),
            SizedBox(
              width: 16.w,
            ),
            Inkwell(
              onTap: () {
                Get.toNamed(AppRoutes.routeAlertNotifications);
              },
              child: Obx(
                () => Image.asset(
                  Get.find<MainController>().isNewNotification.value == true
                      ? AppImages.iconNotification
                      : AppImages.iconNotification2,
                  height: 45.h,
                ),
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 15.w);

  _addVehicleButton(context) => Expanded(
        child: Inkwell(
          onTap: () {
            controller.onAddVehicleTapped.value =
                !controller.onAddVehicleTapped.value;
            controller.vehicleNumberTextController.clear();
          },
          child: Container(
            height: 35.h,
            decoration: BoxDecoration(
                color: AppColors.kPrimaryColor,
                borderRadius: BorderRadius.circular(40.r)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  controller.onAddVehicleTapped.value == true
                      ? AppImages.iconClose
                      : AppImages.iconAdd,
                  height:
                      controller.onAddVehicleTapped.value == true ? 12.h : 15.h,
                ).paddingOnly(right: 10.w),
                Text(
                    controller.onAddVehicleTapped.value == true
                        ? 'close'.tr
                        : 'add_vehicle'.tr,
                    style: Theme.of(context).textTheme.bodyLarge)
              ],
            ),
          ),
        ),
      );

  _addVehicle(context) => Container(
        width: Get.width,
        decoration: BoxDecoration(
            color: AppColors.whiteShadeBgColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15.r)),
        child: Column(
          children: [
            Text(
              'enter_your_vehicle_number'.tr,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(fontWeight: FontWeight.w500),
            ).paddingOnly(bottom: 22.h),
            CustomTextField(
              controller: controller.vehicleNumberTextController,
              focusNode: controller.vehicleNumberFocusNode,
              maxLength: 10,
              inputFormatters: [
                FilteringTextInputFormatter.deny(' '),
                UpperCaseTextFormatter()
              ],
              textCapitalization: TextCapitalization.characters,
              onChange: (value) {
                var validate = VehicleNumberValidate.validateVehicle(value);
                if (validate == null) {
                  controller.addNowEnable.value = true;
                } else {
                  controller.addNowEnable.value = false;
                }
              },
            ),
            _addVehicleInfo(context),
            CustomButton(
                text: 'add_now'.tr,
                backgroundColor: controller.addNowEnable.value == true
                    ? AppColors.kPrimaryColor
                    : AppColors.addNowButtonColor,
                borderColor: controller.addNowEnable.value == true
                    ? AppColors.kPrimaryColor
                    : AppColors.addNowButtonColor,
                isEnable: controller.addNowEnable,
                onPressed: () {
                  _vehicleDetailsNotFetchedBottomSheet();
                }).paddingSymmetric(vertical: 10.h)
          ],
        ).paddingSymmetric(horizontal: 30.w, vertical: 25.h),
      ).paddingSymmetric(horizontal: 15.w, vertical: 20.h);

  _addVehicleInfo(context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            AppImages.iconInformation,
            height: 10.h,
          ).paddingOnly(right: 2.w, top: 2.h),
          Flexible(
            child: Text(
              'vehicle_number_information'.tr,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: 10.sp),
              maxLines: 3,
            ),
          )
        ],
      ).paddingOnly(top: 10.h, bottom: 16.h, left: 5.w, right: 5.w);

  _banners() => SizedBox(
        height: 200.h,
        width: Get.width,
        child: Obx(() => controller.bannerList.isNotEmpty
            ? CarouselSlider.builder(
                carouselController: controller.pageController,
                itemCount: controller.bannerList.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: NetworkImageWidget(
                    imageUrl:  controller.bannerList[itemIndex].image ?? '',
                    imageHeight: 200.h,
                    imageWidth: Get.width,
                  ),
                ).marginSymmetric(horizontal: 15.h),
                options: CarouselOptions(
                    viewportFraction: 1,
                    autoPlay: true,
                    onPageChanged: (page, reason) {
                      controller.currentBannerIndex.value = page;
                    }),
              ).paddingOnly(top: 25.h, bottom: 15.w)
            : const SizedBox()),
      );

  _pageIndicator() => Obx(
        () => controller.bannerList.isNotEmpty
            ? Container(
                width: Get.width,
                height: 7.h,
                alignment: Alignment.center,
                child: AnimatedSmoothIndicator(
                  activeIndex: controller.currentBannerIndex.value,
                  count: controller.bannerList.length,
                  axisDirection: Axis.horizontal,
                  effect: WormEffect(
                      activeDotColor: AppColors.kPrimaryColor,
                      dotColor: AppColors.unSelectedColor,
                      dotHeight: 5.h,
                      dotWidth: 5.h,
                      spacing: 5.w,
                      radius: 44.r),
                ),
              )
            : Container(),
      );

  _yourVehicleText(context) => Text(
        'your_vehicle'.tr,
        style: Theme.of(context)
            .textTheme
            .displaySmall
            ?.copyWith(fontWeight: FontWeight.w400, fontSize: 22.sp),
      ).paddingSymmetric(horizontal: 15.w, vertical: 12.h);

  _vehiclesList() => SizedBox(
        height: 225.h,
        child: ListView.separated(
          itemCount: controller.myVehiclesList.length + 1,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(vertical: 10.h),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) =>
              index == controller.myVehiclesList.length
                  ? _addVehicleCard(context)
                  : _vehicleListView(context, index),
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            width: 15.w,
          ),
        ),
      );

  _vehicleListView(context, index) => Obx(
        () => Container(
          width: Get.width * 0.64,
          margin: EdgeInsets.only(
            left: index == 0 ? 15.w : 0,
          ),
          decoration: BoxDecoration(
              color: AppColors.whiteShadeBgColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.r)),
          child: controller.myVehiclesList[index].isDeleted ?? false
              ? Banner(
                  message: 'inactive'.tr,
                  location: BannerLocation.topStart,
                  color: AppColors.kPrimaryColor,
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.black),
                  child: _vehicleListViewContent(context, index),
                )
              : _vehicleListViewContent(context, index),
        ),
      );

  _vehicleListViewContent(context, index) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: NetworkImageWidget(
                  imageUrl:
                      controller.myVehiclesList[index].vehicleModel?.image ??
                          '',
                  imageHeight: 110.h,
                  imageWidth: Get.width,
                  imageFitType: BoxFit.cover,
                ),
              ),
              _vehiclePopUpMenu(context, index: index)
            ],
          ).paddingOnly(top: 10.h, left: 12.w, right: 12.w),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: AppColors.whiteShadeBgColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r)),
                child: NetworkImageWidget(
                  imageUrl:
                      controller.myVehiclesList[index].vehicleBrand?.image ??
                          '',
                  imageHeight: 18.h,
                  imageWidth: 25.w,
                  imageFitType: BoxFit.contain,
                ).paddingSymmetric(horizontal: 5.w, vertical: 8.h),
              ).paddingOnly(right: 10.w),
              Flexible(
                  child: Text(
                '${controller.myVehiclesList[index].vehicleBrand?.name} ${controller.myVehiclesList[index].vehicleModel?.name} \n${controller.myVehiclesList[index].vehicleNumber}',
                textAlign: TextAlign.start,
                maxLines: 3,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w500, height: 1.1),
              ))
            ],
          ).paddingSymmetric(horizontal: 20.w),
          Inkwell(
            onTap: () {
              if (controller.myVehiclesList[index].isSubscribed == true) {
                _vehicleQr(context, index);
              } else {
                CommonBottomSheetBackground.show(
                    content: Column(
                  children: [
                    Text(
                      'subscription_not_purchased'.tr,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ).paddingOnly(bottom: 10.h),
                    CustomButton(
                      text: 'purchase_plan'.tr,
                      onPressed: () {
                        Get.toNamed(AppRoutes.routeUpgradePlans, arguments: {
                          'vehicleId': controller.myVehiclesList[index].id
                        });
                      },
                    ).paddingSymmetric(vertical: 10.h)
                  ],
                ));
              }
            },
            child: Text(
              'view_qr'.tr,
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: 11.sp, color: AppColors.kPrimaryColor),
            ),
          )
        ],
      ).paddingSymmetric(vertical: 10.h);

  _vehicleQr(context, index) => Get.dialog(
      Obx(
        () => ImageFiltered(
          imageFilter: ImageFilter.blur(
              sigmaX:
                  (controller.myVehiclesList[index].isDeleted ?? false) ? 2 : 0,
              sigmaY: (controller.myVehiclesList[index].isDeleted ?? false)
                  ? 2
                  : 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(30.h),
                    border: Border.all(
                        color: AppColors.kPrimaryColor,
                        width: 3.w
                    )
                ),
                padding: EdgeInsets.all(5.h),
                margin: EdgeInsets.symmetric(horizontal: 30.w),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.h)
                  ),
                  padding: EdgeInsets.all(8.h),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.h),
                    child: QrImageView(
                      padding: EdgeInsets.zero,
                      data: controller.myVehiclesList[index].qr ?? '',
                      backgroundColor: Colors.white,
                      embeddedImageStyle:
                      QrEmbeddedImageStyle(size: Size(Get.width * 0.28, 30.h)),
                      embeddedImage: const AssetImage('assets/icons/logo.jpg'),
                    ),
                  ),
                ),
              ),
              Text(
                'QR S/r: ${controller.myVehiclesList[index].srNo != '' && controller.myVehiclesList[index].srNo != null ? controller.myVehiclesList[index].srNo : '--'}',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodySmall,
              ).paddingOnly(top: 10.h)
            ],
          ),
        ),
      ),
      barrierColor: Colors.black.withOpacity(0.7),
      barrierDismissible: true);

  _addVehicleCard(context) => Inkwell(
        onTap: () {
          controller.onAddVehicleTapped.value = true;
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          margin: EdgeInsets.only(
              right: 15.w,
              left: controller.myVehiclesList.isNotEmpty ? 0 : 15.w),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppColors.whiteShadeBgColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.r)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                AppImages.iconAddVehicle,
                height: 100.h,
              ).paddingOnly(bottom: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.iconAdd,
                    height: 9.h,
                    color: AppColors.kPrimaryColor,
                  ).paddingOnly(right: 5.w),
                  Text(
                    'add_vehicle'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.kPrimaryColor),
                  )
                ],
              )
            ],
          ),
        ),
      );

  _vehiclePopUpMenu(context, {index}) => SizedBox(
        width: 15.h,
        height: 15.h,
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerTheme: const DividerThemeData(
              color: Colors.white24,
            ),
          ),
          child: PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem(
                  value: 1,
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0),
                  child: SizedBox(
                    height: 18.h,
                    child: Text(
                      "replacement".tr,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ).paddingOnly(bottom: 4.h),
                  )),
              PopupMenuDivider(
                height: 0.5.h,
              ),
              PopupMenuItem(
                  value: 2,
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0),
                  child: SizedBox(
                    height: 16.h,
                    child: Text(
                      controller.myVehiclesList[index].isShipment != null
                          ? "view_shipment".tr
                          : 'add_shipment'.tr,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )),
              PopupMenuDivider(
                height: 0.5.h,
              ),
              PopupMenuItem(
                  value: 3,
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0),
                  child: SizedBox(
                    height: 15.h,
                    child: Text(
                      (controller.myVehiclesList[index].isDeleted ?? false)
                          ? "retrieve".tr
                          : 'delete'.tr,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ))
            ],
            padding: EdgeInsets.zero,
            constraints: BoxConstraints.tightFor(
              width: 140.w,
            ),
            icon: Image.asset(
              AppImages.iconMore,
              height: 12.h,
            ),
            position: PopupMenuPosition.under,
            popUpAnimationStyle: AnimationStyle(
                curve: Curves.ease, duration: const Duration(seconds: 1)),
            color: Colors.black87.withOpacity(0.8),
            elevation: 0,
            onSelected: (value) {
              if (value == 1) {
                Get.toNamed(AppRoutes.routeReplacement, arguments: {
                  'vehicleData': controller.myVehiclesList[index]
                });
              } else if (value == 2) {
                if (controller.myVehiclesList[index].isShipment != null) {
                  controller.vehicleShippingStatus(
                      context, controller.myVehiclesList[index].isShipment);
                } else {
                  _proceedWithShipmentBottomSheet(
                      context, controller.myVehiclesList[index].id);
                }
              } else if (value == 3) {
                if (controller.myVehiclesList[index].isDeleted ?? false) {
                  controller.deleteVehicleTemporarily(index);
                } else {
                  _deleteVehicleBottomSheet(context, index: index);
                }
              }
            },
          ),
        ),
      );

  _proceedWithShipmentBottomSheet(context, vehicleId) =>
      CommonBottomSheetBackground.show(
          content: Column(
        children: [
          Text('sure_ship_to_location'.tr,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge),
          Row(
            children: [
              Expanded(
                  child: CustomButton(
                      text: 'yes'.tr,
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      onPressed: () {
                        Get.back();
                        Get.toNamed(AppRoutes.routeShippingAddress,
                            arguments: {'vehicleId': vehicleId});
                      })),
              SizedBox(
                width: 15.h,
              ),
              Expanded(
                  child: CustomButton(
                      text: 'no'.tr,
                      borderColor: AppColors.kPrimaryColor,
                      textColor: AppColors.kPrimaryColor,
                      backgroundColor: Colors.transparent,
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      onPressed: () {
                        Get.back();
                      }))
            ],
          ).paddingOnly(top: 15.h, bottom: 8.h)
        ],
      ));

  _searchTextField() => CustomTextField(
          label: 'search'.tr,
          hint: 'Eg:PB2A4543',
          onFieldSubmitted: (value) {
            controller.searchVehicle();
          },
          inputFormatters: [
            FilteringTextInputFormatter.deny(' '),
            UpperCaseTextFormatter()
          ],
          maxLines: 1,
          textCapitalization: TextCapitalization.characters,
          textInputAction: TextInputAction.done,
          maxLength: 10,
          suffixIcon: Inkwell(
            onTap: () {
              if (controller.searchTextController.text.trim() != '') {
                controller.searchVehicle();
              }
            },
            child: Image.asset(
              AppImages.iconSearch,
              height: 10.h,
            ).paddingSymmetric(vertical: 12.h, horizontal: 10.w),
          ),
          suffixIconWidget: Inkwell(
            onTap: () {
              controller.searchTextController.clear();
            },
            child: Image.asset(
              AppImages.iconClose,
              height: 10.h,
            ).paddingOnly(top: 7.h),
          ),
          controller: controller.searchTextController,
          focusNode: controller.searchFocusNode)
      .paddingSymmetric(horizontal: 15.w, vertical: 12.h);

  _vehicleDetailsNotFetchedBottomSheet() => CommonBottomSheetBackground.show(
      content: MessageBottomSheetContent(
          icon: AppImages.iconError404,
          messageText: 'oh_no_vehicle_not_found'.tr,
          buttonText: 'add_details_manually'.tr,
          onButtonPress: () {
            Get.back();
            controller.onAddVehicleTapped.value = false;
            controller.addNowEnable.value = false;
            Get.toNamed(AppRoutes.routeChooseVehicleType);
          }));

  _deleteVehicleBottomSheet(context, {index}) =>
      CommonBottomSheetBackground.show(
          content: Column(
        children: [
          Image.asset(
            AppImages.iconBin,
            height: 50.h,
          ),
          RichText(
              text: TextSpan(children: [
            WidgetSpan(
                child: Image.asset(
              AppImages.iconDanger,
              height: 20.h,
            ).paddingOnly(right: 6.w)),
            TextSpan(
                text: '${'temporary_deletion'.tr}: ',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: AppColors.kPrimaryColor)),
            TextSpan(
                text: 'temporary_deletion_info'.tr,
                style: Theme.of(context).textTheme.bodyLarge),
          ])).paddingOnly(top: 20.h, bottom: 15.h),
          RichText(
              text: TextSpan(children: [
            WidgetSpan(
                child: Image.asset(
              AppImages.iconDanger,
              height: 20.h,
            ).paddingOnly(right: 6.w)),
            TextSpan(
                text: '${'permanent_deletion'.tr}: ',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: AppColors.kPrimaryColor)),
            TextSpan(
                text: 'permanent_deletion_info'.tr,
                style: Theme.of(context).textTheme.bodyLarge),
          ])),
          Row(
            children: [
              Expanded(
                  child: CustomButton(
                text: 'temporary'.tr,
                onPressed: () {
                  Get.back();
                  _sureToDelete(context, 'temporary', index);
                },
              )),
              SizedBox(width: 10.w),
              Expanded(
                  child: CustomButton(
                text: 'permanent'.tr,
                borderColor: AppColors.redColor,
                backgroundColor: AppColors.redColor,
                onPressed: () {
                  Get.back();
                  _sureToDelete(context, 'permanent', index);
                },
              )),
            ],
          ).paddingOnly(top: 20.h, bottom: 5.h)
        ],
      ));

  _sureToDelete(context, type, index) => CommonBottomSheetBackground.show(
          content: Column(
        children: [
          Text(
              type == 'temporary'
                  ? 'sure_to_delete_temporary'.tr
                  : 'sure_to_delete_permanent'.tr,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge),
          Row(
            children: [
              Expanded(
                  child: CustomButton(
                      text: 'yes'.tr,
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      onPressed: () {
                        Get.back();
                        if (type == 'temporary') {
                          controller.deleteVehicleTemporarily(index);
                        } else {
                          controller.deleteVehiclePermanently(
                              controller.myVehiclesList[index]);
                        }
                      })),
              SizedBox(
                width: 10.h,
              ),
              Expanded(
                  child: CustomButton(
                      text: 'no'.tr,
                      borderColor: AppColors.kPrimaryColor,
                      textColor: AppColors.kPrimaryColor,
                      backgroundColor: Colors.transparent,
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      onPressed: () {
                        Get.back();
                      }))
            ],
          ).paddingOnly(top: 15.h, bottom: 8.h)
        ],
      ));
}
