import 'package:esewa_flutter/esewa_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:t/features/auth/auth_provider/login_view.dart';
import 'package:t/task_view/features/home/presentation/screens/provider/task_provider.dart';
import 'package:t/task_view/features/magazines_details/presentation/widgets/web_view.dart';

class ProfileView extends StatefulWidget {
  ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late ESewaConfig _config;

  @override
  void initState() {
    super.initState();
    _configration();
  }

  void _configration() {
    _config = ESewaConfig.dev(
      amt: 200.0,
      pid: '1',
      su: 'https://success.com.np',
      fu: 'https://failure.com.np',
    );
  }

  Future<void> _makePayment() async {
    try {
      final result = await Esewa.i.init(
        context: context,
        eSewaConfig: _config,
      );

      if (result.hasData) {
        // Handle successful payment
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Payment Successful. Ref ID: ${result.data!.refId}')),
        );
      } else {
        // Handle failed or cancelled payment
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Payment Failed or Cancelled. Error: ${result.error}')),
        );
      }
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              _auth.currentUser!.photoURL!,
              width: width * 0.15,
              height: height * 0.1,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: height * 0.05),
          Text(
            '${_auth.currentUser!.displayName}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: height * 0.01),
          Text(
            'Age: 21',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          // SizedBox(height: height * 0.02),
          Text(
            'Rating:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          // SizedBox(height: height * 0.02),
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
          SizedBox(height: height * 0.02),
          Text(
            'Completed Tasks:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: height * 0.02),
          Column(
            children: [
              Consumer(builder: (context, ref, child) {
                final provider =
                    ref.watch(taskNotifierProvider.notifier).getTasks();
                return SizedBox(
                  height: 50,
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
          Text(
            'Progress:',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: height * 0.01),
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
          SizedBox(height: height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ReportView();
                  }));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  textStyle: TextStyle(
                    fontSize: 10,
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
              ElevatedButton(
                onPressed: _makePayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  textStyle: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: FittedBox(
                  child: Text(
                    'Subscription',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Consumer(builder: (context, ref, child) {
            return ElevatedButton(
              onPressed: () async {
                await ref.read(authServiceProvider).signOut();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
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
