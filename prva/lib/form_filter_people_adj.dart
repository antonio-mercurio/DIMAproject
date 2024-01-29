
import 'package:flutter/material.dart';

class FormFilterPeopleAdj extends StatefulWidget {
  const FormFilterPeopleAdj({super.key});

  @override
  State<FormFilterPeopleAdj> createState() => _FormFilterPeopleAdjState();
}

class _FormFilterPeopleAdjState extends State<FormFilterPeopleAdj> {
 

  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool? checkboxListTileValue1;
  bool? checkboxListTileValue2;
  bool? checkboxListTileValue3;
  bool? checkboxListTileValue4;
  bool? checkboxListTileValue5;
  double? sliderValue;
  final List<String> typeOfAppartament = [
    "Apartment",
    "Single room",
    "Double room",
    "Studio apartment",
    "Two-room apartment",
  ];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child:  SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 32),
                        child: Container(
                          width: double.infinity,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          alignment: AlignmentDirectional(0, 0),
                          child: Text(
                            'Set your preferences',
                            style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF101213),
                                  fontSize: 36,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12),
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
                              padding: EdgeInsets.all(24),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 16),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 16),
                                  child: Container(
                                    width: double.infinity,
                                    child: TextFormField(
                                      autofocus: true,
                                      autofillHints: [AutofillHints.email],
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'City',
                                        labelStyle: const TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF57636C),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xFFE0E3E7),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xFF4B39EF),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xFFFF5963),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xFFFF5963),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: const EdgeInsets.all(24),
                                      ),
                                      style: const TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: Color(0xFF101213),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      ),
                                    ),
                                  ),
                                  Row(
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
                                            checkboxTheme: CheckboxThemeData(
                                              visualDensity:
                                                  VisualDensity.compact,
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                            ),
                                            unselectedWidgetColor:
                                                Colors.black,
                                          ),
                                          child: CheckboxListTile(
                                            value: checkboxListTileValue1 ??=
                                                false,
                                            onChanged: (newValue) async {
                                              setState(() => checkboxListTileValue1 =
                                                  newValue!);
                                            },
                                            title: Text(
                                              typeOfAppartament[0],
                                              style:
                                                  TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF101213),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                            ),
                                            tileColor:
                                                Colors.white,
                                            activeColor:
                                                 Color(0xFFE0E3E7),
                                            checkColor:
                                               Color(0xFF4B39EF),
                                            dense: false,
                                            controlAffinity:
                                                ListTileControlAffinity
                                                    .trailing,
                                          ),
                                        ),
                                      ),
                                    ]
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Theme(
                                          data: ThemeData(
                                            checkboxTheme: CheckboxThemeData(
                                              visualDensity:
                                                  VisualDensity.compact,
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                            ),
                                            unselectedWidgetColor:
                                                Colors.black,
                                          ),
                                          child: CheckboxListTile(
                                            value: checkboxListTileValue2 ??=
                                                false,
                                            onChanged: (newValue) async {
                                              setState(() => checkboxListTileValue2 =
                                                  newValue!);
                                            },
                                            title: Text(
                                              typeOfAppartament[1],
                                              style:
                                                  TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF101213),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                            ),
                                            tileColor:
                                                Colors.white,
                                            activeColor:
                                                 Color(0xFFE0E3E7),
                                            checkColor:
                                               Color(0xFF4B39EF),
                                            dense: false,
                                            controlAffinity:
                                                ListTileControlAffinity
                                                    .trailing,
                                          ),
                                        ),
                                      ),
                                    ]
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Theme(
                                          data: ThemeData(
                                            checkboxTheme: CheckboxThemeData(
                                              visualDensity:
                                                  VisualDensity.compact,
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                            ),
                                            unselectedWidgetColor:
                                                Colors.black,
                                          ),
                                          child: CheckboxListTile(
                                            value: checkboxListTileValue3 ??=
                                                false,
                                            onChanged: (newValue) async {
                                              setState(() => checkboxListTileValue3=
                                                  newValue!);
                                            },
                                            title: Text(
                                              typeOfAppartament[2],
                                              style:
                                                  TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF101213),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                            ),
                                            tileColor:
                                                Colors.white,
                                            activeColor:
                                                 Color(0xFFE0E3E7),
                                            checkColor:
                                               Color(0xFF4B39EF),
                                            dense: false,
                                            controlAffinity:
                                                ListTileControlAffinity
                                                    .trailing,
                                          ),
                                        ),
                                      ),
                                    ]
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Theme(
                                          data: ThemeData(
                                            checkboxTheme: CheckboxThemeData(
                                              visualDensity:
                                                  VisualDensity.compact,
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                            ),
                                            unselectedWidgetColor:
                                                Colors.black,
                                          ),
                                          child: CheckboxListTile(
                                            value: checkboxListTileValue4 ??=
                                                false,
                                            onChanged: (newValue) async {
                                              setState(() => checkboxListTileValue4 =
                                                  newValue!);
                                            },
                                            title: Text(
                                              typeOfAppartament[3],
                                              style:
                                                  TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF101213),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                            ),
                                            tileColor:
                                                Colors.white,
                                            activeColor:
                                                 Colors.white,
                                            checkColor:
                                               Color(0xFF4B39EF),
                                            dense: false,
                                            controlAffinity:
                                                ListTileControlAffinity
                                                    .trailing,
                                          ),
                                        ),
                                      ),
                                    ]
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 16),
                                        child: Theme(
                                          data: ThemeData(
                                            checkboxTheme: CheckboxThemeData(
                                              visualDensity:
                                                  VisualDensity.compact,
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                            ),
                                            unselectedWidgetColor:
                                                Colors.black,
                                          ),
                                          child: CheckboxListTile(
                                            value: checkboxListTileValue5 ??=
                                                false,
                                            onChanged: (newValue) async {
                                              setState(() => checkboxListTileValue5 =
                                                  newValue!);
                                            },
                                            title: Text(
                                              typeOfAppartament[4],
                                              style:
                                                  TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF101213),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                            ),
                                            tileColor:
                                                Colors.white,
                                            activeColor:
                                                 Color(0xFFE0E3E7),
                                            checkColor:
                                               Color(0xFF4B39EF),
                                            dense: false,
                                            controlAffinity:
                                                ListTileControlAffinity
                                                    .trailing,
                                          ),
                                        ),
                                      ),
                                      ),
                                    ]
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Your budget is',
                                        style: 
                                                  TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF101213),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ]
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 16),
                                          child: SliderTheme(
                                            data: SliderThemeData(
                                              showValueIndicator:
                                                  ShowValueIndicator.always,
                                            ),
                                            child: Slider(
                                              activeColor:
                                                  Color(0xFF4B39EF),
                                              inactiveColor:
                                                   const Color.fromARGB(255, 199, 197, 197),
                                              divisions: 50,
                                              min: 0,
                                              max: 4000,
                                              value: sliderValue ??= 50,
                                              label:
                                                  sliderValue.toString(),
                                              onChanged: (newValue) {
                                                newValue = double.parse(newValue
                                                    .toStringAsFixed(4));
                                                setState(() => sliderValue = newValue);
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
                                          alignment: AlignmentDirectional(1, 0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 16),
                                            child: Text(
                                              sliderValue?.round().toString() ?? '50',
                                              textAlign: TextAlign.center,
                                              style:
                                                  TextStyle(
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
              );
  }
}
