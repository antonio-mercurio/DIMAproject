import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/houseProfile.dart';
import 'package:prva/models/personalProfile.dart';
import 'package:prva/services/match/match_service.dart';


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
    final myHouse = Provider.of<HouseProfile>(context);
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.red[profile.age],
              ),
              title: Text(profile.name + " "+ profile.surname),
              subtitle: Text(profile.age.toString()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                icon: const Icon(Icons.favorite_outline),
                onPressed: () async {
                  await MatchService().putPrefence(myHouse.idHouse, profile.uid, "like");
                }),
                const SizedBox(width: 8),
                IconButton(
                icon: const Icon(Icons.close_outlined),
                onPressed: () async {
                  await MatchService().putPrefence(myHouse.idHouse, profile.uid, "dislike");}
                  ),
                const SizedBox(width: 8),
              ],
            ),
            ])
          )
        );
  }
}
