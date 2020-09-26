import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference brewClollection =
      Firestore.instance.collection("brews");
}
