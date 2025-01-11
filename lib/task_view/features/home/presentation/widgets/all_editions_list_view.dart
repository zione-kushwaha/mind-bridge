import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../../../../core/shared/domain/entities/magazine.dart';

class AllEditionsListView extends StatelessWidget {
  const AllEditionsListView({
    required this.magazines,
    super.key,
  });

  final List<Magazine> magazines;

  void _showCompletionDialog(BuildContext context, Magazine magazine) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.bottomSlide,
      title: 'Task Completion',
      btnCancelOnPress: () {
        _showNotCompletedDialog(context);
      },
      btnOkOnPress: () {
        _showCongratulationDialog(context);
      },
    ).show();
  }

  void _showNotCompletedDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.bottomSlide,
      title: 'Task Not Completed',
      btnOkOnPress: () {},
    ).show();
  }

  void _showCongratulationDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.bottomSlide,
      title: 'Congratulations!',
      desc: 'You have completed the task.',
      btnOkOnPress: () {},
    ).show();
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
