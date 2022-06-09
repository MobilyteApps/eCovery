import 'package:flutter/cupertino.dart';

class InkWellMe extends StatefulWidget {
  const InkWellMe({
    Key? key,
    required this.child,
    required this.onSafeTap,
    this.intervalMs = 500,

    /// <<<<<<< onSafeTap
  }) : super(key: key);
  final Widget child;
  final GestureTapCallback onSafeTap;
  final int intervalMs;
  @override
  _InkWellMeState createState() => _InkWellMeState();
}

class _InkWellMeState extends State<InkWellMe> {
  int lastTimeClicked = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final now = DateTime.now().millisecondsSinceEpoch;
        if (now - lastTimeClicked < widget.intervalMs) {
          return;
        }
        lastTimeClicked = now;
        widget.onSafeTap();
      },
      child: widget.child,
    );
  }
}
