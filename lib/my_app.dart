
import 'package:scan_me_plus/export.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    uuid = const Uuid();
    textEvents = "";
    socket = SocketHelper.getInstance();
    listenerEvent(onEvent);
  }

  void onEvent(CallEvent event) {
    if (!mounted) return;
    setState(() {
      textEvents += '---\n${event.toString()}\n';
    });
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
    }
  }

  @override
  void dispose() {
    FlutterCallkitIncoming.endAllCalls();
    super.dispose();
  }

  @override
  void deactivate() {
    FlutterCallkitIncoming.endAllCalls();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: ScreenUtilInit(
        builder: (_, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            title: AppConsts.appName,
            theme: appTheme(context),
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.0)),
                child: child!,
              );
            },
            translations: LocalString(),
            locale: const Locale('en', 'US'),
            initialRoute: AppRoutes.routeSplash,
            getPages: AppPages.pages,
          );
        },
      ),
    );
  }

  Future<void> getDevicePushTokenVoIP() async {
    var devicePushTokenVoIP =
    await FlutterCallkitIncoming.getDevicePushTokenVoIP();
    debugPrint(devicePushTokenVoIP);
  }

}
