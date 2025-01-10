import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:t/features/auth/view/login_view.dart';
import 'package:t/features/home/view/home_view.dart';
import 'firebase_options.dart';
import 'themes/sizes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData.light(); // Define the theme variable
    return Sizer(
      builder: (context, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                    body: Center(child: CircularProgressIndicator()));
              }
              if (!userSnapshot.hasData) {
                return LoginView();
              }
              // Add logic for when user data exists
              return HomePage();
            },
          ),
        );
      },
    );
  }
}
