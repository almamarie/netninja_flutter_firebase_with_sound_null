import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:netninja_flutter_firebase/models/user.dart';

import '../models/brew.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
          name: doc.get('name') ?? '',
          sugars: doc.get('sugars') ?? '0',
          strength: doc.get('strength') ?? 0);
    }).toList();
  }
// user data from snapshot

  UserDataNew _useDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserDataNew(
      uid: uid!,
      name: snapshot['name'],
      sugars: snapshot['sugars'],
      strength: snapshot['strength'],
    );
  }

  // get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  // get user doc stream

  Stream<UserDataNew> get userData {
    return brewCollection.doc(uid).snapshots().map(_useDataFromSnapshot);
  }
}
