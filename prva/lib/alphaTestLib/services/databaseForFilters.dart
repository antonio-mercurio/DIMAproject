import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prva/models/filters.dart';

class DatabaseServiceFilters {
  final String? uid;
  DatabaseServiceFilters(this.uid);

  final CollectionReference filtersCollection =
      FirebaseFirestore.instance.collection('filters');

  final List<String> typeOfAppartament = [
    "Apartment",
    "Single room",
    "Double room",
    "Studio apartment",
    "Two-room apartment",
  ];

  //filters for the house utilized by person Profile

  Future updateFiltersAdj(
      String city,
      bool apartment,
      bool singleRoom,
      bool doubleRoom,
      bool studioApartment,
      bool twoRoomsApartment,
      double budget) async {
    return await filtersCollection.doc(uid).set({
      'user': uid,
      'city': city,
      typeOfAppartament[0]: apartment,
      typeOfAppartament[1]: singleRoom,
      typeOfAppartament[2]: doubleRoom,
      typeOfAppartament[3]: studioApartment,
      typeOfAppartament[4]: twoRoomsApartment,
      'budget': budget,
    });
  }

  FiltersHouseAdj _filtersFromSnapshotAdj(DocumentSnapshot snapshot) {
    return FiltersHouseAdj(
      userID: uid ?? "",
      city: snapshot.get('city') ?? "",
      apartment: snapshot.get(typeOfAppartament[0]),
      singleRoom: snapshot.get(typeOfAppartament[1]),
      doubleRoom: snapshot.get(typeOfAppartament[2]),
      studioApartment: snapshot.get(typeOfAppartament[3]),
      twoRoomsApartment: snapshot.get(typeOfAppartament[4]),
      budget: double.parse(snapshot.get('budget').toString()),
    );
  }

  Stream<FiltersHouseAdj> get getFiltersAdj {
    return filtersCollection
        .doc(uid)
        .snapshots()
        .map((_filtersFromSnapshotAdj));
  }
}
