class Filters {
  final String userID;
  final String city;
  final String type;
  final double budget;

  Filters(
      {required this.userID,
      required this.city,
      required this.type,
      required this.budget});
}

class FiltersPerson {
  final String houseID;
  final int minAge;
  final int maxAge;

  FiltersPerson(
      {required this.houseID, required this.minAge, required this.maxAge});
}
