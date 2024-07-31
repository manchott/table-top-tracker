import 'package:cloud_firestore/cloud_firestore.dart';

import 'models.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addRound(Round round) {
    return _db.collection('rounds').doc(round.id).set(round.toJson());
  }

  Stream<List<Round>> getRounds() {
    return _db.collection('rounds').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Round.fromJson(doc.data())).toList());
  }
}
