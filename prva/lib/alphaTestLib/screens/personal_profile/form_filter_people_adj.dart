import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding_resolver/geocoding_resolver.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:prva/alphaTestLib/models/filters.dart';
import 'package:prva/alphaTestLib/models/user.dart';

class FormFilterPeopleAdj extends StatefulWidget {
  const FormFilterPeopleAdj({super.key});

  @override
  State<FormFilterPeopleAdj> createState() => _FormFilterPeopleAdjState();
}

class _FormFilterPeopleAdjState extends State<FormFilterPeopleAdj> {
  final scaffoldKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  late LatLng selLocation;
  String? city;
  bool checkboxListTileValue1 = true;
  bool checkboxListTileValue2 = true;
  bool checkboxListTileValue3 = true;
  bool checkboxListTileValue4 = true;
  bool checkboxListTileValue5 = true;
  double sliderValue = 4000;
  final List<String> typeOfAppartament = [
    "Apartment",
    "Single room",
    "Double room",
    "Studio apartment",
    "Two-room apartment",
  ];
  bool flagCity = true;
  bool flagBudget = true;
  bool flagType0 = true;
  bool flagType1 = true;
  bool flagType2 = true;
  bool flagType3 = true;
  bool flagType4 = true;
  FiltersHouseAdj oldFilters = FiltersHouseAdj(
    userID: "provaUser",
    city: "Milan",
    apartment: true,
    singleRoom: true,
    doubleRoom: true,
    studioApartment: true,
    twoRoomsApartment: true,
    budget: 4000.0,
  );
  @override
  Widget build(BuildContext context) {
    final user = Utente(uid: "provaUser");

    city = initialCity(oldFilters);
    sliderValue = initialBudget(oldFilters);
    checkboxListTileValue1 = initialType0(oldFilters);
    checkboxListTileValue2 = initialType1(oldFilters);
    checkboxListTileValue3 = initialType2(oldFilters);
    checkboxListTileValue4 = initialType3(oldFilters);
    checkboxListTileValue5 = initialType4(oldFilters);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4B39EF),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Form(
            key: scaffoldKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    width: double.infinity,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: const AlignmentDirectional(0, 0),
                    child: const Text(
                      key: Key('setPreferencesText'),
                      'Set your preferences',
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        color: Color(0xFF101213),
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(
                      maxWidth: 570,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color(0x33000000),
                          offset: Offset(0, 2),
                        )
                      ],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFF1F4F8),
                        width: 2,
                      ),
                    ),
                    child: Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Pick the city',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: Color(0xFF101213),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                                key: Key('googleMapsInput'),
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, 16),
                                child: GooglePlaceAutoCompleteTextField(
                                  textEditingController: controller,
                                  googleAPIKey:
                                      "AIzaSyD8yblyesPc-09bye4ZF9KlO95G6RhhlmA",
                                  inputDecoration: InputDecoration(
                                    labelText: city,
                                    labelStyle: const TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Color(0xFF57636C),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFE0E3E7),
                                        width: 2,
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF4B39EF),
                                        width: 2,
                                      ),
                                    ),
                                    errorBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFFF5963),
                                        width: 2,
                                      ),
                                    ),
                                    focusedErrorBorder:
                                        const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFFF5963),
                                        width: 2,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.all(24),
                                  ),
                                  debounceTime: 800, // default 600 ms,
                                  countries: const [
                                    "it",
                                    "fr"
                                  ], // optional by default null is set
                                  isLatLngRequired:
                                      true, // if you required coordinates from place detail
                                  getPlaceDetailWithLatLng:
                                      (Prediction prediction) async {
                                    // this method will return latlng with place detail

                                    if (prediction.lng != null &&
                                        prediction.lat != null) {
                                      selLocation =
                                          const LatLng(45.464664, 9.188540);
                                      var address = await GeoCoder()
                                          .getAddressFromLatLng(
                                              latitude: selLocation.latitude,
                                              longitude: selLocation.longitude);
                                      //qui accedo ad address e prendo i dettagli che mi servono
                                      city = address.addressDetails.city;
                                    }
                                  }, // this callback is called when isLatLngRequired is true

                                  itemClick: (Prediction prediction) {
                                    controller.text = prediction.description!;
                                    controller.selection =
                                        TextSelection.fromPosition(TextPosition(
                                            offset: prediction
                                                .description!.length));
                                  },
                                  // if we want to make custom list item builder
                                  itemBuilder:
                                      (context, index, Prediction prediction) {
                                    return Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.location_on),
                                          const SizedBox(
                                            width: 7,
                                          ),
                                          Expanded(
                                              child: Text(
                                                  prediction.description ?? ""))
                                        ],
                                      ),
                                    );
                                  },
                                  // if you want to add seperator between list items
                                  seperatedBuilder: const Divider(),
                                  // want to show close icon
                                  isCrossBtnShown: true,
                                  // optional container padding
                                  //containerHorizontalPadding: 10,
                                )),
                            const Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Choose the type',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Color(0xFF101213),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Theme(
                                      data: ThemeData(
                                        checkboxTheme: const CheckboxThemeData(
                                          visualDensity: VisualDensity.compact,
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        unselectedWidgetColor: Colors.black,
                                      ),
                                      child: CheckboxListTile(
                                        key: Key('type0'),
                                        value: checkboxListTileValue1,
                                        onChanged: (newValue) async {
                                          setState(() =>
                                              checkboxListTileValue1 =
                                                  newValue!);
                                        },
                                        title: Text(
                                          typeOfAppartament[0],
                                          style: const TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: Color(0xFF101213),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        tileColor: Colors.white,
                                        activeColor: const Color(0xFFE0E3E7),
                                        checkColor: const Color(0xFF4B39EF),
                                        dense: false,
                                        controlAffinity:
                                            ListTileControlAffinity.trailing,
                                      ),
                                    ),
                                  ),
                                ]),
                            Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Theme(
                                      data: ThemeData(
                                        checkboxTheme: const CheckboxThemeData(
                                          visualDensity: VisualDensity.compact,
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        unselectedWidgetColor: Colors.black,
                                      ),
                                      child: CheckboxListTile(
                                        key: Key('type1'),
                                        value: checkboxListTileValue2,
                                        onChanged: (newValue) async {
                                          setState(() =>
                                              checkboxListTileValue2 =
                                                  newValue!);
                                        },
                                        title: Text(
                                          typeOfAppartament[1],
                                          style: const TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: Color(0xFF101213),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        tileColor: Colors.white,
                                        activeColor: const Color(0xFFE0E3E7),
                                        checkColor: const Color(0xFF4B39EF),
                                        dense: false,
                                        controlAffinity:
                                            ListTileControlAffinity.trailing,
                                      ),
                                    ),
                                  ),
                                ]),
                            Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Theme(
                                      data: ThemeData(
                                        checkboxTheme: const CheckboxThemeData(
                                          visualDensity: VisualDensity.compact,
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        unselectedWidgetColor: Colors.black,
                                      ),
                                      child: CheckboxListTile(
                                        key: Key('type2'),
                                        value: checkboxListTileValue3,
                                        onChanged: (newValue) async {
                                          setState(() =>
                                              checkboxListTileValue3 =
                                                  newValue!);
                                        },
                                        title: Text(
                                          typeOfAppartament[2],
                                          style: const TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: Color(0xFF101213),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        tileColor: Colors.white,
                                        activeColor: const Color(0xFFE0E3E7),
                                        checkColor: const Color(0xFF4B39EF),
                                        dense: false,
                                        controlAffinity:
                                            ListTileControlAffinity.trailing,
                                      ),
                                    ),
                                  ),
                                ]),
                            Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Theme(
                                      data: ThemeData(
                                        checkboxTheme: const CheckboxThemeData(
                                          visualDensity: VisualDensity.compact,
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        unselectedWidgetColor: Colors.black,
                                      ),
                                      child: CheckboxListTile(
                                        key: Key('type3'),
                                        value: checkboxListTileValue4,
                                        onChanged: (newValue) async {
                                          setState(() =>
                                              checkboxListTileValue4 =
                                                  newValue!);
                                        },
                                        title: Text(
                                          typeOfAppartament[3],
                                          style: const TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: Color(0xFF101213),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        tileColor: Colors.white,
                                        activeColor: const Color(0xFFE0E3E7),
                                        checkColor: const Color(0xFF4B39EF),
                                        dense: false,
                                        controlAffinity:
                                            ListTileControlAffinity.trailing,
                                      ),
                                    ),
                                  ),
                                ]),
                            Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 16),
                                      child: Theme(
                                        data: ThemeData(
                                          checkboxTheme:
                                              const CheckboxThemeData(
                                            visualDensity:
                                                VisualDensity.compact,
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                          ),
                                          unselectedWidgetColor: Colors.black,
                                        ),
                                        child: CheckboxListTile(
                                          key: Key('type4'),
                                          value: checkboxListTileValue5,
                                          onChanged: (newValue) async {
                                            setState(() =>
                                                checkboxListTileValue5 =
                                                    newValue!);
                                          },
                                          title: Text(
                                            typeOfAppartament[4],
                                            style: const TextStyle(
                                              fontFamily: 'Plus Jakarta Sans',
                                              color: Color(0xFF101213),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          tileColor: Colors.white,
                                          activeColor: const Color(0xFFE0E3E7),
                                          checkColor: const Color(0xFF4B39EF),
                                          dense: false,
                                          controlAffinity:
                                              ListTileControlAffinity.trailing,
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                            const Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Your budget is',
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Color(0xFF101213),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ]),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 16),
                                    child: SliderTheme(
                                      data: const SliderThemeData(
                                        showValueIndicator:
                                            ShowValueIndicator.always,
                                      ),
                                      child: Slider(
                                        key: Key('budgetSlider'),
                                        activeColor: const Color(0xFF4B39EF),
                                        inactiveColor: const Color.fromARGB(
                                            255, 199, 197, 197),
                                        divisions: 50,
                                        min: 0,
                                        max: 4000,
                                        value: sliderValue,
                                        label: sliderValue.toString(),
                                        onChanged: (newValue) {
                                          /*newValue = double.parse(
                                              newValue.toStringAsFixed(4));
                                          setState(
                                              () => sliderValue = newValue);*/
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: const AlignmentDirectional(1, 0),
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 16),
                                      child: Text(
                                        sliderValue.round().toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF57636C),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0, 0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, 16),
                                child: ElevatedButton(
                                  key: Key('setFiltersButton'),
                                  onPressed: () {
                                    if (scaffoldKey.currentState!.validate()) {
                                      if (checkboxListTileValue1 ||
                                          checkboxListTileValue2 ||
                                          checkboxListTileValue3 ||
                                          checkboxListTileValue4 ||
                                          checkboxListTileValue5) {
                                        updateFilters();
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            key: Key('errorMessage'),
                                            content: Text(
                                              'Please, enter at least one type!',
                                            ),
                                          ),
                                        );
                                        return;
                                      } /*
                                      if (mounted) {
                                        Navigator.pop(context);
                                      }*/
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(230, 52),
                                    backgroundColor: const Color(0xFF4B39EF),
                                    elevation: 3.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    side: const BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                  ),
                                  child: const Text(
                                    'Set your filters!',
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  initialCity(FiltersHouseAdj? oldFilters) {
    if (oldFilters != null && flagCity) {
      city = oldFilters.city;
      flagCity = false;
    }
    return city;
  }

  initialBudget(FiltersHouseAdj? oldFilters) {
    if (oldFilters != null && flagBudget) {
      sliderValue = oldFilters.budget!;
      flagBudget = false;
    }
    return sliderValue;
  }

  initialType0(FiltersHouseAdj? oldFilters) {
    if (oldFilters != null && flagType0) {
      checkboxListTileValue1 = oldFilters.apartment!;
      flagType0 = false;
    }
    return checkboxListTileValue1;
  }

  initialType1(FiltersHouseAdj? oldFilters) {
    if (oldFilters != null && flagType1) {
      checkboxListTileValue2 = oldFilters.singleRoom!;
      flagType1 = false;
    }
    return checkboxListTileValue2;
  }

  initialType2(FiltersHouseAdj? oldFilters) {
    if (oldFilters != null && flagType2) {
      checkboxListTileValue3 = oldFilters.doubleRoom!;
      flagType2 = false;
    }
    return checkboxListTileValue3;
  }

  initialType3(FiltersHouseAdj? oldFilters) {
    if (oldFilters != null && flagType3) {
      checkboxListTileValue4 = oldFilters.studioApartment!;
      flagType3 = false;
    }
    return checkboxListTileValue4;
  }

  initialType4(FiltersHouseAdj? oldFilters) {
    if (oldFilters != null && flagType4) {
      checkboxListTileValue5 = oldFilters.twoRoomsApartment!;
      flagType4 = false;
    }
    return checkboxListTileValue5;
  }

  void updateFilters(
      /*
      String city,
      bool checkboxListTileValue1,
      bool checkboxListTileValue2,
      bool checkboxListTileValue3,
      bool checkboxListTileValue4,
      bool checkboxListTileValue5,
      double sliderValue*/
      ) {
    /*oldFilters.city = city;
    oldFilters.apartment = checkboxListTileValue1;
    oldFilters.singleRoom = checkboxListTileValue2;
    oldFilters.doubleRoom = checkboxListTileValue3;
    oldFilters.studioApartment = checkboxListTileValue4;
    oldFilters.twoRoomsApartment = checkboxListTileValue5;
    oldFilters.budget = sliderValue;*/
  }
}
