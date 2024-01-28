import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prva/models/filters.dart';
import 'package:prva/models/houseProfile.dart';

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
  /* vecchio, riscritto */
  Future updateFiltersPerson(int? minAge, int? maxAge) async {
    return await filtersPersonCollection.doc(uid).set({
      'house': uid,
      'maxAge': maxAge,
      'minAge': minAge,
    });
  }

  Future updateFiltersPersonAj(int? minAge, int? maxAge, String? gender, String? employment) async {
    return await filtersPersonCollection.doc(uid).set({
      'house': uid,
      'maxAge': maxAge,
      'minAge': minAge,
      'gender': gender,
      'employment': employment
    });
  }
  /* vecchio, riscritto */
  FiltersPerson _filtersPersonFromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot.data() == null) {
      return FiltersPerson(
        houseID: uid ?? "",
        minAge: 0,
        maxAge: 99,
      );
    } else {
      return FiltersPerson(
        houseID: uid ?? "",
        minAge: snapshot.get('minAge') ?? 0,
        maxAge: snapshot.get('maxAge') ?? 99,
      );
    }
  }

  FiltersPersonAdj _filtersPersonFromSnapshotAdj(DocumentSnapshot snapshot) {
    if (snapshot.data() == null) {
      return FiltersPersonAdj(
        houseID: uid ?? "",
        minAge: 0,
        maxAge: 99,
        gender: "not relevant",
        employment: "not relevant",
      );
    } else {
      return FiltersPersonAdj(
        houseID: uid ?? "",
        minAge: snapshot.get('minAge') ?? 0,
        maxAge: snapshot.get('maxAge') ?? 99,
        gender: snapshot.get('gender') ?? "not relevant",
        employment: snapshot.get('employment') ?? "not relevant",

      );
    }
  }

/* vecchio, riscritto */
  Stream<FiltersPerson> get getFiltersPerson {
    return filtersPersonCollection
        .doc(uid)
        .snapshots()
        .map((_filtersPersonFromSnapshot));
  }


   Stream<FiltersPersonAdj> get getFiltersPersonAdj {
    return filtersPersonCollection
        .doc(uid)
        .snapshots()
        .map((_filtersPersonFromSnapshotAdj));
  }

  

  HouseProfile _houseProfileUserFromSnapshot(DocumentSnapshot snapshot) {
    return HouseProfile(
        type: snapshot.get('type') ?? "",
        address: snapshot.get('address') ?? "",
        city: snapshot.get('city') ?? "",
        price: snapshot.get('price') ?? 0,
        owner: snapshot.get('owner') ?? "",
        idHouse: uid ?? "");
  }

  Stream<HouseProfile> get getMyHouse {
    return houseProfileCollection
        .doc(uid)
        .snapshots()
        .map((_houseProfileUserFromSnapshot));
  }
}
