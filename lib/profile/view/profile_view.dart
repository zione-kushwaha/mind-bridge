import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:t/features/auth/auth_provider/login_view.dart';
import 'package:t/task_view/features/home/presentation/screens/provider/task_provider.dart';
import 'package:t/task_view/features/magazines_details/presentation/widgets/web_view.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              _auth.currentUser!.photoURL!,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          // SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Text(
            '${_auth.currentUser!.displayName}',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Age: 21',
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
              Consumer(builder: (context, ref, child) {
                final provider =
                    ref.watch(taskNotifierProvider.notifier).getTasks();
                return SizedBox(
                  height: 300,
                  child: ListView.builder(
                      itemCount: provider.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            child: Text('${index + 1}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            backgroundColor: Colors.green,
                          ),
                          title: Text('${provider[index]}'),
                          trailing:
                              Icon(Icons.check_circle, color: Colors.green),
                        );
                      }),
                );
              })
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
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ReportView();
              }));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: Text(
              'View Reports',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 20),
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
              child: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
