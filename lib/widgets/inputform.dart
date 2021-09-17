import 'package:ecommerce_app/constants.dart';
import 'package:flutter/material.dart';

class custominput extends StatelessWidget {
  final String? hintText;
  final Function(String?)? onChanged;
  final Function(String?)? onSubmitted;
  final FocusNode? focusnode;
  final bool obscuretext;
  const custominput({this.hintText, this.onChanged, this.onSubmitted, this.focusnode, required this.obscuretext});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 24,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xFFF2F2F2),
      ),
      child: TextField(
        obscureText: obscuretext,
        focusNode: focusnode,
        onChanged: onChanged as Function(String?)?,
        onSubmitted: onSubmitted as Function(String)?,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText ?? "Hint Text..",
            contentPadding: EdgeInsets.symmetric(
            horizontal: 24,
          vertical: 24,
        )
        ),
        style: Constants.regularDarkText,
      ),
    );
  }
}
