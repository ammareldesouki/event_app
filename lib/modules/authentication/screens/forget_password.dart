import 'package:event_app/core/constants/image_strings.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatelessWidget {
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image(image: AssetImage(TImages.forgetPassword)),
          
              ElevatedButton(onPressed: (){}, child: Text("Reset Password"))
            ],
          ),
        ),


    );
  }
}
