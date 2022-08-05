import 'package:cuida_pet/app/core/ui/extentions/theme_extension.dart';
import 'package:flutter/material.dart';

class CuidapetDefaultButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double borderRadius;
  final Color? color;
  final String label;
  final Color? labelColor;
  final double labelSize;
  final double padding;
  final double width;
  final double height;

  const CuidapetDefaultButton({
    Key? key,
    required this.onPressed,
    this.borderRadius = 10,
    this.color,
    required this.label,
    this.labelColor = Colors.white,
    this.labelSize = 20,
    this.padding = 10,
    this.width = double.infinity,
    this.height = 66,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          backgroundColor: color ?? context.primaryColor,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: labelSize,
            color: labelColor,
          ),
        ),
      ),
    );
  }
}
