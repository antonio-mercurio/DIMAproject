import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseServiceHouseProfile {

  final String? uid;
  DatabaseServiceHouseProfile(this.uid);

  //colection reference
  final CollectionReference houseProfileCollection = FirebaseFirestore.instance.collection('houseProfiles');


  Future createUserDataHouseProfile(String type, String address,String city, int price) async {
    print('creazione nuovo profilo casa andato a buon fine');

    return await houseProfileCollection.doc().set({
      'owner' : uid,
      'type': type,
      'address' : address, 
      'city': city,
      'price': price,
    });
  }


  Future updateUserDataHouseProfile(String type, String address,String city, int price, String uidHouse ) async {
    print('modifica profilo casa andato a buon fine');

    return await houseProfileCollection.doc(uidHouse).set({
      'type': type,
      'address' : address, 
      'city': city,
      'price': price,
    });
  }

}