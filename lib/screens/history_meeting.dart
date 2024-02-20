import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_chat/firebase/firestore_methods.dart';
import 'package:intl/intl.dart';

class HistoryMeetingScreen extends StatelessWidget {
  const HistoryMeetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore().meetingHistory,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        final List<QueryDocumentSnapshot<Map<String, dynamic>>> meetingList =
            snapshot.data!.docs;
        return ListView.builder(
          itemCount: meetingList.length,
          itemBuilder: (context, index) => ListTile(
              title: Text("Meeting Name: ${meetingList[index]['meetingName']}"),
              subtitle: Text(
                  "Joined on ${DateFormat.yMEd().add_Hms().format(meetingList[index]['createdAt'].toDate())}")),
        );
      },
    );
  }
}
