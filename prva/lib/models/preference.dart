class Preference {
  final String senderPreferenceId;
  final String reciverPreferenceId;
  final String choice;

  Preference(
      {required this.senderPreferenceId,
      required this.reciverPreferenceId,
      required this.choice});

  //convert to a map to store in firebase
  Map<String, dynamic> toMap() {
    return {
      'senderPreferenceID': senderPreferenceId,
      'receiverPrefernceID': reciverPreferenceId,
      'choice': choice,
    };
  }
}

class PreferenceForMatch {
  final String reciverPreferenceId;
  final String choice;

  

  PreferenceForMatch({required this.reciverPreferenceId, required this.choice});
}

class Match {
  final String userID;
  final String otheUserID;

  Match({required this.userID, required this.otheUserID});
}
