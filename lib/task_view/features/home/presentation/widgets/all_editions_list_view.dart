import 'package:flutter/material.dart';

import '../../../../core/shared/domain/entities/magazine.dart';

class AllEditionsListView extends StatelessWidget {
  const AllEditionsListView({
    required this.magazines,
    super.key,
  });

  final List<Magazine> magazines;

  void _showCompletionDialog(BuildContext context, Magazine magazine) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Task Completion'),
          // content: Text('Is the task "${magazine.description}" completed?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Handle the "Yes" action
                _showCongratulationDialog(context);
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Handle the "No" action
                _showNotCompletedDialog(context);
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  void _showNotCompletedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Task Not Completed'),
          content: Text('The task is not completed yet.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showCongratulationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You have completed the task.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: const Text(
            'ALL TASK',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
        ),
        SizedBox(height: 4),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20),
            itemCount: magazines.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final magazine = magazines[index];
              return Padding(
                padding: EdgeInsets.only(right: 12),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: GestureDetector(
                    onTap: () {
                      _showCompletionDialog(context, magazine);
                    },
                    child: Image.asset(
                      magazine.assetImage,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
