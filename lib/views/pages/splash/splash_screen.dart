import 'package:scan_me_plus/export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    initTimer();
  }

  initTimer() {
    cancelTimer();
    _timer = Timer(const Duration(seconds: 3), () async {
      var currentCall = await getCurrentCall();
      if (currentCall != null) {
        Get.toNamed(AppRoutes.routeCalling, arguments: currentCall['extra']);
      } else {
        _moveToNext();
      }
    });
  }

  cancelTimer() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
  }

  _moveToNext() {
    debugPrint("User = ${PreferenceManager.user}");
    debugPrint("FirstLaunch = ${PreferenceManager.isFirstLaunch}");
    var nextScreen = PreferenceManager.isFirstLaunch == false
        ? AppRoutes.routeOnBoarding
        : PreferenceManager.user?.firstName != null &&
                PreferenceManager.user?.firstName != ''
            ? AppRoutes.routeHome
            : AppRoutes.routeLogin;
    Get.offAllNamed(nextScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          AppImages.iconSplashLogo,
          width: 200.h,
          height: 200.h,
        ),
      ),
    );
  }

  @override
  void dispose() {
    cancelTimer();
    super.dispose();
  }
}
