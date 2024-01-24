import 'package:flutter/material.dart';
import 'package:prva/models/houseProfile.dart';

class DetailedProfile extends StatelessWidget {
  final HouseProfile houseProfile;

  const DetailedProfile({super.key, required this.houseProfile});
    @override
    Widget build(BuildContext context) {

    return Scaffold(
     backgroundColor: Colors.white,
            appBar: AppBar(
                backgroundColor: Colors.black,
        title: Text(
          'Affinder',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [ 
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
                    child: Text(
                      houseProfile.type,
                      style:TextStyle(fontSize: 22.0, 
                      color: Colors.black,
                      fontFamily: 'Plus Jakarta Sans',)
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 12, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                         child: Image.network(
                           'https://i.pinimg.com/originals/d7/75/ba/d775ba84bdb529203308b9d65c1db59f.jpg',
                            height: 400,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 8, 0, 0),
                    child: Text(
                      houseProfile.city,
                      style: TextStyle(fontSize: 18.0, 
                      color: Colors.black,
                      fontFamily: 'Plus Jakarta Sans',),
                    ),
                  ),
                 
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 8, 0, 0),
                    child: Text(
                      houseProfile.address,
                      style: TextStyle(fontSize: 16.0, 
                      color: Colors.black,
                      fontFamily: 'Plus Jakarta Sans'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 8, 0, 0),
                    child: Text(
                      "The house is composed ...",
                      style: TextStyle(fontSize: 16.0, 
                      color: Colors.black,
                      fontFamily: 'Plus Jakarta Sans'),
                    ),
                  ),
                  Divider(
                    height: 36,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Price:',
                          style: TextStyle(fontSize: 20.0, 
                          color: Colors.black,
                          fontFamily: 'Plus Jakarta Sans'),
                        ),
                        Text(
                          houseProfile.price.toString(),
                          style: TextStyle(fontSize: 20.0, 
                          color: Colors.black,
                          fontFamily: 'Plus Jakarta Sans'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
