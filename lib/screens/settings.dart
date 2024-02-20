import 'package:flutter/cupertino.dart';
import 'package:video_chat/firebase/auth_method.dart';
import 'package:video_chat/widgets/custom_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: CustomButton(text: 'Log out', onPressed: AuthMethods().signOut));
  }
}
