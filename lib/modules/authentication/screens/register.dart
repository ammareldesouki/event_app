import 'package:event_app/core/constants/colors.dart';
import 'package:event_app/core/constants/image_strings.dart';
import 'package:event_app/core/route/route_name.dart';
import 'package:event_app/core/theme/widget_themes/text_field_theme.dart';
import 'package:event_app/core/wedgits/cutsome_text_filed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage(TImages.logo), height: 136),
            SizedBox(height: 16),
            TCustomeTextFormField(
              hintText: "Name",
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ImageIcon(AssetImage(TImages.user)),
              ),
            ),
            SizedBox(height: 16),

            TCustomeTextFormField(
              hintText: "Email",
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ImageIcon(AssetImage(TImages.email)),
              ),
            ),
            SizedBox(height: 16),

            TCustomeTextFormField(
              hintText: "Password",
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ImageIcon(AssetImage(TImages.password)),
              ),
              isPassword: true,
            ),
            SizedBox(height: 16),
            TCustomeTextFormField(
              hintText: "Re-Password",
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ImageIcon(AssetImage(TImages.password)),
              ),
              isPassword: true,
            ),

      
            SizedBox(height: 24),
            ElevatedButton(onPressed: () {}, child: Text("Create Account")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already Have Account ? ",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, RouteNames.login);
                  },
                  child: Text(
                    "Login",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(color: TColors.primary),
                  ),
                ),
              ],
            ),

    
          ],
        ),
      ),
    );
  }
}
