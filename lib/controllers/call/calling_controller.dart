import 'package:scan_me_plus/export.dart';

class CallingController extends GetxController {
  RxString channelName = ''.obs;
  RxString token = ''.obs;
  int uid = 0; // uid of the local user

  RxInt remoteUid = (-1).obs; // uid of the remote user
  RxBool isJoined =
      false.obs; // Indicates if the local user has joined the channel
  late RtcEngine agoraEngine; // Agora engine instance

  RxString callStatus = 'calling'.tr.obs;

  RxBool speakerStatus = false.obs;
  RxBool micStatus = true.obs;
  RxBool callBlocked = false.obs;

  RxString id = ''.obs;
  RxString image = ''.obs;
  RxString userName = ''.obs;
  Timer? timer;
  RxInt start = 0.obs;

  @override
  void onInit() {
    getArguments();
    if (socket!.connected) {
      socket?.on('call', (data) {
        debugPrint("DataInSocket = ${data['data']['status']}");
        if (data['data']['status'] == AppConsts.notAnswered) {
          leave();
        }
        if (data['data']['status'] == AppConsts.rejected) {
          leave();
        }
        if (data['data']['status'] == AppConsts.completed) {
          FlutterCallkitIncoming.endAllCalls();
        }
        if (data['data']['status'] == AppConsts.active) {}
      });
    } else {
      socket = SocketHelper.getInstance();
    }
    super.onInit();
  }

  getArguments() {
    if (Get.arguments != null) {
      if (Get.arguments['channel'] != null) {
        channelName.value = Get.arguments['channel'];
        token.value = Get.arguments['token'];
        id.value = Get.arguments['_id'];
        image.value = Get.arguments['image'] ?? '';
        userName.value = Get.arguments['userName'];
        callStatus.value = Get.arguments['callStatus'] ?? 'calling'.tr;
        setupVoiceSDKEngine();
      } else {
        callBlocked.value = Get.arguments['callBlocked'];
        Future.delayed(Duration(seconds: 1), () {
          Get.back();
        });
      }
    }
  }

  // @override
  // void onReady() {
  //   if(callBlocked.value){
  //     Get.back();
  //   }
  //   super.onReady();
  // }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    updateCallStatus(callStatus: AppConsts.active, callId: channelName.value);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        start.value++;
      },
    );
  }

  String intToTimeLeft(int value) {
    int h, m, s;
    h = value ~/ 3600;
    m = ((value - h * 3600)) ~/ 60;
    s = value - (h * 3600) - (m * 60);
    String minuteLeft = m.toString().length < 2 ? '0$m' : m.toString();
    String secondsLeft = s.toString().length < 2 ? '0$s' : s.toString();
    String result = "$minuteLeft:$secondsLeft";
    return result;
  }

  Future<void> setupVoiceSDKEngine() async {
    // retrieve or request microphone permission
    await [Permission.microphone].request();

    //create an instance of the Agora engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine
        .initialize(const RtcEngineContext(appId: AppConsts.agoraAppId));
    join();
    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint(
              "Local user uid:${connection.localUid} joined the channel");
          // callStatus.value = 'ringing'.tr;
          isJoined.value = true;
          Future.delayed(Duration(seconds: 30), () {
            if (callStatus.value == 'calling'.tr) {
              leave();
            }
          });
        },
        onUserJoined:
            (RtcConnection connection, int remoteUidValue, int elapsed) async {
          debugPrint("Remote user uid:$remoteUidValue joined the channel");
          remoteUid.value = remoteUidValue;
          callStatus.value = 'in_call_with'.tr;
          startTimer();
          await FlutterCallkitIncoming.setCallConnected(uuid.v4());
          Future.delayed(Duration(minutes: 1),() async {
            await leave();
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUidValue,
            UserOfflineReasonType reason) async {
          debugPrint("Remote user uid:$remoteUidValue left the channel");
          updateCallStatus(
              callStatus: AppConsts.completed, callId: channelName.value);
          await leave();
        },
      ),
    );
  }

  void join() async {
    // Set channel options including the client role and channel profile
    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );

    await agoraEngine.enableAudio();
    await agoraEngine.setDefaultAudioRouteToSpeakerphone(false);
    await agoraEngine.enableLocalAudio(micStatus.value);

    await agoraEngine.joinChannel(
      token: token.value,
      channelId: channelName.value,
      options: options,
      uid: uid,
    );
  }

  speakerToggle() async {
    speakerStatus.value = !speakerStatus.value;
    await agoraEngine.setEnableSpeakerphone(speakerStatus.value);
  }

  micToggle() async {
    micStatus.value = !micStatus.value;
    await agoraEngine.enableLocalAudio(micStatus.value);
  }

  Future<void> leave() async {
    if (isJoined.value == true) {
      if (remoteUid.value == -1) {
        updateCallStatus(
            callStatus: AppConsts.notAnswered, callId: channelName.value);
        isJoined.value = false;
        speakerStatus.value = false;
        micStatus.value = true;
        agoraEngine.leaveChannel();
        await FlutterCallkitIncoming.endAllCalls();
        if (Get.currentRoute != AppRoutes.routeHome) {
          Get.offAllNamed(AppRoutes.routeHome);
        }
      } else {
        updateCallStatus(
            callStatus: AppConsts.completed, callId: channelName.value);
        isJoined.value = false;
        remoteUid.value = -1;
        speakerStatus.value = false;
        micStatus.value = true;
        agoraEngine.leaveChannel();
        await FlutterCallkitIncoming.endAllCalls();
        if (Get.currentRoute != AppRoutes.routeHome) {
          Get.offAllNamed(AppRoutes.routeHome);
        }
      }
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
      } else {
        AppAlerts.error(message: 'message_server_error'.tr);
      }
    } on Exception catch (e) {
      debugPrint("Exception while updating user profile==> $e");
    }
  }

  @override
  Future<void> onClose() async {
    await agoraEngine.leaveChannel();
    super.onClose();
  }

  @override
  void dispose() async {
    await agoraEngine.leaveChannel();
    super.dispose();
  }
}
