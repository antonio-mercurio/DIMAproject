import 'dart:ffi';

class PersonalProfile {
  final String uid;
  final String name;
  final String surname;
  final int age;

  PersonalProfile(
      {required this.uid,
      required this.name,
      required this.surname,
      required this.age});
}

class PersonalProfileAdj {
  final String uidA;
  final String nameA;
  final String surnameA;
  final int day;
  final int month;
  final int year;
  final String description;
  final String gender;
  final String employment;
  final String imageURL1;
  final String imageURL2;
  final String imageURL3;
  final String imageURL4;


  PersonalProfileAdj({required this.day, required this.month, required this.year, required this.uidA, required this.nameA, 
  required this.surnameA, required this.description, required this.gender, required this.employment, required this.imageURL1,
  required this.imageURL2,required this.imageURL3,required this.imageURL4 });

}
