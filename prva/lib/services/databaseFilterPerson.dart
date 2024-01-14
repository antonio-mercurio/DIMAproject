import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prva/models/filters.dart';

class DatabaseServiceFiltersPerson {
  final String? uid;
  DatabaseServiceFiltersPerson(this.uid);

  final CollectionReference filtersPersonCollection =
      FirebaseFirestore.instance.collection('filters');

  //filters for people utilized by house profile
  Future updateFiltersPerson(int minAge, int maxAge) async {
    print('modifica filtri');
    return await filtersPersonCollection.doc(uid).set({
      'house': uid,
      'maxAge': maxAge,
      'minAge': minAge,
    });
  }

  FiltersPerson _filtersPersonFromSnapshot(DocumentSnapshot snapshot) {
    return FiltersPerson(
      houseID: uid ?? "",
      minAge: snapshot.get('minAge') ?? 0,
      maxAge: snapshot.get('maxAge') ?? 99,
    );
  }

  Stream<FiltersPerson> get getFiltersPerson {
    return filtersPersonCollection.doc(uid).snapshots().map((_filtersPersonFromSnapshot));
  }
}