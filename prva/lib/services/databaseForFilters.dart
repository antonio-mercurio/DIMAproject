import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prva/models/filters.dart';

class DatabaseServiceFilters {
  final String? uid;
  DatabaseServiceFilters(this.uid);

  final CollectionReference filtersCollection =
      FirebaseFirestore.instance.collection('filters');

  //filters for the house utilized by person Profile
  Future updateFilters(String city, String type, double budget) async {
    print('modifica filtri');
    return await filtersCollection.doc(uid).set({
      'user': uid,
      'city': city,
      'type': type,
      'budget': budget,
    });
  }

  Filters _filtersFromSnapshot(DocumentSnapshot snapshot) {
    return Filters(
      userID: uid ?? "",
      city: snapshot.get('city') ?? "",
      type: snapshot.get('type') ?? "",
      budget: snapshot.get('budget') ?? 0.0,
    );
  }

  Stream<Filters> get getFilters {
    return filtersCollection.doc(uid).snapshots().map((_filtersFromSnapshot));
  }
}
