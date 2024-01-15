class Filters {
  final String userID;
  String? city;
  String? type;
  double? budget;

  Filters({required this.userID, this.city, this.type, this.budget});
}

class FiltersPerson {
  final String houseID;
  final int minAge;
  final int maxAge;

  FiltersPerson(
      {required this.houseID, required this.minAge, required this.maxAge});
}
