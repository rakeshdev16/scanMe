
import 'package:scan_me_plus/export.dart';

class DoubleBack extends StatefulWidget {
  final Widget child;
  final int waitForSecondBackPress;
  final Function? onFirstBackPress;
  final bool condition;
  final VoidCallback? onConditionFail;

  /// DoubleBack, wrap a widget to use it
  const DoubleBack({
    Key? key,
    required this.child,
    this.waitForSecondBackPress = 2,
    this.onFirstBackPress,
    this.condition = true,
    this.onConditionFail,
  }) : super(key: key);

  @override
  _DoubleBackState createState() => _DoubleBackState();
}

class _DoubleBackState extends State<DoubleBack> {
  bool tapped = false;

  bool get _isAndroid => Theme.of(context).platform == TargetPlatform.android;

  @override
  Widget build(BuildContext context) {
    if (_isAndroid) {
      return WillPopScope(
        onWillPop: () async {
          if (widget.condition) {
            if (tapped) {
              return true;
            } else {
              tapped = true;
              Timer(
                Duration(
                  seconds: widget.waitForSecondBackPress,
                ),
                resetBackTimeout,
              );

              if (widget.onFirstBackPress != null) {
                widget.onFirstBackPress!(context);
              } else {
                _showExitAlert();
              }

              return false;
            }
          } else {
            if (widget.onConditionFail != null) {
              widget.onConditionFail!();
            }
            return false;
          }
        },
        child: widget.child,
      );
    } else {
      return widget.child;
    }
  }

  void resetBackTimeout() {
    tapped = false;
  }

  _showExitAlert() {
    CommonAlertDialog.showDialog(
        message: 'message_exit_app'.tr,
        positiveText: 'exit'.tr,
        negativeText: 'dismiss'.tr,
        negativeBtCallback: () {
          Get.back();
        },
        positiveBtCallback: () {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        },
        title: 'alert'.tr);
  }
}
