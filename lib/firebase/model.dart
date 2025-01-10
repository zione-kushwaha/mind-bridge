import 'package:cloud_firestore/cloud_firestore.dart';

class Progress {
  final String userId;
  final int testId;
  final double score;
  final double timeSpent;

  Progress({
    required this.userId,
    required this.testId,
    required this.score,
    required this.timeSpent,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'testId': testId,
      'score': score,
      'timeSpent': timeSpent,
    };
  }
}

class ProgressRepository {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('progress');

  Future<void> insertDummyData() async {
    for (var i = 0; i < 50; i++) {
      final progress = Progress(
        userId: 'user${i}',
        testId: i,
        score: 95.5 + i,
        timeSpent: 120.0 + i * 2,
      );

      try {
        await _collection.add(progress.toJson());
        print('Data inserted successfully');
      } catch (error) {
        print('Failed to insert data: $error');
      }
    }
  }
}
