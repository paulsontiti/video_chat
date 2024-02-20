import 'dart:math';

import 'package:flutter/material.dart';
import 'package:video_chat/utils/jsti_meet_methods.dart';
import 'package:video_chat/widgets/home_meeting_button.dart';

class MeetingScreen extends StatelessWidget {
  final JITSIMeetMethods _jstiMethods = JITSIMeetMethods();
  MeetingScreen({super.key});

  createNewMeeting() async {
    final random = Random();
    String roomName = (random.nextInt(100000000) + 10000000).toString();
    _jstiMethods.createMeeting(
        roomName: roomName,
        subject: "Meeting with me",
        isAudioMuted: true,
        isVideoMuted: true);
  }

  joinMeeting(BuildContext context) {
    Navigator.pushNamed(context, '/video_call');
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          HomeMeetingButton(
            onPressed: createNewMeeting,
            icon: Icons.videocam,
            text: "New Meeting",
          ),
          HomeMeetingButton(
            onPressed: () => joinMeeting(context),
            icon: Icons.add_box_rounded,
            text: "Join Meeting",
          ),
          HomeMeetingButton(
            onPressed: () {},
            icon: Icons.calendar_today,
            text: "Schedule",
          ),
          HomeMeetingButton(
            onPressed: () {},
            icon: Icons.arrow_upward_rounded,
            text: "Share Screen",
          )
        ],
      ),
      const Expanded(
        child: Center(
          child: Text(
            "Create or join a meeting with just a click",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      )
    ]);
  }
}
