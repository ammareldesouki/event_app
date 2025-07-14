import 'package:flutter/material.dart';

class TCustomeTextFormField extends StatefulWidget {
  const TCustomeTextFormField({
    super.key,
    required this.hintText,
    required this.child,
    this.isPassword = false,
  });

  final String hintText;
  final Widget child;
  final bool isPassword;

  @override
  State<TCustomeTextFormField> createState() => _TCustomeTextFormFieldState();
}

class _TCustomeTextFormFieldState extends State<TCustomeTextFormField> {
  bool obscureText = false;



  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.child,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                ),
              )
            : null,
      ),
    );
  }
}
