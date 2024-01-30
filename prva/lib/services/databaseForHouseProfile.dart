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


/* vecchio, riscritto */
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

  Future createUserDataHouseProfileAdj(
      String type, String address, String city, String description, double price, int floorNumber, int numBath, int numPlp, 
      int startYear, int endYear, int startMonth, int endMonth, int startDay, int endDay,
      String imageURL1, String imageURL2, String imageURL3, String imageURL4 ) async {
    await houseProfileCollection.doc().set({
      'owner': uid,
      'type': type,
      'floorNum': floorNumber,
      'description': description,
      'address': address,
      'city': city,
      'price': price,
      'numBath': numBath,
      'numPlp': numPlp,
      'startYear': startYear,
      'endYear': endYear,
      'startMonth': startMonth,
      'endMonth': endMonth,
      'startDay': startDay,
      'endDay': endDay,
      'imageURL1': imageURL1,
      'imageURL2': imageURL2,
      'imageURL3': imageURL3,
      'imageURL4': imageURL4,

    });
  }
  
  
  /* vecchio */

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
  /* vecchio, riscritto */
  List<HouseProfile> _houseProfileUserFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map<HouseProfile>((doc) {
      return HouseProfile(
          type: doc.get('type') ?? "",
          address: doc.get('address') ?? "",
          city: doc.get('city') ?? "",
          price: doc.get('price') ?? 0,
          owner: doc.get('owner') ?? "",
          idHouse: doc.reference.id,
          );
         
    }).toList();
  }

  List<HouseProfileAdj> _houseProfileUserFromSnapshotAdj(QuerySnapshot snapshot) {
    return snapshot.docs.map<HouseProfileAdj>((doc) {
      return HouseProfileAdj(
          type: doc.get('type') ?? "",
          address: doc.get('address') ?? "",
          city: doc.get('city') ?? "",
          price: doc.get('price') ?? 0.0,
          owner: doc.get('owner') ?? "",
          idHouse: doc.reference.id,
           floorNumber: doc.get( 'floorNum') ?? 0,
       description: doc.get('description') ?? "",
       numBath : doc.get('numBath') ?? 0,
      numPlp: doc.get('numPlp') ?? 0 ,
      startYear : doc.get('startYear') ?? 0,
      endYear: doc.get('endYear') ?? 0,
      startMonth: doc.get('startMonth') ?? 0,
      endMonth: doc.get('endMonth') ?? 0,
     startDay: doc.get('startDay') ?? 0,
       endDay: doc.get('endDay') ?? 0,
      imageURL1: doc.get('imageURL1') ?? "",
      imageURL2: doc.get('imageURL2') ?? "",
     imageURL3: doc.get('imageURL3') ?? "",
      imageURL4: doc.get('imageURL4') ?? "",
          );
    }).toList();
  }

/* vecchio, riscritto */
  Stream<List<HouseProfile>> get getHouses {
    return FirebaseFirestore.instance
        .collection('houseProfiles')
        .where('owner', isEqualTo: uid)
        .snapshots()
        .map((_houseProfileUserFromSnapshot));
  }

  Stream<List<HouseProfileAdj>> get getHousesAdj {
    return FirebaseFirestore.instance
        .collection('houseProfiles')
        .where('owner', isEqualTo: uid)
        .snapshots()
        .map((_houseProfileUserFromSnapshotAdj));
  }
  /* vecchio, riscritto */
  Stream<List<HouseProfile>> get getAllHouses {
    return FirebaseFirestore.instance
        .collection('houseProfiles')
        .snapshots()
        .map((_houseProfileUserFromSnapshot));
  }

  Stream<List<HouseProfileAdj>> get getAllHousesAdj {
    return FirebaseFirestore.instance
        .collection('houseProfiles')
        .snapshots()
        .map((_houseProfileUserFromSnapshotAdj));
  }

  /* vecchio, da riscrivere */

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

  HouseProfileAdj _myHouseProfileUserFromSnapshotAdj(DocumentSnapshot snapshot) {
      return HouseProfileAdj(
          type: snapshot.get('type') ?? "",
          address: snapshot.get('address') ?? "",
          city: snapshot.get('city') ?? "",
          price: snapshot.get('price') ?? 0.0,
          owner: snapshot.get('owner') ?? "",
          idHouse: snapshot.reference.id,
           floorNumber: snapshot.get( 'floorNum') ?? 0,
       description: snapshot.get('description') ?? "",
       numBath : snapshot.get('numBath') ?? 0,
      numPlp: snapshot.get('numPlp') ?? 0 ,
      startYear : snapshot.get('startYear') ?? 0,
      endYear: snapshot.get('endYear') ?? 0,
      startMonth: snapshot.get('startMonth') ?? 0,
      endMonth: snapshot.get('endMonth') ?? 0,
     startDay: snapshot.get('startDay') ?? 0,
       endDay: snapshot.get('endDay') ?? 0,
      imageURL1: snapshot.get('imageURL1') ?? "",
      imageURL2: snapshot.get('imageURL2') ?? "",
     imageURL3: snapshot.get('imageURL3') ?? "",
      imageURL4: snapshot.get('imageURL4') ?? "",
          );
  }


   Stream<HouseProfileAdj> get getMyHouseAdj {
    return houseProfileCollection
        .doc(uid)
        .snapshots()
        .map((_myHouseProfileUserFromSnapshotAdj));
  }
}
