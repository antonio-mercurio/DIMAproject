
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prva/models/filters.dart';

/* Database to set the filters for the house profile 
and used to get your house profile*/

class DatabaseServiceFiltersPerson {
  //uid is the id of the house
  final String? uid;
  DatabaseServiceFiltersPerson({this.uid});

  final CollectionReference filtersPersonCollection =
      FirebaseFirestore.instance.collection('filtersPerson');

  final CollectionReference houseProfileCollection =
      FirebaseFirestore.instance.collection('houseProfiles');

  //filters for people utilized by house profile

  Future updateFiltersPersonAj(int? minAge, int? maxAge, String? gender, String? employment) async {
    return await filtersPersonCollection.doc(uid).set({
      'house': uid,
      'maxAge': maxAge,
      'minAge': minAge,
      'gender': gender,
      'employment': employment
    });
  }

  FiltersPersonAdj _filtersPersonFromSnapshotAdj(DocumentSnapshot snapshot) {
    if (snapshot.data() == null) {
      return FiltersPersonAdj(
        houseID: uid ?? "",
        minAge: 1,
        maxAge: 100,
        gender: "not relevant",
        employment: "not relevant",
      );
    } else {
      return FiltersPersonAdj(
        houseID: uid ?? "",
        minAge: snapshot.get('minAge') ?? 1,
        maxAge: snapshot.get('maxAge') ?? 100,
        gender: snapshot.get('gender') ?? "not relevant",
        employment: snapshot.get('employment') ?? "not relevant",

      );
    }
  }

   Stream<FiltersPersonAdj> get getFiltersPersonAdj {
    return filtersPersonCollection
        .doc(uid)
        .snapshots()
        .map((_filtersPersonFromSnapshotAdj));
  } 
}
