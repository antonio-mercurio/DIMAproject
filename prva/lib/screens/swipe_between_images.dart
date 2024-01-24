import 'package:flutter/material.dart';
import 'package:prva/models/houseProfile.dart';

class SwipeWidget extends StatelessWidget {

  final HouseProfile houseProfile;

  const SwipeWidget({super.key, required this.houseProfile});

 @override
  Widget build(BuildContext context) {

    return Column(children: <Widget>[
        Container(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height * 0.72,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: Image.network(
                           'https://i.pinimg.com/originals/d7/75/ba/d775ba84bdb529203308b9d65c1db59f.jpg'
                           ).image,
            ),
          ),
             child: Container(
                width: double.infinity,
                height: 500,
                decoration: BoxDecoration(
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 24,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(134, 9, 9, 9),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: AlignmentDirectional(0.00, 0.00),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(12, 0, 8, 0),
                                child: Text(
                                   houseProfile.city +' - ' + houseProfile.type,
                                  style: TextStyle(color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Plus Jakarta Sans',
                                ),
                                ),
                              ),          
                              ),
                              ],
                      ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 22,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(134, 9, 9, 9),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: AlignmentDirectional(0.00, 0.00),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(12, 0, 8, 0),
                                child: Text(
                                  houseProfile.price.toString(),
                                  style: TextStyle(color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Plus Jakarta Sans',
                                ),
                                ),
                              ),
                            ),
                          ],
                        )
                        
                        ),
                    ],
                  ),
                ),
              ),
        ),
         
    ]
    );
  }
}
