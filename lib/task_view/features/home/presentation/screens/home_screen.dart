import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../magazines_details/presentation/screens/magazines_details_screen.dart';
import '../widgets/all_editions_list_view.dart';
import '../widgets/infinite_dragable_slider.dart';

class TaskView extends StatefulWidget {
  const TaskView({
    super.key,
    this.enableEntryAnimation = false,
    this.initialIndex = 0,
  });

  final bool enableEntryAnimation;
  final int initialIndex;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> with TickerProviderStateMixin {
  final List<Magazine> magazines = Magazine.fakeMagazinesValues;
  late int currentIndex;

  @override
  void initState() {
    currentIndex = widget.initialIndex;

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void openMagazineDetail(
    BuildContext context,
    int index,
  ) {
    setState(() => currentIndex = index);
    MagazinesDetailsScreen.push(
      context,
      magazines: magazines,
      index: currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 48),
        InfiniteDragableSlider(
          iteamCount: Magazine.fakeMagazinesValues.length,
          itemBuilder: (context, index) =>
              MagazineCoverImage(magazine: Magazine.fakeMagazinesValues[index]),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
        ),
        SizedBox(
          height: 140,
          child: AllEditionsListView(magazines: magazines),
        ),
      ],
    );
  }
}
