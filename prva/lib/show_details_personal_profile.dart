import 'package:flutter/material.dart';
import 'package:prva/models/personalProfile.dart';

class DetailedPersonalProfile extends StatelessWidget {
  final PersonalProfileAdj personalProfile;

  const DetailedPersonalProfile({super.key, required this.personalProfile});

  int _calculationAge(int year, int month,int day){
    return (DateTime.now().difference(DateTime.utc(year, month, day)).inDays/365).round();
  }
    @override
    Widget build(BuildContext context) {

    return Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [ 
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
                    child: Text(
                      '${personalProfile.nameA} ${personalProfile.surnameA}',
                      style:const TextStyle(fontSize: 22.0, 
                      color: Colors.black,
                      fontFamily: 'Plus Jakarta Sans',)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 12, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                         child: Image.network(
                           'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTh8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=900&q=60',
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
                      _calculationAge(personalProfile.year, personalProfile.month, personalProfile.day).toString(),
                      style: TextStyle(fontSize: 18.0, 
                      color: Colors.black,
                      fontFamily: 'Plus Jakarta Sans',),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 8, 0, 0),
                    child: Text(
                      personalProfile.description,
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
                          'Gender:',
                          style: TextStyle(fontSize: 20.0, 
                          color: Colors.black,
                          fontFamily: 'Plus Jakarta Sans'),
                        ),
                        Text(
                          personalProfile.gender,
                          style: TextStyle(fontSize: 20.0, 
                          color: Colors.black,
                          fontFamily: 'Plus Jakarta Sans'),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Employment:',
                          style: TextStyle(fontSize: 20.0, 
                          color: Colors.black,
                          fontFamily: 'Plus Jakarta Sans'),
                        ),
                        Text(
                          personalProfile.employment,
                          style: TextStyle(fontSize: 20.0, 
                          color: Colors.black,
                          fontFamily: 'Plus Jakarta Sans'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
  }
}