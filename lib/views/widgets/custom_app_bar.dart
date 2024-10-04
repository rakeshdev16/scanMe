import 'package:scan_me_plus/export.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;
  final String? title;
  final Widget? leading;
  final bool? isLeadingVisible;
  final VoidCallback? onBackPress;
  final List<Widget>? widgets;

  const CustomAppBar(
      {Key? key,
      this.title,
      this.leading,
      this.onBackPress,
      this.backgroundColor = Colors.transparent,
      this.isLeadingVisible = true,
      this.widgets})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      title: title != null && title != ''
          ? Text(
              title!,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
            )
          : const SizedBox(),
      centerTitle: true,
      leading: leading ??
          (isLeadingVisible == true
              ? Inkwell(
                  onTap: onBackPress ??  () => Get.back(result: true),
                  child: Image.asset(AppImages.iconBack).paddingAll(16.w))
              : const SizedBox()),
      actions: widgets,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.h);
}
