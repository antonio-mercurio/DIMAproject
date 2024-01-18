import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/personalProfile.dart';


/* Class used by House Profile to show the Search
of the people */
class AllProfilesList extends StatefulWidget {
  const AllProfilesList({super.key});

  @override
  State<AllProfilesList> createState() => _AllProfilesListState();
}

class _AllProfilesListState extends State<AllProfilesList> {
  @override
  Widget build(BuildContext context) {
    final profiles = Provider.of<List<PersonalProfile>>(context);
    return ListView.builder(
      itemCount: profiles.length,
      itemBuilder: (context, index) {
        return AllPersonalTiles(profile: profiles[index]);
      },
    );
  }
}

class AllPersonalTiles extends StatelessWidget {
  final PersonalProfile profile;
  AllPersonalTiles({required this.profile});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.red[profile.age],
              ),
              title: Text(profile.name + " "+ profile.surname),
              subtitle: Text(profile.age.toString()),
            )));
  }
}
