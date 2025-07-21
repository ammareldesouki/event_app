import 'package:event_app/core/constants/colors.dart';
import 'package:event_app/core/constants/image_strings.dart';
import 'package:event_app/core/route/route_name.dart';
import 'package:event_app/core/wedgits/cutsome_text_filed.dart';
import 'package:event_app/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
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

  String? _validateRePassword(String? value) {
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage(TImages.logo), height: 136),
              SizedBox(height: 16),
              TCustomeTextFormField(
                hintText: "Name",
                controller: _nameController,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ImageIcon(AssetImage(TImages.user)),
                ),
              ),
              SizedBox(height: 16),
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
              SizedBox(height: 16),
              TCustomeTextFormField(
                hintText: "Re-Password",
                controller: _rePasswordController,
                validator: _validateRePassword,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ImageIcon(AssetImage(TImages.password)),
                ),
                isPassword: true,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );

                      // Create user data in Firestore
                      final user = credential.user;
                      if (user != null) {
                        await UserService.createUserFromFirebaseUser(
                            user,
                            name: _nameController.text
                        );
                      }
                      
                      Navigator.pushNamed(context, RouteNames.layout);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                      }
                    } catch (e) {
                      print(e);
                    }
                  }
                },
                child: Text("Create Account"),
              ),
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
      ),
    );
  }
}
