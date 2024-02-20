import "package:flutter/material.dart";
import "package:video_chat/firebase/auth_method.dart";
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import "package:video_chat/firebase/firestore_methods.dart";

class JITSIMeetMethods {
  createMeeting(
      {required String roomName,
      required bool isAudioMuted,
      required bool isVideoMuted,
      //subjec will be empty if the user is joining a meeting
      //else will contain the meeting subject if they are creating a new meeting
      String subject = '',
      //userName will be empty if the user is creating a new meeting
      //else will contain the user's name if they are joining a meeting
      String userName = ''}) async {
    final AuthMethods authMethods = AuthMethods();
    try {
      JitsiMeet jitsiMeet = JitsiMeet();

      //display name
      String name;
      var user = authMethods.user!;
      //creating new meeting
      if (userName.isEmpty) {
        name = user.displayName!;
      } else {
        //joining a meeting
        name = userName;
      }
      JitsiMeetConferenceOptions options = JitsiMeetConferenceOptions(
        //serverURL: "https://meet.jit.si",
        room: roomName,
        configOverrides: {
          "startWithAudioMuted": isAudioMuted,
          "startWithVideoMuted": isVideoMuted,
          "subject": subject,
        },
        featureFlags: {"unsaferoomwarning.enabled": false},
        userInfo: JitsiMeetUserInfo(
            displayName: name, email: user.email, avatar: user.photoURL),
      );
      Firestore().addToMeetingHistory(roomName);
      jitsiMeet.join(options);
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
