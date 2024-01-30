import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prva/models/filters.dart';
import 'package:prva/models/personalProfile.dart';

/* Service used for the update of the personal profile
and to filter the personal profile */

class DatabaseService {
  final String? uid;
  DatabaseService(this.uid);
  //collection reference
  final CollectionReference persProfileCollection =
      FirebaseFirestore.instance.collection('personalProfiles');

/* Vecchio, da cancellare  riscritto*/
  Future updatePersonalProfile(String name, String surname, int age) async {
    return await persProfileCollection.doc(uid).set({
      'name': name,
      'surname': surname,
      'age': age,
    });
  }

  Future updatePersonalProfileAdj(
      String name,
      String surname,
      String description,
      String gender,
      String employment,
      int day,
      int month,
      int year,
      String imageURL1,
      String imageURL2,
      String imageURL3,
      String imageURL4) async {
    return await persProfileCollection.doc(uid).set({
      'name': name,
      'surname': surname,
      'description': description,
      'gender': gender,
      'employment': employment,
      'day': day,
      'month': month,
      'year': year,
      'imageURL1': imageURL1,
      'imageURL2': imageURL2,
      'imageURL3': imageURL3,
      'imageURL4': imageURL4,
    });
  }

  PersonalProfileAdj _persProfileDataFromSnapshotAdj(
      DocumentSnapshot snapshot) {
    return PersonalProfileAdj(
      uidA: uid ?? "",
      nameA: snapshot.get('name') ?? "prova",
      surnameA: snapshot.get('surname') ?? "",
      description: snapshot.get('description') ?? "",
      gender: snapshot.get('gender') ?? "",
      employment: snapshot.get('employment') ?? "",
      imageURL1: snapshot.get('imageURL1') ?? "",
      imageURL2: snapshot.get('imageURL2') ?? "",
      imageURL3: snapshot.get('imageURL3') ?? "",
      imageURL4: snapshot.get('imageURL4') ?? "",
      year: snapshot.get('year') ?? 0,
      month: snapshot.get('month') ?? 0,
      day: snapshot.get('day') ?? 0,
    );
  }

  Stream<PersonalProfileAdj> get persProfileDataAdj {
    return persProfileCollection
        .doc(uid)
        .snapshots()
        .map((_persProfileDataFromSnapshotAdj));
  }

  List<String> _profileAlreadySeenFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map<String>((doc) {
      if (doc.exists) {
        return doc.reference.id;
      } else {
        return "";
      }
    }).toList();
  }

  List<PersonalProfileAdj> _allPersProfileDataFromSnapshotAdj(
      QuerySnapshot snapshot) {
    return snapshot.docs.map<PersonalProfileAdj>((doc) {
      return PersonalProfileAdj(
        uidA: doc.reference.id,
        nameA: doc.get('name') ?? "",
        surnameA: doc.get('surname') ?? "",
        description: doc.get('description') ?? "",
        gender: doc.get('gender') ?? "",
        employment: doc.get('employment') ?? "",
        imageURL1: doc.get('imageURL1'),
        imageURL2: doc.get('imageURL2'),
        imageURL3: doc.get('imageURL3'),
        imageURL4: doc.get('imageURL4'),
        year: doc.get('year'),
        month: doc.get('month'),
        day: doc.get('day'),
      );
    }).toList();
  }

  Stream<List<String>> get getAlreadySeenProfile {
    return FirebaseFirestore.instance
        .collection('preference_room')
        .doc(uid)
        .collection('preference')
        .snapshots()
        .map((_profileAlreadySeenFromSnapshot));
  }

  Stream<List<PersonalProfileAdj>> getAllPersonalProfiles() {
    return persProfileCollection
        .snapshots()
        .map((_allPersProfileDataFromSnapshotAdj));
  }
}
