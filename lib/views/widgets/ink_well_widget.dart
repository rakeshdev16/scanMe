import 'package:scan_me_plus/export.dart';

class Inkwell extends StatelessWidget {
  final Widget child;
  final Function() onTap;

  const Inkwell({super.key, required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: child,
    );
  }
}
