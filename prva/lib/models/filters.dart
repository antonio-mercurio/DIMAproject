class Filters {
  final String userID;
  String? city;
  String? type;
  double? budget;

  Filters({required this.userID, this.city, this.type, this.budget});
}

class FiltersHouseAdj {
  final String userID;
  String? city;
  bool? apartment;
  bool? singleRoom;
  bool? doubleRoom;
  bool? studioApartment;
  bool? twoRoomsApartment;
  double? budget;


  FiltersHouseAdj({required this.userID, this.city, this.apartment, this.singleRoom, this.doubleRoom, this.studioApartment, this.twoRoomsApartment, this.budget});
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
