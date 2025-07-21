import 'package:event_app/core/constants/image_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/wedgits/cutsome_text_filed.dart';

class ForgetPassword extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty || !value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Forget Password"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image(image: AssetImage(TImages.forgetPassword)),

              TCustomeTextFormField(
                hintText: "Email",
                controller: _emailController,
                validator: _validateEmail,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ImageIcon(AssetImage(TImages.email)),
                ),
              ),

              ElevatedButton(onPressed: () async {
                await FirebaseAuth.instance.sendPasswordResetEmail(
                    email: _emailController.text);
              }
                  , child: Text("Reset Password"))
            ],
          ),
        ),


    );
  }
}
