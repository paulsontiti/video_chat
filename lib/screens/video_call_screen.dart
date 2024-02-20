import 'package:flutter/material.dart';
import 'package:video_chat/firebase/auth_method.dart';
import 'package:video_chat/utils/colors.dart';
import 'package:video_chat/utils/jsti_meet_methods.dart';
import 'package:video_chat/widgets/meeting_option.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  late TextEditingController roomIdController;
  late TextEditingController nameController;
  bool _isAudioMuted = false;
  bool _isVideoMuted = false;

  _joinMeeting() {
    JITSIMeetMethods().createMeeting(
        roomName: roomIdController.text,
        isAudioMuted: _isAudioMuted,
        isVideoMuted: _isVideoMuted,
        userName: nameController.text);
  }

  _changeAudioIsMuted(bool val) {
    setState(() {
      _isAudioMuted = val;
    });
  }

  _changeVideoIsMuted(bool val) {
    setState(() {
      _isVideoMuted = val;
    });
  }

  @override
  void initState() {
    roomIdController = TextEditingController();
    nameController =
        TextEditingController(text: AuthMethods().user?.displayName);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    roomIdController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryBackgroundColor,
        centerTitle: true,
        title: const Text(
          "Join Meeting",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: roomIdController,
                maxLines: 1,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    fillColor: secondaryBackgroundColor,
                    filled: true,
                    border: InputBorder.none,
                    hintText: "Enter Room ID"),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: nameController,
                maxLines: 1,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    fillColor: secondaryBackgroundColor,
                    filled: true,
                    border: InputBorder.none,
                    hintText: "Enter your name"),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: _joinMeeting,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: const BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: const Center(
                      child: Text(
                        'Join',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MeetingOption(
                  text: "Join with audio",
                  isMuted: _isAudioMuted,
                  onChanged: (bool val) {
                    _changeAudioIsMuted(val);
                  }),
              const SizedBox(
                height: 18,
              ),
              MeetingOption(
                  text: "Join with video",
                  isMuted: _isVideoMuted,
                  onChanged: (bool val) {
                    _changeVideoIsMuted(val);
                  })
            ],
          ),
        )
      ]),
    );
  }
}
