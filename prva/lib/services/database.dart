import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prva/models/personalProfile.dart';
import 'package:prva/models/user.dart';

class DatabaseService {
  final String? uid;
  DatabaseService(this.uid);
  //collection reference
  final CollectionReference houseCollection =
      FirebaseFirestore.instance.collection('houses');
  final CollectionReference persProfileCollection =
      FirebaseFirestore.instance.collection('personalProfiles');

  Future updatePersonalProfile(String name, String surname, int age) async {
    return await persProfileCollection.doc(uid).set({
      'name': name,
      'surname': surname,
      'age': age,
    });
  }

  PersonalProfile _persProfileDataFromSnapshot(DocumentSnapshot snapshot) {
    return PersonalProfile(
      uid: uid ?? "",
      name: snapshot.get('name') ?? "",
      surname: snapshot.get('surname') ?? "",
      age: snapshot.get('age') ?? 0,
    );
  }

  Stream<PersonalProfile> get getMyPersonalProfile {
    return persProfileCollection
        .doc(uid)
        .snapshots()
        .map((_persProfileDataFromSnapshot));
  }

  Stream<PersonalProfile> get persProfileData {
    return persProfileCollection
        .doc(uid)
        .snapshots()
        .map((_persProfileDataFromSnapshot));
  }

  Future updateUserData(String owner, String city, int cap) async {
    print('stampa prova');
    return await houseCollection.doc(uid).set({
      'owner': owner,
      'city': city,
      'cap': cap,
    });
  }

  /*house list from snapshot
  List<House> _houseListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map<House>((doc) {
      return House(
          owner: doc.get('owner') ?? "",
          city: doc.get('city') ?? "",
          cap: doc.get('cap') ?? 0);
    }).toList();
  }*/

  //user data from snapshots

  /*UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid ?? "",
      owner: snapshot.get('owner') ?? "",
      city: snapshot.get('city') ?? "",
      cap: snapshot.get('cap') ?? 0,
    );
  }*/

  /*get houses stream
  Stream<List<House>> get getHouses {
    return houseCollection.snapshots().map((_houseListFromSnapshot));
  }*/

  /*get user doc stream
  Stream<UserData> get userData {
    return houseCollection.doc(uid).snapshots().map((_userDataFromSnapshot));
  }*/
}
