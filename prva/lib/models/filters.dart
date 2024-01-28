class Filters {
  final String userID;
  String? city;
  String? type;
  double? budget;

  Filters({required this.userID, this.city, this.type, this.budget});
}

class FiltersPerson {
  final String houseID;
  int? minAge;
  int? maxAge;

  FiltersPerson(
      {required this.houseID, this.minAge, this.maxAge});
}

  class FiltersPersonAdj{
    final String houseID;
  int? minAge;
  int? maxAge;
  String? gender;
  String? employment;

  FiltersPersonAdj(
      {required this.houseID, this.minAge, this.maxAge, this.gender, this.employment});
    
  }
