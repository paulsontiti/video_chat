import 'package:flutter/material.dart';
import 'package:video_chat/screens/contacts.dart';
import 'package:video_chat/screens/history_meeting.dart';
import 'package:video_chat/screens/meeting.dart';
import 'package:video_chat/screens/settings.dart';
import 'package:video_chat/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;

  onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> pages = [
    MeetingScreen(),
    const HistoryMeetingScreen(),
    const ContactsScreen(),
    const SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meet & Chat"),
        centerTitle: true,
        elevation: 0,
        //leading: null,
      ),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: footerColor,
        currentIndex: _page,
        onTap: onPageChanged,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        unselectedItemColor: secondaryColor,
        unselectedFontSize: 12,
        selectedFontSize: 16,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.comment_bank_outlined,
              ),
              label: "Meet & Chat"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.lock_clock_outlined,
              ),
              label: "Meeting"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_2_outlined,
              ),
              label: "Contacts"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings_outlined,
              ),
              label: "Settings"),
        ],
      ),
    );
  }
}
