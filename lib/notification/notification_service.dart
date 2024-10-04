import 'package:scan_me_plus/export.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  NotificationService._internal();

  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    "high_importance_channel_scan_me",
    "High Importance Notifications Scan Me",
    description:
        'This channel is used for important notifications. for Scan Me',
  );

  AndroidNotificationChannel audioChannel = const AndroidNotificationChannel(
    "high_importance_channel_scan_me_audio",
    "High Importance Notifications Scan Me Audio",
    description:
        'This channel is used for important notifications. for Scan Me Audio',
    importance: Importance.high,
    playSound: true,
    sound: RawResourceAndroidNotificationSound("emergency_alert"),
  );

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  getFcmToken() async {
    return await FirebaseMessaging.instance.getToken();
  }

  Future<void> init() async {
    if (Platform.isAndroid) {
      initAndroidSettings();
    } else if (Platform.isIOS) {
      initIOSSettings();
    }

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: false,
      badge: false,
      sound: true,
    );

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_notification');

    DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);



    FirebaseMessaging.instance.getInitialMessage().then(
      (message) async {
        debugPrint("FirebaseMessaging.instance.getInitialMessage  $message");
        if (message != null) {
          if (message.data['notificationType'] == 'CALL-SYNC' ||
              message.data['notificationType'] == 'CALL') {
          } else {
            notificationRedirection(message);
          }
        }
      },
    );

    FirebaseMessaging.onMessage.listen(
      (message) async {
        debugPrint("message onMessage --> ${message.data}");
        debugPrint("message onMessage --> ${message.notification}");
        if (message.data['notificationType'] == 'CALL') {
          showCallkitIncoming(uuid.v4(),
              callData: StartCallData.fromJson(message.data));
        } else if (message.data['notificationType'] == 'ALERT') {
          // if (Platform.isIOS) {
          if(Get.currentRoute != AppRoutes.routeNotificationAlert){
            Get.offAllNamed(AppRoutes.routeNotificationAlert, arguments: {
              'emergencyAlert': message.data['emergencyAlert'].toString()
            });
          }
        } else if (message.data['notificationType'] == 'CALL-SYNC') {
          if (message.data['callStatus'] == 'NOTANSWERED' ||
              message.data['callStatus'] == 'REJECTED') {
            if (Get.isRegistered<CallingController>()) {
              Get.find<CallingController>().leave();
            } else {
              FlutterCallkitIncoming.endAllCalls();
            }
          }
        } else {
          showFlutterNotification(message);
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.notification != null) {
        notificationRedirection(message);
      }
    });
  }

  Future<void> showFlutterNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      if (message.data['notificationType'] == 'ALERT') {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                audioChannel.id,
                audioChannel.name,
                channelDescription: audioChannel.description,
                playSound: true,
                sound: const UriAndroidNotificationSound(
                    "assets/raw/emergency_alert.mp3"),
                styleInformation: BigTextStyleInformation(
                    notification.title ?? '',
                    contentTitle: notification.body),
              ),
              iOS: DarwinNotificationDetails(
                  presentSound: true, sound: "emergency_alert")),
          payload: message.data.toString(),
        );
      } else {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              fullScreenIntent: true,
              playSound: false,
              styleInformation: BigTextStyleInformation(
                  notification.title ?? '',
                  contentTitle: notification.body),
            ),
          ),
          payload: message.data.toString(),
        );
      }
    }
  }

  Future<String> downloadAndSaveImage(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      final appDir = await getApplicationDocumentsDirectory();
      final File file = File('${appDir.path}/image.png');
      await file.writeAsBytes(response.bodyBytes);
      debugPrint('Image downloaded and saved at: ${file.path}');
      return file.path; // Return the local path of the saved image
    } else {
      throw Exception('Failed to download image');
    }
  }

  String imagePath = '';

  getImage(RemoteMessage message) async {
    imagePath = await downloadAndSaveImage(
        'https://scanmeadmin.vinnisoft.com/static/media/profile.5faf09a7795d28bf5a2b.png');
  }

  notificationRedirection(message) {
    if (message.data['notificationType'] == 'ALERT') {
      Get.offAllNamed(AppRoutes.routeNotificationAlert, arguments: {
        'emergencyAlert': message.data['emergencyAlert'].toString()
      });
    } else {
      Get.toNamed(ApiUrls.alertNotificationList);
    }
  }

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) {
    debugPrint("FirebaseMessaging ====== >>>>> ");
    debugPrint("FirebaseMessaging ====== >>>>> ${notificationResponse.payload}");
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    debugPrint("FirebaseMessaging ====== >>>>> ");
    debugPrint("FirebaseMessaging ====== >>>>> $id");
    debugPrint("FirebaseMessaging ====== >>>>> $title");
    debugPrint("FirebaseMessaging ====== >>>>> $body");
    debugPrint("FirebaseMessaging ====== >>>>> $payload");
  }

  Future<void> cancelAllNotification() async {
    flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> initAndroidSettings() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(audioChannel);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> initIOSSettings() async {
    DarwinInitializationSettings initializationSettings =
        const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestSoundPermission: true,
      requestBadgePermission: true,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.initialize(initializationSettings);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  Future<void> _isAndroidPermissionsGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;
    }
  }

  Future<void> requestPermissions() async {
    if (Platform.isIOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? isGranted =
          await androidImplementation?.requestNotificationsPermission();
    }
  }
}
