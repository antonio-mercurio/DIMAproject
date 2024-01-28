import 'package:flutter/material.dart';
import 'package:prva/models/personalProfile.dart';

class SwipePersonalWidget extends StatelessWidget {
  final PersonalProfileAdj personalProfile;

  const SwipePersonalWidget({super.key, required this.personalProfile});

  int _calculationAge(int year, int month, int day) {
    return (DateTime.now().difference(DateTime.utc(year, month, day)).inDays /
            365)
        .floor();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height * 0.70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: Image.network(
                      'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTh8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=900&q=60')
                  .image,
            ),
          ),
          child: Container(
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height * 0.15,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 131, 130, 130),
                  Color.fromARGB(0, 219, 225, 228),
                  Colors.black
                ],
                stops: [0, 0.5, 1],
                begin: AlignmentDirectional(0, -1),
                end: AlignmentDirectional(0, 1),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${personalProfile.nameA}  ${personalProfile.surnameA}',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                      child: Text(
                        _calculationAge(personalProfile.year,
                                personalProfile.month, personalProfile.day)
                            .toString(),
                        style: TextStyle(
                            fontFamily: 'Readex Pro',
                            fontSize: 22,
                            color: Colors.white),
                      ),
                    ),
                  ]),
            ),
          ))
    ]);
  }
}
