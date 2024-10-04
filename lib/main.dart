import 'package:scan_me_plus/export.dart';
import 'package:scan_me_plus/firebase_options.dart';
import 'package:scan_me_plus/my_app.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

Uuid uuid = const Uuid();
String? currentUuid;
IO.Socket? socket;
String textEvents = "";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService().init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  orientation();
  await PreferenceManager.init().then((value) {
    socket = SocketHelper.getInstance();
  });
  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('background =======> ${message.data} ');
  if (message.data['notificationType'] == 'CALL') {
    debugPrint('call =====> ');
    await PreferenceManager.init().then((value) async {
      socket = SocketHelper.getInstance();
      listenerEvent(onEvent);
      debugPrint('call =====> ');

      await showCallkitIncoming(uuid.v4(),
          callData: StartCallData.fromJson(message.data));

    });
  }
  // else if(message.data['notificationType'] == 'ALERT'){
  //   Get.offAllNamed(AppRoutes.routeNotificationAlert, arguments: {
  //     'emergencyAlert': message.data['emergencyAlert'].toString()
  //   });
  // }
  else if (message.data['notificationType'] == 'CALL-SYNC') {
    if (message.data['callStatus'] == 'NOTANSWERED' ||
        message.data['callStatus'] == 'REJECTED') {
      FlutterCallkitIncoming.endAllCalls();
    }
  }
}

orientation() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark,
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.black,
      statusBarIconBrightness: Brightness.dark));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

showCallkitIncoming(String uuid, {required StartCallData callData}) async {
  final params = CallKitParams(
    id: uuid,
    nameCaller: callData.caller?.userId ?? '',
    appName: 'Scan Me +',
    avatar: 'https://scanmeadmin.vinnisoft.com/static/media/profile.5faf09a7795d28bf5a2b.png',
    handle: '0123456789',
    type: 0,
    duration: 30000,
    textAccept: '',
    textDecline: '',
    extra: <String, dynamic>{
      'channel': callData.channelName,
      'token': callData.token,
      'callStatus': 'incoming_call'.tr,
      '_id': callData.caller?.id,
      'image': callData.caller?.image,
      'userName': callData.caller?.userId
    },
    headers: <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'flutter'},
    android: const AndroidParams(
      isShowLogo: false,
      ringtonePath: 'system_ringtone_default',
      backgroundColor: '0xff22272B',
      actionColor: '#4CAF50',
      isCustomNotification: true,
      backgroundUrl: 'assets/images/bg_image.png',
      textColor: '#ffffff',
      isShowFullLockedScreen: true,
      isCustomSmallExNotification: true,
      incomingCallNotificationChannelName: 'Incoming Call',
    ),
    ios: const IOSParams(
      iconName: 'Scan Me',
      handleType: '',
      supportsVideo: false,
      maximumCallGroups: 2,
      maximumCallsPerCallGroup: 1,
      audioSessionMode: 'default',
      audioSessionActive: true,
      audioSessionPreferredSampleRate: 44100.0,
      audioSessionPreferredIOBufferDuration: 0.005,
      supportsDTMF: true,
      supportsHolding: true,
      supportsGrouping: false,
      supportsUngrouping: false,
      ringtonePath: 'Ringtone.caf',
    ),
  );

  debugPrint(
      "message firebaseMessagingBackgroundHandler --> start callllllllll");

  socket?.on('call', (data) async {
    if (data['data']['status'] == AppConsts.notAnswered) {
      debugPrint("DataInSocket = ${data['data']['status']}");
      await FlutterCallkitIncoming.endAllCalls();
    }
    if (data['data']['status'] == AppConsts.rejected) {
      debugPrint("DataInSocket = ${data['data']['status']}");
      await FlutterCallkitIncoming.endAllCalls();
    }
    if (data['data']['status'] == AppConsts.completed) {
      debugPrint("DataInSocket = ${data['data']['status']}");
      await FlutterCallkitIncoming.endAllCalls();
    }
    if (data['data']['status'] == AppConsts.active) {
      debugPrint("DataInSocket = ${data['data']['status']}");
    }
  });

  debugPrint(
      "message firebaseMessagingBackgroundHandler --> show kittttttttt  callllllllll");

  await FlutterCallkitIncoming.showCallkitIncoming(params);
}

Future<dynamic> getCurrentCall() async {
  var calls = await FlutterCallkitIncoming.activeCalls();
  if (calls is List) {
    if (calls.isNotEmpty) {
      currentUuid = calls[0]['id'];
      return calls[0];
    } else {
      currentUuid = "";
      return null;
    }
  }
}

Future<void> checkAndNavigationCallingPage() async {
  var currentCall = await getCurrentCall();
  if (currentCall != null) {
    Get.toNamed(AppRoutes.routeCalling, arguments: currentCall['extra']);
  }
}

Future<void> listenerEvent(void Function(CallEvent) callback,
    {isBackground = false, message}) async {
  debugPrint('HOME: stat listen');
  try {
    FlutterCallkitIncoming.onEvent.listen((event) async {
      debugPrint('EVENTTTT ====>  $event');

      switch (event!.event) {
        case Event.actionCallIncoming:
          debugPrint('call Incoming ============>');
          break;
        case Event.actionCallStart:
          debugPrint('call start ============>');
          break;
        case Event.actionCallAccept:
          debugPrint('call active ============>');
          updateCallStatus(
              callId: event.body['extra']['channel'],
              callStatus: AppConsts.active);
          checkAndNavigationCallingPage();
          break;
        case Event.actionCallDecline:
          updateCallStatus(
              callId: event.body['extra']['channel'],
              callStatus: AppConsts.rejected);
          debugPrint('call decline ============>');
          break;
        case Event.actionCallEnded:
          debugPrint('call ended ============>');
          break;
        case Event.actionCallTimeout:
          debugPrint('call not answered ============>');
          updateCallStatus(
              callId: event.body['extra']['channel'],
              callStatus: AppConsts.notAnswered);
          break;
        case Event.actionCallCallback:
          break;
        case Event.actionCallToggleHold:
          break;
        case Event.actionCallToggleMute:
          break;
        case Event.actionCallToggleDmtf:
          break;
        case Event.actionCallToggleGroup:
          break;
        case Event.actionCallToggleAudioSession:
          break;
        case Event.actionDidUpdateDevicePushTokenVoip:
          break;
        case Event.actionCallCustom:
          break;
      }
      callback(event);
    });
  } on Exception catch (e) {
    debugPrint(e.toString());
  }
}

Future<void> updateCallStatus({callStatus, callId}) async {
  try {
    Map<String, dynamic> callStatusRequestBody = {'callStatus': callStatus};
    var result = await PutRequests.callStatus(
        requestBody: callStatusRequestBody,
        callId: callId,
        callStatus: callStatus);
    if (result != null) {
      if (result.success) {}
    }
  } on Exception catch (e) {
    debugPrint("Exception while updating user profile==> $e");
  }
}

void onEvent(CallEvent event) {
  textEvents += '---\n${event.toString()}\n';
}
