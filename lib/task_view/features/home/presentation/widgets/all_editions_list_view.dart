import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/shared/domain/entities/magazine.dart';
import '../screens/provider/task_provider.dart';

class AllEditionsListView extends ConsumerStatefulWidget {
  const AllEditionsListView({
    required this.magazines,
    super.key,
  });

  final List<Magazine> magazines;

  @override
  ConsumerState<AllEditionsListView> createState() =>
      _AllEditionsListViewState();
}

class _AllEditionsListViewState extends ConsumerState<AllEditionsListView> {
  void _showCompletionDialog(
      BuildContext context, Magazine magazine, int index, WidgetRef ref) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.bottomSlide,
      title: 'Task Completion',
      btnCancelOnPress: () {
        _showNotCompletedDialog(context);
      },
      btnOkOnPress: () {
        _showCongratulationDialog(context, index, ref);
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

  void _showCongratulationDialog(
      BuildContext context, int index, WidgetRef ref) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.bottomSlide,
      title: 'Congratulations!',
      desc: 'You have completed the task.',
      btnOkOnPress: () {
        String task;
        switch (index) {
          case 0:
            task = 'getup';
            break;
          case 1:
            task = 'brush teeth';
            break;
          case 2:
            task = 'wear clothes';
            break;
          case 3:
            task = 'breakfast';
            break;
          case 4:
            task = 'read book';
            break;
          case 5:
            task = 'play';
            break;
          case 6:
            task = 'take test';
            break;
          case 7:
            task = 'revision';
            break;
          case 8:
            task = 'take test';
            break;
          case 9:
            task = 'homework';
            break;
          default:
            task = 'unknown task';
        }
        ref.read(taskNotifierProvider.notifier).setTask(index, task);
        setState(() {});
      },
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
            itemCount: widget.magazines.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final magazine = widget.magazines[index];
              return Padding(
                padding: EdgeInsets.only(right: 12),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: GestureDetector(
                    onTap: () {
                      _showCompletionDialog(context, magazine, index, ref);
                    },
                    child: Consumer(builder: (context, ref, child) {
                      final provider = ref
                          .watch(taskNotifierProvider.notifier)
                          .getTaskIndexes();
                      return Stack(
                        children: [
                          Image.asset(
                            magazine.assetImage,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                          if (provider.contains(index))
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(Icons.check,
                                  color: Colors.green, size: 70),
                            ),
                        ],
                      );
                    }),
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
