import 'package:scan_me_plus/export.dart';

class CustomScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool extendBodyBehindAppBar;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const CustomScaffold(
      {super.key,
      this.appBar,
      this.body,
      this.bottomNavigationBar,
      this.floatingActionButton,
      this.extendBodyBehindAppBar = false,
      this.floatingActionButtonLocation});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                AppImages.imgBackground,
              ))),
      child: Scaffold(
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        backgroundColor: Colors.transparent,
        body: body,
        appBar: appBar,
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
      ),
    );
  }
}
