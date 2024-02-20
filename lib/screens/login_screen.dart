import 'package:flutter/material.dart';
import 'package:video_chat/firebase/auth_method.dart';
import 'package:video_chat/utils/colors.dart';
import 'package:video_chat/utils/show_snackbar.dart';
import 'package:video_chat/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "Start or join a meeting",
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Image.asset('assets/images/onboarding.jpg'),
            ),
            const SizedBox(
              height: 12,
            ),
            CustomButton(
              text: 'Sign In With Google',
              onPressed: () async {
                final (message, signedIn) =
                    await AuthMethods().signInWithGoogle();
                showSnackbar(context, message);
                if (signedIn) {
                  Navigator.pushNamed(context, '/home');
                }
              },
            ),
            const SizedBox(
              height: 12,
            ),
          ]),
    );
  }
}
