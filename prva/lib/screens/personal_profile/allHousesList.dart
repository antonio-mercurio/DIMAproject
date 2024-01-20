
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/houseProfile.dart';
import 'package:prva/models/personalProfile.dart';
import 'package:prva/models/preference.dart';
import 'package:prva/services/match/match_service.dart';

class AllHousesList extends StatefulWidget {
  const AllHousesList({super.key});

  @override
  State<AllHousesList> createState() => _AllHousesListState();
}

class _AllHousesListState extends State<AllHousesList> {
  @override
  Widget build(BuildContext context) {
    final houses = Provider.of<List<HouseProfile>>(context);
    return ListView.builder(
      itemCount: houses.length,
      itemBuilder: (context, index) {
        return AllHousesTiles(house: houses[index]);
      },
    );
  }
}

class AllHousesTiles extends StatelessWidget {
  
  final HouseProfile house;
  List<PreferenceForMatch>? preferencesOther;
  int ok=1;
  AllHousesTiles({required this.house});
  @override
  Widget build(BuildContext context) {
    final myUser = Provider.of<PersonalProfile>(context);
    if(ok ==1){
    final retrievedPreferences =MatchService().getPreferencesForMatch(house.idHouse);
    retrievedPreferences.listen((content) {
      print("preso il contenuto riga 41 allHouselist");
      ok=0;
      preferencesOther = content;
      });
    }
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  radius: 25.0,
                  backgroundColor:  Colors.red[house.price],
                ),
                title: Text(house.type),
                subtitle: Text('Si trova a ${house.city}'),
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
                            .putPrefence(myUser.uid, house.idHouse, "like");
                        print("dopo aver messo la preferenza");

                        await MatchService().checkMatch(myUser.uid, house.idHouse, preferencesOther);

                      }),
                  const SizedBox(width: 8),
                  IconButton(
                      icon: const Icon(Icons.close_outlined),
                      onPressed: () async {
                        await MatchService().putPrefence(
                            myUser.uid, house.idHouse, "dislike");
                      }),
                  const SizedBox(width: 8),
                ],
              ),
            ])));
  }
  }


 