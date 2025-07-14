import 'package:event_app/core/constants/colors.dart';
import 'package:event_app/core/constants/image_strings.dart';
import 'package:event_app/core/route/route_name.dart';
import 'package:event_app/core/theme/widget_themes/text_field_theme.dart';
import 'package:event_app/core/wedgits/cutsome_text_filed.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage(TImages.logo), height: 136),
            SizedBox(height: 24),

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

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.forgetPassword);
                },
                child: Text(
                  'Forgot Password ?',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: TColors.primary),
                ),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(onPressed: () {}, child: Text("Login")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "don't have account?",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.register);
                  },
                  child: Text(
                    "Create Account",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(color: TColors.primary),
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Or", style: TextStyle(color: Colors.grey)),
                ),
                Expanded(child: Divider()),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(TImages.google, width: 24, height: 24),
                  Text(
                    "Login With Google",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.copyWith(color: TColors.primary),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(backgroundColor: TColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
