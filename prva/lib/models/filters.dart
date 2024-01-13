import 'package:prva/models/user.dart';

class Filters {
  final String userID;
  final String city;
  final String type;
  final int budget;

  Filters(
      {required this.userID,
      required this.city,
      required this.type,
      required this.budget});
}
