import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/filters.dart';
import 'package:prva/models/houseProfile.dart';
import 'package:prva/services/databaseFilterPerson.dart';

class FormFiltersPeopleAdj extends StatefulWidget {
  final String uidHouse;
  FormFiltersPeopleAdj({required this.uidHouse});

  @override
  State<FormFiltersPeopleAdj> createState() =>
      _FormFiltersPeopleAdjState(uidHouse: uidHouse);
}

class _FormFiltersPeopleAdjState extends State<FormFiltersPeopleAdj> {
  final String uidHouse;

  FiltersPersonAdj? filtri;

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

  _FormFiltersPeopleAdjState({required this.uidHouse});
  bool flagV = true;
  bool flagL = true;
  bool flagE = true;
  bool flagG = true;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FiltersPersonAdj>(
        stream: DatabaseServiceFiltersPerson(uid: uidHouse).getFiltersPersonAdj,
        builder: (context, snapshot) {
          FiltersPersonAdj? oldFilters = snapshot.data;
          RangeValues _currVal = computeValues(oldFilters);
          _valueGender = computeGender(oldFilters);
          _valueEmployement = computeEmployment(oldFilters);

          return Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                top: true,
                child: Align(
                  alignment: AlignmentDirectional(0, -1),
                  child: SingleChildScrollView(
                    child: Form(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            child: Container(
                              width: double.infinity,
                              height: 34,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              alignment: AlignmentDirectional(0, 0),
                              child: Text(
                                'Set your preferences',
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF101213),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(24),
                            child: Container(
                              width: double.infinity,
                              constraints: BoxConstraints(
                                maxWidth: 570,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4,
                                    color: Color(0x33000000),
                                    offset: Offset(0, 2),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Color(0xFFF1F4F8),
                                  width: 2,
                                ),
                              ),
                              child: Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 16),
                                        child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text('Choose an age range!',
                                                  style: TextStyle(
                                                    color: Color(0xFF101213),
                                                    fontSize: 16,
                                                    fontFamily:
                                                        'Plus Jakarta Sans',
                                                  )),
                                            ]),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            4, 0, 4, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 0, 16),
                                                child: RangeSlider(
                                                  activeColor:
                                                      Color(0xFF4B39EF),
                                                  min:
                                                      1.0, // il valore minimo che si può selezionare
                                                  max:
                                                      100.0, // il valore massimo che si può selezionare
                                                  divisions:
                                                      99, // il numero di divisioni del tracciato
                                                  labels: RangeLabels(
                                                    _currVal.start
                                                        .round()
                                                        .toString(),
                                                    _currVal.end
                                                        .round()
                                                        .toString(),
                                                  ),

                                                  values: _currVal,
                                                  onChanged: (values) {
                                                    // la funzione che viene chiamata quando si cambia lo slider
                                                    setState(() {
                                                      // per aggiornare l'interfaccia grafica
                                                      _startValue = values
                                                          .start; // assegna il nuovo valore iniziale
                                                      _endValue = values
                                                          .end; // assegna il nuovo valore finale
                                                    });
                                                  },
                                                  onChangeEnd: (values) {
                                                    setState(() {
                                                      // per aggiornare l'interfaccia grafica
                                                      _currVal = RangeValues(
                                                          values.start,
                                                          values.end);
                                                    });
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
                                                  AlignmentDirectional(1, 0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 0, 16),
                                                child: Text(
                                                    '${_startValue.round()}-${_endValue.round()}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Color(0xFF101213),
                                                      fontSize: 12,
                                                      fontFamily:
                                                          'Plus Jakarta Sans',
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
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 16),
                                              child: Text('I prefer ...',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xFF101213),
                                                    fontSize: 16,
                                                    fontFamily:
                                                        'Plus Jakarta Sans',
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
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 0, 16),
                                                child: Wrap(
                                                  alignment:
                                                      WrapAlignment.spaceEvenly,
                                                  children:
                                                      List<Widget>.generate(
                                                    3,
                                                    (int index) {
                                                      return ChoiceChip(
                                                        backgroundColor:
                                                            Colors.grey,
                                                        label: Text(
                                                            optionsGender[
                                                                index]),
                                                        labelStyle: TextStyle(
                                                            fontFamily:
                                                                'Readex Pro',
                                                            color:
                                                                Colors.white),
                                                        selected:
                                                            _valueGender ==
                                                                index,
                                                        selectedColor:
                                                            Color(0xFF4B39EF),
                                                        showCheckmark: false,
                                                        iconTheme:
                                                            IconThemeData(
                                                          color: const Color
                                                              .fromARGB(
                                                              255, 62, 60, 60),
                                                          size: 18,
                                                        ),
                                                        onSelected:
                                                            (bool selected) {
                                                          setState(() {
                                                            _valueGender =
                                                                selected
                                                                    ? index
                                                                    : 2;
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
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 0, 16),
                                                child: Wrap(
                                                  alignment:
                                                      WrapAlignment.spaceEvenly,
                                                  children:
                                                      List<Widget>.generate(
                                                    3,
                                                    (int index) {
                                                      return ChoiceChip(
                                                        label: Text(
                                                            optionsEmployement[
                                                                index]),
                                                        labelStyle: TextStyle(
                                                            fontFamily:
                                                                'Readex Pro',
                                                            color:
                                                                Colors.white),
                                                        selected:
                                                            _valueEmployement ==
                                                                index,
                                                        selectedColor:
                                                            Color(0xFF4B39EF),
                                                        showCheckmark: false,
                                                        backgroundColor:
                                                            Colors.grey,
                                                        iconTheme:
                                                            IconThemeData(
                                                          size: 18,
                                                        ),
                                                        onSelected:
                                                            (bool selected) {
                                                          setState(() {
                                                            _valueEmployement =
                                                                selected
                                                                    ? index
                                                                    : 2;
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
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 16),
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              await DatabaseServiceFiltersPerson(
                                                      uid: uidHouse)
                                                  .updateFiltersPersonAj(
                                                      _startValue.round() ??
                                                          filtri!.minAge,
                                                      _endValue.round() ??
                                                          filtri!.maxAge,
                                                      getGenderString(
                                                              _valueGender!) ??
                                                          filtri!.gender,
                                                      getEmploymentString(
                                                              _valueEmployement!) ??
                                                          filtri!.employment);
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Set filters',
                                              style: TextStyle(
                                                fontFamily: 'Plus Jakarta Sans',
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              fixedSize: Size(230, 52),
                                              backgroundColor: Colors.black,
                                              elevation: 3.0,
                                              side: BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
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
        });
  }

  computeValues(FiltersPersonAdj? oldFilters) {
    if (oldFilters != null && flagV) {
      _startValue = oldFilters.minAge!.toDouble();
      _endValue = oldFilters.maxAge!.toDouble();
      flagV = false;
      //return RangeValues( oldFilters!.minAge!.toDouble(), oldFilters!.maxAge!.toDouble());
    }
    return RangeValues(_startValue, _endValue);
  }

  computeLabels(FiltersPersonAdj? oldFilters) {
    if (oldFilters != null && flagL) {
      _startValue = oldFilters.minAge!.toDouble();
      _endValue = oldFilters.maxAge!.toDouble();
      flagL = false;
      //return RangeLabels(oldFilters!.minAge!.round().toString(),oldFilters!.maxAge!.round().toString());
    }
    return RangeLabels(
        _startValue.round().toString(), _endValue.round().toString());
  }

  int? computeEmployment(FiltersPersonAdj? oldFilters) {
    if (oldFilters != null && flagE) {
      _valueEmployement = getEmploymentIndex(oldFilters!.employment!);
      flagE = false;
    }
    return _valueEmployement;
  }

  int? computeGender(FiltersPersonAdj? oldFilters) {
    if (oldFilters != null && flagG) {
      _valueGender = getGenderIndex(oldFilters!.gender!);
      flagG = false;
    }
    return _valueGender;
  }
}
