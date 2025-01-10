import 'package:flutter/material.dart';

import '../../../firebase/model.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          child: ElevatedButton(
              onPressed: () async {
                await ProgressRepository().insertDummyData();
              },
              child: Text('Test'))),
    );
  }
}
