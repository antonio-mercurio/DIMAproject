import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService(this.uid);
  //collection reference
  final CollectionReference houseCollection =
      FirebaseFirestore.instance.collection('houses');
  Future updateUserData(String owner, String city, int cap) async {
    print('stampa prova');
    return await houseCollection.doc(uid).set({
      'owner': owner,
      'city': city,
      'cap': cap,
    });
  }

  //get houses stream
  Stream<QuerySnapshot> get getHouses {
    return houseCollection.snapshots();
  }
}
