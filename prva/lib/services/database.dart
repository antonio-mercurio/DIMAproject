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

  Future updatePersonalProfileAdj(String name, String surname, String description,String gender, String employment, List<String> imageURLs)async {
    return await persProfileCollection.doc(uid).set({
      'name': name,
      'surname': surname,
      'description': description,
      'gender': gender,
      'employment': employment,
      'imageURLs': imageURLs,
    });
  }

  /* vecchio, da cancellare, riscritto */

  PersonalProfile _persProfileDataFromSnapshot(DocumentSnapshot snapshot) {
    return PersonalProfile(
      uid: uid ?? "",
      name: snapshot.get('name') ?? "",
      surname: snapshot.get('surname') ?? "",
      age: snapshot.get('age') ?? 0,
    );
  }
  /* da cancellare, riscritto */

  Stream<PersonalProfile> get getMyPersonalProfile {
    return persProfileCollection
        .doc(uid)
        .snapshots()
        .map((_persProfileDataFromSnapshot));
  }

 
  List<PersonalProfile> _allPersProfileDataFromSnapshot(
      QuerySnapshot snapshot) {
    return snapshot.docs.map<PersonalProfile>((doc) {
      return PersonalProfile(
          uid: doc.reference.id,
          name: doc.get('name') ?? "",
          surname: doc.get('surname') ?? "",
          age: doc.get('age') ?? 0);
    }).toList();
  }


  PersonalProfileAdj _persProfileDataFromSnapshotAdj(DocumentSnapshot snapshot) {
    print("ok, sto entrando nella nuova funzione");
    return PersonalProfileAdj(
      uidA: uid ?? "",
      nameA: snapshot.get('name') ?? "prova",
      surnameA: snapshot.get('surname') ?? "",
      description: snapshot.get('description') ?? "",
      gender: snapshot.get('gender') ?? "",
      employment: snapshot.get('employment') ?? "",
      imageURLs: ["ok"],
      );
  }


  /* vecchio, da cancellare */
  Stream<PersonalProfile> get persProfileData {
    return persProfileCollection
        .doc(uid)
        .snapshots()
        .map((_persProfileDataFromSnapshot));
  }


  Stream<PersonalProfileAdj> get persProfileDataAdj {
    print(uid);
    print('ok sto accedendo');
    return persProfileCollection
        .doc(uid)
        .snapshots()
        .map((_persProfileDataFromSnapshotAdj));
  }
  


  /*Future updateUserData(String owner, String city, int cap) async {
    print('stampa prova');
    return await houseCollection.doc(uid).set({
      'owner': owner,
      'city': city,
      'cap': cap,
    });
  }*/

  List<String> _profileAlreadySeenFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map<String>((doc) {
      return doc.reference.id;
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

  Stream<List<PersonalProfile>> getFilteredProfile(
      FiltersPerson? selectedFilters) {
    Query query = persProfileCollection;
    //print("alreadySeen sul db alla riga< 100 è: ");
    //print(alreadySeen);
    if (selectedFilters != null) {
      if (selectedFilters.maxAge != null) {
        query = query.where('age', isLessThanOrEqualTo: selectedFilters.maxAge);
      }
      if (selectedFilters.minAge != null) {
        query = query.where('age', isGreaterThan: selectedFilters.minAge);
      }
    } /*
    if (alreadySeen != null) {
      if (alreadySeen.isNotEmpty) {
        query = query.where(FieldPath.documentId, whereNotIn: alreadySeen);
        if (query.snapshots().length == 0) {
          print('DATABASE 90: la query è vuota');
        } else {
          print('db 93 la query non è vuota ma ha lenght:');
          print(query.snapshots().length);
        }
      }
    }*/
    return query.snapshots().map((_allPersProfileDataFromSnapshot));
  }

  Stream<List<PersonalProfile>> getAllProfile() {
    Query query = FirebaseFirestore.instance.collection('personalProfiles');
    /*Filters provaFiltri = Filters(
        userID: "gnegne", city: "Roma", type: "Monolocale", budget: 100);

    query = query.where('city', isEqualTo: provaFiltri.city);
    query = query.where('type', isEqualTo: provaFiltri.type);
*/
    return query.snapshots().map((_allPersProfileDataFromSnapshot));
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
