import 'package:scan_me_plus/export.dart';

/*=================================================================== Image Pick Using camera ===================================================*/

Future<PickedFile?> imageFromCamera() async {
  var pickedFile = await ImagePicker()
      .pickImage(source: ImageSource.camera, imageQuality: 100);
  if (pickedFile == null) {
    AppAlerts.custom(message: 'no_image_clicked'.tr);
  } else {
    return cropImage(pickedFile.path);
  }
  return null;
}

/*=================================================================== Image Pick Using Gallery ===================================================*/

Future<PickedFile?> imageFromGallery() async {
  var pickedFile = await ImagePicker()
      .pickImage(source: ImageSource.gallery, imageQuality: 100);
  if (pickedFile == null) {
    AppAlerts.custom(message: 'no_image_selected'.tr);
  } else {
    return cropImage(pickedFile.path);
  }
  return null;
}

Future<PickedFile?> cropImage(filePath) async {
  var croppedImage = await ImageCropper().cropImage(
    sourcePath: filePath,
    aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
  );
  if (croppedImage == null) {
    AppAlerts.custom(message: 'no_image'.tr);
  } else {
    return PickedFile(croppedImage.path);
  }
  return null;
}
