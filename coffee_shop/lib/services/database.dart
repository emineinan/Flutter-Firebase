import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/models/brew.dart';
import 'package:coffee_shop/models/user.dart';

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

  //brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      //print(doc.data);
      return Brew(
          name: doc.data['name'] ?? '',
          strength: doc.data['strength'] ?? 0,
          sugars: doc.data['sugars'] ?? '0');
    }).toList();
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data["name"],
      sugars: snapshot.data["sugars"],
      strength: snapshot.data["strength"],
    );
  }

  //get bres stream
  Stream<List<Brew>> get brews {
    return brewClollection.snapshots().map(_brewListFromSnapshot);
  }

  //get user doc stream.
  Stream<UserData> get userData {
    return brewClollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
