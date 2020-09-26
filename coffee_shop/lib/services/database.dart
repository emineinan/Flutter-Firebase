import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference brewClollection =
      Firestore.instance.collection("brews");

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewClollection.document(uid).setData({
      "sugars": sugars,
      "name": name,
      "strength": strength,
    });
  }

  //get bres stream
  Stream<QuerySnapshot> get brews {
    return brewClollection.snapshots();
  }
}
