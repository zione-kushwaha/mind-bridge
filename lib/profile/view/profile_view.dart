import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              'assets/sona.avif',
              width: 100, // Adjusted width to fit within constraints
              height: 100, // Added height to maintain aspect ratio
              fit: BoxFit.cover,
            ),
          ),
          // SizedBox(height: MediaQuery.of(context).size.height * 0.05),
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
            'Age: 10',
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
                  'Completed 10 tasks',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text(
                  'Read 5 books',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text(
                  'Won spelling bee',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          // Text(
          //   'Progress:',
          //   style: TextStyle(
          //     fontSize: 24,
          //     fontWeight: FontWeight.bold,
          //     color: Colors.black,
          //   ),
          // ),
          // SizedBox(height: 10),
          // LinearProgressIndicator(
          //   value: 0.8,
          //   backgroundColor: Colors.grey[300],
          //   color: Colors.green,
          //   minHeight: 20,
          // ),
          // SizedBox(height: 10),
          // Text(
          //   '80% completed',
          //   style: TextStyle(fontSize: 18, color: Colors.black),
          // ),
          // SizedBox(height: 30),
          // ElevatedButton(
          //   onPressed: () {
          //     // Add functionality here
          //   },
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Colors.green,
          //     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          //     textStyle: TextStyle(
          //       fontSize: 20,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          //   child: Text('Logout'),
          // ),
        ],
      ),
    );
  }
}
