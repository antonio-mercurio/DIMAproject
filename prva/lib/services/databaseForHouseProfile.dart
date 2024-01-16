import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prva/models/filters.dart';
import 'package:prva/models/houseProfile.dart';
import 'package:prva/services/databaseForFilters.dart';

class DatabaseServiceHouseProfile {
  final String? uid;
  Filters? filters;
  DatabaseServiceHouseProfile(this.uid);
  //colection reference
  final CollectionReference houseProfileCollection =
      FirebaseFirestore.instance.collection('houseProfiles');

  Future createUserDataHouseProfile(
      String type, String address, String city, int price) async {
    print('creazione nuovo profilo casa andato a buon fine');

    return await houseProfileCollection.doc().set({
      'owner': uid,
      'type': type,
      'address': address,
      'city': city,
      'price': price,
    });
  }

  Future updateUserDataHouseProfile(String type, String address, String city,
      int price, String uidHouse) async {
    print('modifica profilo casa andato a buon fine');

    return await houseProfileCollection.doc(uidHouse).set({
      'type': type,
      'address': address,
      'city': city,
      'price': price,
    });
  }

  List<HouseProfile> _houseProfileUserFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map<HouseProfile>((doc) {
      return HouseProfile(
          type: doc.get('type') ?? "",
          address: doc.get('address') ?? "",
          city: doc.get('city') ?? "",
          price: doc.get('price') ?? 0,
          owner: doc.get('owner') ?? "",
          idHouse: doc.reference.id);
    }).toList();
  }

  Stream<List<HouseProfile>> get getHouses {
    return FirebaseFirestore.instance
        .collection('houseProfiles')
        .where('owner', isEqualTo: uid)
        .snapshots()
        .map((_houseProfileUserFromSnapshot));
  }

  Stream<List<HouseProfile>> get getAllHouses {
    return FirebaseFirestore.instance
        .collection('houseProfiles')
        .snapshots()
        .map((_houseProfileUserFromSnapshot));
  }

  void setFilters(Filters selectedFilters) {
    filters = selectedFilters;
  }

  Stream<List<HouseProfile>> getFilteredHouses(Filters? selectedFilters) {
    Query query = FirebaseFirestore.instance.collection('houseProfiles');
    /*Filters provaFiltri = Filters(
        userID: "gnegne", city: "Roma", type: "Monolocale", budget: 100);

    query = query.where('city', isEqualTo: provaFiltri.city);
    query = query.where('type', isEqualTo: provaFiltri.type);
*/
    print('stampo filtri ricevuti suldb');
    print(selectedFilters?.city);
    if (selectedFilters != null) {
      if (selectedFilters.city != null) {
        query = query.where('city', isEqualTo: selectedFilters.city);
      }
      if (selectedFilters.type != null) {
        query = query.where('type', isEqualTo: selectedFilters.type);
      }
    }
    return query.snapshots().map((_houseProfileUserFromSnapshot));
  }
}
