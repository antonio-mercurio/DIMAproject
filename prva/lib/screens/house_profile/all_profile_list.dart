import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/houseProfile.dart';
import 'package:prva/models/personalProfile.dart';
import 'package:prva/models/preference.dart';
import 'package:prva/screens/multipleImagePicker.dart';
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
  List<PreferenceForMatch>? preferencesOther;

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
      //print('allprof32 - rimuovo');
    }
    if (profiles.isEmpty) {
      return Center(
        child: Text('non ci sono profili da visualizzare'),
      );
    } else {
      final myHouse = Provider.of<HouseProfile>(context);
      final retrievedPreferences =
          MatchService(uid: profiles[0].uid).getPreferencesForMatch;
      retrievedPreferences.listen((content) {
        print("r71 allProfileList");
        preferencesOther = content;
      });
      return ListView.builder(
        //itemCount: profiles.length,
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              AllPersonalTiles(profile: profiles[0]),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                      icon: const Icon(Icons.favorite_outline),
                      onPressed: () async {
                        /* Put like */
                        print("like");
                        await MatchService().putPrefence(
                            myHouse.idHouse, profiles[0].uid, "like");

                        /* check fot match */
                        final ok = await MatchService().checkMatch(
                            myHouse.idHouse, profiles[0].uid, preferencesOther);
                        print(ok);
                        print('match creato anche in questo modo');
                        if (ok) {
                          if (!mounted) return;
                          AwesomeDialog(
                            context: context,
                            animType: AnimType.scale,
                            dialogType: DialogType.success,
                            body: const Center(
                              child: Text(
                                'Ops... hai ricevuto un match! Vai nelle chat per inziiare una conversazione!',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            btnOkOnPress: () {},
                          ).show();
                        }
                      }
                      /* search if the other has seen your profile and put a like */
                      ),
                  const SizedBox(width: 8),
                  IconButton(
                      icon: const Icon(Icons.close_outlined),
                      onPressed: () async {
                        await MatchService().putPrefence(
                            myHouse.idHouse, profiles[0].uid, "dislike");
                      }),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          );
        },
      );
    }
  }
}

class AllPersonalTiles extends StatelessWidget {
  final PersonalProfile profile;
  //List<PreferenceForMatch>? preferencesOther;
  AllPersonalTiles({required this.profile});

  @override
  Widget build(BuildContext context) {
    final myHouse = Provider.of<HouseProfile>(context);
    /*final retrievedPreferences =
        MatchService(uid: profile.uid).getPreferencesForMatch;
    retrievedPreferences.listen((content) {
      print("r71 allProfileList");
      preferencesOther = content;
    });*/
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
              /*Row(
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
                        final ok = await MatchService().checkMatch(
                            myHouse.idHouse, profile.uid, preferencesOther);
                        print(ok);
                        print('match creato anche in questo modo');
                        if (ok) {
                          /* Navigator.push(context,MaterialPageRoute(
                               builder: (context) => MultipleImagePicker()));*/
                          /*AwesomeDialog(
                                context: context,
                                animType: AnimType.scale,
                                dialogType: DialogType.success,
                                body: const Center(child: Text(
                                  'Ops... hai ricevuto un match! Vai nelle chat per inziiare una conversazione!',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                  ),),
                                  btnOkOnPress: () {},).show();*/
                        }
                      }
                      /* search if the other has seen your profile and put a like */
                      ),
                  const SizedBox(width: 8),
                  IconButton(
                      icon: const Icon(Icons.close_outlined),
                      onPressed: () async {
                        await MatchService().putPrefence(
                            myHouse.idHouse, profile.uid, "dislike");
                      }),
                  const SizedBox(width: 8),
                ],
              ),*/
            ])));
  }
}
