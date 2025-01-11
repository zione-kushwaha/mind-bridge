import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:t/features/auth/auth_provider/login_view.dart';
import 'package:t/task_view/features/magazines_details/presentation/widgets/web_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                'assets/sona.avif',
                width: 400,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Text(
              'Samridhi Singh',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Age: 7',
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Rating:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Icon(
                  Icons.star,
                  color: index < 4 ? Colors.yellow : Colors.grey,
                  size: 40,
                );
              }),
            ),
            SizedBox(height: 30),
            Text(
              'Achievements:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Column(
              children: [
                ListTile(
                  leading: Icon(Icons.check_circle, color: Colors.green),
                  title: Text(
                    'Completed 2 tasks',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.check_circle, color: Colors.green),
                  title: Text(
                    'Reading',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.check_circle, color: Colors.green),
                  title: Text(
                    'Bathing',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Text(
              'Progress:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            LinearProgressIndicator(
              value: 0.4,
              backgroundColor: Colors.grey[300],
              color: Colors.green,
              minHeight: 20,
            ),
            SizedBox(height: 10),
            Text(
              '40% completed',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WebViewExample()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        'View Report',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Consumer(builder: (context, ref, child) {
              return ElevatedButton(
                onPressed: () async {
                  // Add functionality here
                  await ref.read(authServiceProvider).signOut();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text('Logout',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              );
            }),
          ],
        ),
      ),
    );
  }
}
