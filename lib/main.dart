import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:reminder_app/features/calendar/presentation/pages/calendar_page.dart';
import 'package:reminder_app/injection.dart';

void main() async {
  setupinjection();

  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: 'AIzaSyAqRQ71DYw5BrvwhjgJR8lK6rJOqc5FNn4',
            appId: '1:693520563653:android:857a967e3169921e3e9fac',
            messagingSenderId: '693520563653',
            projectId: 'reminder-app-ff79d',
          ),
        )
      : await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: CalendarPage());
  }
}
