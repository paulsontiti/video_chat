import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_chat/firebase/auth_method.dart';
import 'package:video_chat/firebase/firebase_config.dart';
import 'package:video_chat/screens/home_screen.dart';
import 'package:video_chat/screens/login_screen.dart';
import 'package:video_chat/screens/video_call_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: FirebaseConfig.apiKey,
            appId: FirebaseConfig.appId,
            storageBucket: FirebaseConfig.storageBucket,
            messagingSenderId: FirebaseConfig.messagingSenderId,
            projectId: FirebaseConfig.projectId));
  } else {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Video Chat',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/video_call': (context) => const VideoCallScreen(),
      },
      theme: ThemeData.dark(useMaterial3: true)
      //.copyWith(
      //scaffoldBackgroundColor: primaryBackgroundColor,
      //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//useMaterial3: true,
      //)
      ,
      home: Scaffold(
          body: StreamBuilder(
              stream: AuthMethods().authChanged,
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  return const HomeScreen();
                }

                return const LoginScreen();
              }))),
    );
  }
}
