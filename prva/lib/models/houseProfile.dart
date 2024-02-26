class HouseProfileAdj {
  final String type;
  final String address;
  final String city;
  final String description;
  final double price;
  final int floorNumber;
  final int numBath;
  final int numPlp;
  final int startYear;
  final int endYear;
  final int startMonth;
  final int endMonth;
  final int startDay;
  final int endDay;
  late final String imageURL1;
  final String imageURL2;
  final String imageURL3;
  final String imageURL4;
  final String idHouse;
  final String owner;
  final double latitude;
  final double longitude;
  final int numberNotifies;

  HouseProfileAdj(
      {required this.owner,
      required this.idHouse,
      required this.type,
      required this.address,
      required this.city,
      required this.description,
      required this.price,
      required this.floorNumber,
      required this.numBath,
      required this.numPlp,
      required this.startYear,
      required this.endYear,
      required this.startMonth,
      required this.endMonth,
      required this.startDay,
      required this.endDay,
      required this.latitude,
      required this.longitude,
      required this.imageURL1,
      required this.imageURL2,
      required this.imageURL3,
      required this.imageURL4,
      required this.numberNotifies});
}
