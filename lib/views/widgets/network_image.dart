import 'package:scan_me_plus/export.dart';

class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? radiusAll;
  final double radiusTopRight;
  final double radiusTopLeft;
  final double radiusBottomRight;
  final double radiusBottomLeft;
  final double imageHeight;
  final double imageWidth;
  final BoxFit imageFitType;
  final Color? color;
  final String? placeHolder;
  final Widget? placeHolderWidget;

  const NetworkImageWidget(
      {Key? key,
      required this.imageUrl,
      this.radiusAll,
      this.radiusTopLeft = 0.0,
      this.radiusBottomRight = 0.0,
      this.radiusBottomLeft = 0.0,
      this.radiusTopRight = 0.0,
      required this.imageHeight,
      required this.imageWidth,
      this.color,
      this.placeHolder,
      this.placeHolderWidget,
      this.imageFitType = BoxFit.fill})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: radiusAll == null
            ? BorderRadius.only(
                topRight: Radius.circular(radiusTopRight),
                topLeft: Radius.circular(radiusTopLeft),
                bottomLeft: Radius.circular(radiusBottomLeft),
                bottomRight: Radius.circular(radiusBottomRight))
            : BorderRadius.circular(radiusAll!),
        child: FancyShimmerImage(
          height: imageHeight,
          width: imageWidth,
          boxFit: imageFitType,
          imageUrl: '${ApiUrls.imageBaseUrl}$imageUrl',
          errorWidget: placeHolderWidget ??  Image.asset(
            placeHolder ?? AppImages.iconPlaceholder,
            height: imageHeight,
            width: imageWidth,
            fit: imageFitType,
          ),
        ));
  }
}
