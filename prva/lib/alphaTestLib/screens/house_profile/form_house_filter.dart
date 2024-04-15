import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prva/models/filters.dart';
import 'package:prva/screens/shared/constant.dart';
import 'package:prva/services/databaseFilterPerson.dart';

class FormHouseFilter extends StatefulWidget {
  final String uidHouse;
  const FormHouseFilter({super.key, required this.uidHouse});

  @override
  State<FormHouseFilter> createState() =>
      _FormHouseFilterState(uidHouse: uidHouse);
}

class _FormHouseFilterState extends State<FormHouseFilter> {
  final String uidHouse;

  FiltersPersonAdj oldFilters = FiltersPersonAdj(
      houseID: 'houseID',
      minAge: 18,
      maxAge: 50,
      gender: "male",
      employment: "student");

  double _startValue = 1.0;
  double _endValue = 100.0;

  int? _valueGender = 2;
  int? _valueEmployement = 2;
  List<String> optionsGender = ['male', 'female', 'not relevant'];
  List<String> optionsEmployement = ['student', 'worker', 'not relevant'];

  int getGenderIndex(String genderString) {
    if (genderString == "male") {
      return 0;
    } else if (genderString == "female") {
      return 1;
    } else {
      return 2;
    }
  }

  String getGenderString(int genderNumber) {
    if (genderNumber == 0) {
      return "male";
    } else if (genderNumber == 1) {
      return "female";
    } else {
      return "not relevant";
    }
  }

  int getEmploymentIndex(String employmentString) {
    if (employmentString == "student") {
      return 0;
    } else if (employmentString == "worker") {
      return 1;
    } else {
      return 2;
    }
  }

  String getEmploymentString(int employmentNumber) {
    if (employmentNumber == 0) {
      return "student";
    } else if (employmentNumber == 1) {
      return "worker";
    } else {
      return "not relevant";
    }
  }

  _FormHouseFilterState({required this.uidHouse});
  bool flagV = true;
  bool flagL = true;
  bool flagE = true;
  bool flagG = true;

  @override
  Widget build(BuildContext context) {
    RangeValues currVal = computeValues(oldFilters);
    _valueGender = computeGender(oldFilters);
    _valueEmployement = computeEmployment(oldFilters);
    computeLabels(oldFilters);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          title: Text(
            key: Key('setPreferencesText'),
            'Set your preferences',
            style: GoogleFonts.plusJakartaSans(
              color: backgroundColor,
              fontSize: size24(context),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        backgroundColor: backgroundColor,
        body: SafeArea(
          top: true,
          child: Align(
            alignment: const AlignmentDirectional(0, -1),
            child: SingleChildScrollView(
              key: Key('scrollable'),
              child: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Container(
                        width: double.infinity,
                        constraints: const BoxConstraints(
                          maxWidth: 570,
                        ),
                        decoration: BoxDecoration(
                          color: backgroundColor,
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
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 16),
                                  child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Choose an age range!',
                                            style: GoogleFonts.plusJakartaSans(
                                              color: const Color(0xFF101213),
                                              fontSize: size16(context),
                                            )),
                                      ]),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      4, 0, 4, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 0, 0, 16),
                                          child: RangeSlider(
                                            key: Key('slider'),
                                            activeColor: mainColor,
                                            min:
                                                1.0, // il valore minimo che si può selezionare
                                            max:
                                                100.0, // il valore massimo che si può selezionare
                                            divisions:
                                                99, // il numero di divisioni del tracciato
                                            labels: RangeLabels(
                                              currVal.start.round().toString(),
                                              currVal.end.round().toString(),
                                            ),

                                            values: currVal,
                                            onChanged: (values) {
                                              /*
                                              // la funzione che viene chiamata quando si cambia lo slider
                                              setState(() {
                                                // per aggiornare l'interfaccia grafica
                                                _startValue = values
                                                    .start; // assegna il nuovo valore iniziale
                                                _endValue = values
                                                    .end; // assegna il nuovo valore finale
                                              });*/
                                            },
                                            onChangeEnd: (values) {
                                              /*
                                              setState(() {
                                                // per aggiornare l'interfaccia grafica
                                                currVal = RangeValues(
                                                    values.start, values.end);
                                              });*/
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment:
                                            const AlignmentDirectional(1, 0),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 0, 0, 16),
                                          child: Text(
                                              '${_startValue.round()}-${_endValue.round()}',
                                              textAlign: TextAlign.center,
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                color: const Color(0xFF101213),
                                                fontSize: size12(context),
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, 16),
                                        child: Text(
                                            key: Key('gender/employmentFields'),
                                            'I prefer ...',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.plusJakartaSans(
                                              color: const Color(0xFF101213),
                                              fontSize: size16(context),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 0, 0, 16),
                                          child: Wrap(
                                            alignment:
                                                WrapAlignment.spaceEvenly,
                                            children: List<Widget>.generate(
                                              3,
                                              (int index) {
                                                return ChoiceChip(
                                                  backgroundColor: Colors.grey,
                                                  label: Text(
                                                      optionsGender[index]),
                                                  labelStyle:
                                                      GoogleFonts.readexPro(
                                                          color: Colors.white,
                                                          fontSize:
                                                              size12(context)),
                                                  selected:
                                                      _valueGender == index,
                                                  selectedColor: mainColor,
                                                  showCheckmark: false,
                                                  iconTheme: IconThemeData(
                                                    color: const Color.fromARGB(
                                                        255, 62, 60, 60),
                                                    size: size18(context),
                                                  ),
                                                  onSelected: (bool selected) {
                                                    setState(() {
                                                      _valueGender =
                                                          selected ? index : 2;
                                                    });
                                                  },
                                                );
                                              },
                                            ).toList(),
                                          )),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 0, 0, 16),
                                          child: Wrap(
                                            alignment:
                                                WrapAlignment.spaceEvenly,
                                            children: List<Widget>.generate(
                                              3,
                                              (int index) {
                                                return ChoiceChip(
                                                  label: Text(
                                                      optionsEmployement[
                                                          index]),
                                                  labelStyle:
                                                      GoogleFonts.readexPro(
                                                          color: Colors.white,
                                                          fontSize:
                                                              size12(context)),
                                                  selected: _valueEmployement ==
                                                      index,
                                                  selectedColor: mainColor,
                                                  showCheckmark: false,
                                                  backgroundColor: Colors.grey,
                                                  iconTheme: IconThemeData(
                                                    color: const Color.fromARGB(
                                                        255, 62, 60, 60),
                                                    size: size18(context),
                                                  ),
                                                  onSelected: (bool selected) {
                                                    setState(() {
                                                      _valueEmployement =
                                                          selected ? index : 2;
                                                    });
                                                  },
                                                );
                                              },
                                            ).toList(),
                                          )),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: const AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 16),
                                    child: ElevatedButton(
                                      key: Key('updateButton'),
                                      onPressed: () async {
                                        /*
                                        await DatabaseServiceFiltersPerson(
                                                uid: uidHouse)
                                            .updateFiltersPersonAj(
                                                _startValue.round(),
                                                _endValue.round(),
                                                getGenderString(_valueGender!),
                                                getEmploymentString(
                                                    _valueEmployement!));*/
                                        if (mounted) {
                                          Navigator.pop(context);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        fixedSize: const Size(230, 52),
                                        backgroundColor: mainColor,
                                        elevation: 3.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        side: const BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                      ),
                                      child: Text(
                                        'Set your filters!',
                                        style: GoogleFonts.plusJakartaSans(
                                          color: backgroundColor,
                                          fontSize: size16(context),
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
        ));
  }

  computeValues(FiltersPersonAdj? oldFilters) {
    if (oldFilters != null && flagV) {
      _startValue = oldFilters.minAge!.toDouble();
      _endValue = oldFilters.maxAge!.toDouble();
      flagV = false;
    }
    return RangeValues(_startValue, _endValue);
  }

  computeLabels(FiltersPersonAdj? oldFilters) {
    if (oldFilters != null && flagL) {
      _startValue = oldFilters.minAge!.toDouble();
      _endValue = oldFilters.maxAge!.toDouble();
      flagL = false;
    }
    return RangeLabels(
        _startValue.round().toString(), _endValue.round().toString());
  }

  int? computeEmployment(FiltersPersonAdj? oldFilters) {
    if (oldFilters != null && flagE) {
      _valueEmployement = getEmploymentIndex(oldFilters.employment!);
      flagE = false;
    }
    return _valueEmployement;
  }

  int? computeGender(FiltersPersonAdj? oldFilters) {
    if (oldFilters != null && flagG) {
      _valueGender = getGenderIndex(oldFilters.gender!);
      flagG = false;
    }
    return _valueGender;
  }
}
