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

  Future createUserDataHouseProfileAdj(
      String type,
      String address,
      String city,
      String description,
      double price,
      int floorNumber,
      int numBath,
      int numPlp,
      int startYear,
      int endYear,
      int startMonth,
      int endMonth,
      int startDay,
      int endDay,
      double latitude,
      double longitude,
      String imageURL1,
      String imageURL2,
      String imageURL3,
      String imageURL4) async {
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
      'latitude': latitude,
      'longitude': longitude,
      'imageURL1': imageURL1,
      'imageURL2': imageURL2,
      'imageURL3': imageURL3,
      'imageURL4': imageURL4,
    });
  }

  List<HouseProfileAdj> _houseProfileUserFromSnapshotAdj(
      QuerySnapshot snapshot) {
    return snapshot.docs.map<HouseProfileAdj>((doc) {
      return HouseProfileAdj(
        type: doc.get('type') ?? "",
        address: doc.get('address') ?? "",
        city: doc.get('city') ?? "",
        price: doc.get('price') ?? 0.0,
        owner: doc.get('owner') ?? "",
        idHouse: doc.reference.id,
        floorNumber: doc.get('floorNum') ?? 0,
        description: doc.get('description') ?? "",
        numBath: doc.get('numBath') ?? 0,
        numPlp: doc.get('numPlp') ?? 0,
        startYear: doc.get('startYear') ?? 0,
        endYear: doc.get('endYear') ?? 0,
        startMonth: doc.get('startMonth') ?? 0,
        endMonth: doc.get('endMonth') ?? 0,
        startDay: doc.get('startDay') ?? 0,
        endDay: doc.get('endDay') ?? 0,
        latitude: doc.get('latitude') ?? 0.0,
        longitude: doc.get('longitude') ?? 0.0,
        imageURL1: doc.get('imageURL1') ?? "",
        imageURL2: doc.get('imageURL2') ?? "",
        imageURL3: doc.get('imageURL3') ?? "",
        imageURL4: doc.get('imageURL4') ?? "",
      );
    }).toList();
  }

  Stream<List<HouseProfileAdj>> get getHousesAdj {
    return FirebaseFirestore.instance
        .collection('houseProfiles')
        .where('owner', isEqualTo: uid)
        .snapshots()
        .map((_houseProfileUserFromSnapshotAdj));
  }

  Stream<List<HouseProfileAdj>> get getAllHousesAdj {
    return FirebaseFirestore.instance
        .collection('houseProfiles')
        .snapshots()
        .map((_houseProfileUserFromSnapshotAdj));
  }

  HouseProfileAdj _myHouseProfileUserFromSnapshotAdj(
      DocumentSnapshot snapshot) {
    return HouseProfileAdj(
      type: snapshot.get('type') ?? "",
      address: snapshot.get('address') ?? "",
      city: snapshot.get('city') ?? "",
      price: snapshot.get('price') ?? 0.0,
      owner: snapshot.get('owner') ?? "",
      idHouse: snapshot.reference.id,
      floorNumber: snapshot.get('floorNum') ?? 0,
      description: snapshot.get('description') ?? "",
      numBath: snapshot.get('numBath') ?? 0,
      numPlp: snapshot.get('numPlp') ?? 0,
      startYear: snapshot.get('startYear') ?? 0,
      endYear: snapshot.get('endYear') ?? 0,
      startMonth: snapshot.get('startMonth') ?? 0,
      endMonth: snapshot.get('endMonth') ?? 0,
      startDay: snapshot.get('startDay') ?? 0,
      endDay: snapshot.get('endDay') ?? 0,
      latitude: snapshot.get('latitude') ?? 0.0,
      longitude: snapshot.get('longitude') ?? 0.0,
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

  updateHouseProfileAdj(
      String owner,
      String type,
      String address,
      String city,
      String description,
      double price,
      int floorNum,
      int bathsNum,
      int numPpl,
      int startYear, //mettere start ed end year,day,month
      int startMonth,
      int startDay,
      int endYear,
      int endMonth,
      int endDay,
      double latitude,
      double longitude,
      String imageURL1,
      String imageURL2,
      String imageURL3,
      String imageURL4) async {
    return await houseProfileCollection.doc(uid).set({
      'owner': owner,
      'type': type,
      'floorNum': floorNum,
      'description': description,
      'address': address,
      'city': city,
      'price': price,
      'numBath': bathsNum,
      'numPlp': numPpl,
      'startYear': startYear,
      'endYear': endYear,
      'startMonth': startMonth,
      'endMonth': endMonth,
      'startDay': startDay,
      'endDay': endDay,
      'latitude': latitude,
      'longitude': longitude,
      'imageURL1': imageURL1,
      'imageURL2': imageURL2,
      'imageURL3': imageURL3,
      'imageURL4': imageURL4,
    });
  }

  deleteHouseProfileAdj() async {
    return await houseProfileCollection.doc(uid).delete();
  }
}
