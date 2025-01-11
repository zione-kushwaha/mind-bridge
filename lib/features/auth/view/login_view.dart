import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../../home/view/home_view.dart';
import '../auth_provider/login_view.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _SignupViewState();
}

class _SignupViewState extends ConsumerState<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.18,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Image.asset('assets/first/1.png'),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  '''Let your children learn and play using our interactive and fun platform for especially abled 
                              children
                  
                      ''',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              _buildSignInWithGoogle(context),
              SizedBox(
                height: 20,
              ),
              _buildLoginText(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignInWithGoogle(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: SignInButton(
          elevation: 1,
          padding: const EdgeInsets.symmetric(vertical: 5),
          Buttons.google,
          text: 'Sign in with Google',
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          onPressed: () async {
            final result =
                await ref.read(authServiceProvider).signInWithGoogle();
            if (result) {
              final user = await ref.read(authServiceProvider).getUserName();
              if (user != null) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HomePage();
                }));
              } else {}
            }
          },
        ),
      ),
    );
  }

  Widget _buildLoginText(BuildContext context) {
    return RichText(
        text: TextSpan(
      text: 'Don\'t have an account?  ',
      style: TextStyle(color: Colors.black, fontSize: 16),
      children: [
        TextSpan(
          text: 'Sign Up',
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.pushNamed(context, '/signup');
            },
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    ));
  }
}
