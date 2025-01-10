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
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: ParabolicAnimation(),
//       ),
//     );
//   }
// }

// class ParabolicAnimation extends StatefulWidget {
//   @override
//   _ParabolicAnimationState createState() => _ParabolicAnimationState();
// }

// class _ParabolicAnimationState extends State<ParabolicAnimation>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 1500),
//     )..repeat(reverse: false); // Auto-repeats the animation.

//     _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     final middleY = screenHeight / 2; // Middle of the screen vertically.

//     return AnimatedBuilder(
//       animation: _animation,
//       builder: (context, child) {
//         double t = _animation.value; // Animation progress [0, 1]
//         double x = t * screenWidth; // Horizontal movement
//         double y = middleY -
//             100 * (1 - 4 * (t - 0.5) * (t - 0.5)); // Parabolic formula

//         return Stack(
//           children: [
//             Positioned(
//               left: x,
//               top: y,
//               child: Image.asset(
//                 'assets/letter/a.png', // Replace with your image path
//                 width: 50,
//                 height: 50,
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
