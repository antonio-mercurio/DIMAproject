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
  Future updateFiltersPerson(int? minAge, int? maxAge) async {
    return await filtersPersonCollection.doc(uid).set({
      'house': uid,
      'maxAge': maxAge,
      'minAge': minAge,
    });
  }

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

  Stream<FiltersPerson> get getFiltersPerson {
    return filtersPersonCollection
        .doc(uid)
        .snapshots()
        .map((_filtersPersonFromSnapshot));
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
