import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prva/models/filters.dart';
import 'package:prva/models/houseProfile.dart';

//used to vcreate and update house profile
//and to get filtered house for personal profile
class DatabaseServiceHouseProfile {
  //the uid is of the user of the house profile
  final String? uid;
  DatabaseServiceHouseProfile(this.uid);
  //colection reference
  final CollectionReference houseProfileCollection =
      FirebaseFirestore.instance.collection('houseProfiles');
  final CollectionReference filtersPersonCollection =
      FirebaseFirestore.instance.collection('filtersPerson');

  Future<String> createUserDataHouseProfile(
      String type, String address, String city, int price) async {
    await houseProfileCollection.doc().set({
      'owner': uid,
      'type': type,
      'address': address,
      'city': city,
      'price': price,
    });
    return houseProfileCollection.doc().id;
  }

  Future updateUserDataHouseProfile(String type, String address, String city,
      int price, String uidHouse) async {
    //print('modifica profilo casa andato a buon fine');

    return await houseProfileCollection.doc(uidHouse).set({
      'owner': uid,
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

  Stream<List<HouseProfile>> getFilteredHouses(Filters? selectedFilters) {
    Query query = houseProfileCollection;
    /*Filters provaFiltri = Filters(
        userID: "gnegne", city: "Roma", type: "Monolocale", budget: 100);

    query = query.where('city', isEqualTo: provaFiltri.city);
    query = query.where('type', isEqualTo: provaFiltri.type);
*/
    if (selectedFilters != null) {
      if (selectedFilters.city != null && selectedFilters.city != 'any') {
        query = query.where('city', isEqualTo: selectedFilters.city);
      }
      if (selectedFilters.type != null && selectedFilters.type != 'any') {
        query = query.where('type', isEqualTo: selectedFilters.type);
      }
    }
    return query.snapshots().map((_houseProfileUserFromSnapshot));
  }
}
