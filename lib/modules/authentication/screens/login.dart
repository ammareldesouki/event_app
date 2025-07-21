import 'package:event_app/core/constants/colors.dart';
import 'package:event_app/core/constants/image_strings.dart';
import 'package:event_app/core/route/route_name.dart';
import 'package:event_app/core/wedgits/cutsome_text_filed.dart';
import 'package:event_app/services/auth_services.dart';
import 'package:event_app/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> signInWithGoogle() async {
    final userCredential = await AuthService.signInWithGoogle(context);
    if (userCredential != null) {
      // Check if user exists in Firestore, if not create user data
      final user = userCredential.user;
      if (user != null) {
        final userExists = await UserService.userExists(user.uid);
        if (!userExists) {
          // Create user data in Firestore
          await UserService.createUserFromFirebaseUser(user);
        }
      }
      Navigator.pushReplacementNamed(context, RouteNames.layout);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty || !value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.length < 6) {
      return 'Password must contain 6 letters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage(TImages.logo), height: 136),
              SizedBox(height: 24),
              TCustomeTextFormField(
                hintText: "Email",
                controller: _emailController,
                validator: _validateEmail,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ImageIcon(AssetImage(TImages.email)),
                ),
              ),
              SizedBox(height: 16),
              TCustomeTextFormField(
                hintText: "Password",
                controller: _passwordController,
                validator: _validatePassword,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ImageIcon(AssetImage(TImages.password)),
                ),
                isPassword: true,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
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
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      final credential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );

                      // Check if user exists in Firestore, if not create user data
                      final user = credential.user;
                      if (user != null) {
                        final userExists = await UserService.userExists(
                            user.uid);
                        if (!userExists) {
                          // Create user data in Firestore
                          await UserService.createUserFromFirebaseUser(user);
                        }
                      }
                      
                      Navigator.pushNamed(context, RouteNames.layout);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('----------------------------No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                      }
                    }
                  }
                },
                child: Text("Login"),
              ),
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
                onPressed: () async {
                  try {
                    await signInWithGoogle();
                  } catch (e) {
                    print('Button error: $e');
                  }
                },
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
      ),
    );
  }
}
