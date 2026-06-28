import 'package:flutter/material.dart';
import 'package:okul_bilgi_sistemi/helper/color.dart';
import 'package:okul_bilgi_sistemi/helper/helper.dart';

class UyariWidget extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final Color color;
  final Color backgroundColor;
  final double width;
  final double height;
  final List<Widget> liste;
  const UyariWidget({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.color,
    required this.width,
    required this.height,
    required this.liste,
    required this.backgroundColor,
  });

  @override
  State<UyariWidget> createState() => _UyariWidgetState();
}

class _UyariWidgetState extends State<UyariWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: SingleChildScrollView(
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: widget.width / 100),
              Icon(widget.icon, color: widget.iconColor),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Container(
                  width: 1,
                  color: widget.backgroundColor,

                  height: widget.height,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.liste,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
