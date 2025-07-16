import 'dart:ffi';

import 'package:flutter/material.dart';

class TCustomeTextFormField extends StatefulWidget {
  const TCustomeTextFormField({
    super.key,
    required this.hintText,
   this.child,
    this.isPassword = false,
    this.controller,
    this.validator, this.lableText,  this.maxLine=1,
  });

  final String hintText;
  final Widget? child;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? lableText;
  final  int? maxLine;

  @override
  State<TCustomeTextFormField> createState() => _TCustomeTextFormFieldState();
}

class _TCustomeTextFormFieldState extends State<TCustomeTextFormField> {
  bool obscureText = false;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: obscureText,
      maxLines:widget.maxLine ,
      
      decoration: InputDecoration(
        labelText: widget.lableText,
        hintText: widget.hintText,
        alignLabelWithHint: true,
        prefixIcon: widget.child,
        
        suffixIcon:
            widget.isPassword
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
