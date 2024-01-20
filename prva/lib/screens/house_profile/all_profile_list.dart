import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/houseProfile.dart';
import 'package:prva/models/personalProfile.dart';
import 'package:prva/models/preference.dart';
import 'package:prva/services/database.dart';
import 'package:prva/services/match/match_service.dart';

/* Class used by House Profile to show the Search
of the people */
class AllProfilesList extends StatefulWidget {
  final HouseProfile house;

  AllProfilesList({required this.house});

  @override
  State<AllProfilesList> createState() => _AllProfilesListState(house: house);
}

class _AllProfilesListState extends State<AllProfilesList> {
  List<String>? alreadySeenProfiles;
  final HouseProfile house;
  _AllProfilesListState({required this.house});

  @override
  Widget build(BuildContext context) {
    final retrievedAlreadySeenProfiles =
        DatabaseService(house.idHouse).getAlreadySeenProfile;
    retrievedAlreadySeenProfiles.listen((content) {
      alreadySeenProfiles = content;
      //print(alreadySeenProfiles?.length);
      //print(alreadySeenProfiles?.length);
      if (this.mounted) {
        setState(() {});
      }
    });
    final profiles = Provider.of<List<PersonalProfile>>(context);

    //check already seen != null prima di fare questo filtri
    if (alreadySeenProfiles != null) {
      profiles
          .removeWhere((element) => alreadySeenProfiles!.contains(element.uid));
      print('allprof32 - rimuovo');
    }
    if (profiles.isEmpty) {
      return Center(
        child: Text('non ci sono profili da visualizzare'),
      );
    } else {
      return ListView.builder(
        itemCount: profiles.length,
        itemBuilder: (context, index) {
          return AllPersonalTiles(profile: profiles[index]);
        },
      );
    }
  }
}

class AllPersonalTiles extends StatelessWidget {
  final PersonalProfile profile;
  List<PreferenceForMatch>? preferencesOther;
  AllPersonalTiles({required this.profile});

  @override
  Widget build(BuildContext context) {
    final myHouse = Provider.of<HouseProfile>(context);
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.red[profile.age],
                ),
                title: Text(profile.name + " " + profile.surname),
                subtitle: Text(profile.age.toString()),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                      icon: const Icon(Icons.favorite_outline),
                      onPressed: () async {
                        /* Put like */
                        print("like");
                        await MatchService()
                            .putPrefence(myHouse.idHouse, profile.uid, "like");

                        /* check fot match */
                        final retrievedPreferences =
                            MatchService(uid: profile.uid)
                                .getPreferencesForMatch;

                        retrievedPreferences.listen((content) {
                          preferencesOther = content;
                        });
                        /* searche if the other has seen your profile and put a like */
                        final searchedPreference = PreferenceForMatch(
                            reciverPreferenceId: myHouse.idHouse,
                            choice: "like");
                        if (preferencesOther != null) {
                          if (preferencesOther!.contains(searchedPreference)) {
                            /* there is a match */
                            print("match");
                            await MatchService()
                                .createNewMatch(myHouse.idHouse, profile.uid);
                            await MatchService()
                                .createNewMatch(profile.uid, myHouse.idHouse);
                          }
                        }
                      }),
                  const SizedBox(width: 8),
                  IconButton(
                      icon: const Icon(Icons.close_outlined),
                      onPressed: () async {
                        await MatchService().putPrefence(
                            myHouse.idHouse, profile.uid, "dislike");
                      }),
                  const SizedBox(width: 8),
                ],
              ),
            ])));
  }
}
