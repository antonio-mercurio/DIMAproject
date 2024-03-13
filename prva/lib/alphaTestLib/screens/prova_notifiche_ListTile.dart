import 'package:flutter/material.dart';

class ProvaNotifiche extends StatelessWidget {
  const ProvaNotifiche({super.key});
  
  final bool condition = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
              leading: CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.red,
              ),
              title: Text('User'),
              subtitle: Text('ciao!'),
            trailing: condition ? null
            : Container(
              child: Text('1',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600
              ),
              ),
    height: 16,
    width: 16,
    decoration: BoxDecoration(
      color: Color(0xFF4B39EF),
      borderRadius: BorderRadius.all(Radius.circular(100)),
    ),
  ),
             ),
        ));
  }
}