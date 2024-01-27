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
  final String description;
  final DateTime birthDate; 
  final String gender;
  final String employment;
  final List<String> imageURLs;

  PersonalProfileAdj({required this.uidA, required this.nameA, required this.surnameA, required this.description, required this.birthDate, required this.gender, required this.employment, required this.imageURLs});

}
