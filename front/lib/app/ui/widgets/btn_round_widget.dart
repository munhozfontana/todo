import 'package:flutter/material.dart';

class BtnRoundWidget extends StatefulWidget {
  final Color? color;

  final void Function()? onLongPress;
  final void Function()? onTap;
  final Widget? child;

  const BtnRoundWidget({
    super.key,
    this.color,
    this.onLongPress,
    this.onTap,
    this.child,
  });

  @override
  State<BtnRoundWidget> createState() => _BtnRoundWidgetState();
}

class _BtnRoundWidgetState extends State<BtnRoundWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 62,
      height: 62,
      child: Material(
        borderRadius: BorderRadius.circular(50),
        color: widget.color,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          onLongPress: widget.onLongPress,
          onTap: widget.onTap,
          child: widget.child,
        ),
      ),
    );
  }
}
