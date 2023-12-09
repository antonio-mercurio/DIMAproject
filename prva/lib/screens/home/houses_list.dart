import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class HousesList extends StatefulWidget {
  const HousesList({super.key});

  @override
  State<HousesList> createState() => _HousesListState();
}

class _HousesListState extends State<HousesList> {
  @override
  Widget build(BuildContext context) {
    final houses = Provider.of<QuerySnapshot>(context);
    //print(houses.docs);
    for (var doc in houses.docs) {
      print(doc.data);
    }
    return Container();
  }
}
