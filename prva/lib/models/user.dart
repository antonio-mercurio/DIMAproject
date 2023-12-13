class Utente {
  final String uid;

  Utente({required this.uid});
}

class UserData {
  final String uid;
  final String owner;
  final String city;
  final int cap;

  UserData(
      {required this.uid,
      required this.owner,
      required this.city,
      required this.cap});
}
