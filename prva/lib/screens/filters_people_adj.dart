import 'package:flutter/material.dart';
import 'package:prva/models/houseProfile.dart';



/*
RangeSlider(
  min: 0.0, // il valore minimo che si può selezionare
  max: 100.0, // il valore massimo che si può selezionare
  divisions: 10, // il numero di divisioni del tracciato
  labels: RangeLabels( // le etichette che mostrano i valori selezionati
    _startValue.round().toString(), // il valore iniziale
    _endValue.round().toString(), // il valore finale
  ),
  values: RangeValues( // i valori selezionati dallo slider
    _startValue, // il valore iniziale
    _endValue, // il valore finale
  ),
  onChanged: (values) { // la funzione che viene chiamata quando si cambia lo slider
    setState(() { // per aggiornare l'interfaccia grafica
      _startValue = values.start; // assegna il nuovo valore iniziale
      _endValue = values.end; // assegna il nuovo valore finale
    });
  },
)*/





class FormFiltersPeopleAdj extends StatefulWidget {

  final String uidHouse;

  const FormFiltersPeopleAdj({super.key, required this.uidHouse});
  

  @override
  State<FormFiltersPeopleAdj> createState() => _FormFiltersPeopleAdjState();
}

class _FormFiltersPeopleAdjState extends State<FormFiltersPeopleAdj> {
  double _startValue=1.0;
  double _endValue=100.0;

  int? _valueGender = 2;
  int? _valueEmployement = 2;
  List<String> optionsGender = ['male', 'female', 'not relevant'];
  List<String> optionsEmployement = ['student', 'worker', 'not relevant'];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: AlignmentDirectional(0, -1),
                child: SingleChildScrollView(
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
                            style:TextStyle(
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
                                        Text(
                                          'Choose an age range!',
                                          style: TextStyle(
                                            color: Color(0xFF101213),
                                              fontSize: 16,
                                                fontFamily: 'Plus Jakarta Sans',
                                              )),
                                      ]
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 16),
                                            child: RangeSlider(
                                              activeColor:  Color(0xFF4B39EF),
  min: 0.0, // il valore minimo che si può selezionare
  max: 100.0, // il valore massimo che si può selezionare
  divisions: 100, // il numero di divisioni del tracciato
  labels: RangeLabels( // le etichette che mostrano i valori selezionati
    _startValue.round().toString(), // il valore iniziale
    _endValue.round().toString(), // il valore finale
  ),
  values: RangeValues( // i valori selezionati dallo slider
    _startValue, // il valore iniziale
    _endValue, // il valore finale
  ),
  onChanged: (values) { // la funzione che viene chiamata quando si cambia lo slider
    setState(() { // per aggiornare l'interfaccia grafica
      _startValue = values.start; // assegna il nuovo valore iniziale
      _endValue = values.end; // assegna il nuovo valore finale
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
        alignment: AlignmentDirectional(1, 0),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
          child: Text( '${_startValue.toInt()}-${_endValue.toInt()}',
            textAlign: TextAlign.center,
            style: TextStyle(
                                            color: Color(0xFF101213),
                                              fontSize: 12,
                                                fontFamily: 'Plus Jakarta Sans',
                                              )
          ),
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
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 16),
                                          child: Text(
                                            'I prefer ...',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                            color: Color(0xFF101213),
                                              fontSize: 16,
                                                fontFamily: 'Plus Jakarta Sans',
                                              )
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
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 16),
                                          child: Wrap(
              alignment: WrapAlignment.spaceEvenly , 
              children: List<Widget>.generate(
                                        3,
                                     (int index) {
                                    return ChoiceChip(
                                    backgroundColor: Colors.grey,
                                    label: Text(optionsGender[index]),
                                    labelStyle: TextStyle(fontFamily: 'Readex Pro',
                                    color: Colors.white) ,
                                    selected: _valueGender == index,
                                    selectedColor: Color(0xFF4B39EF),
                                    showCheckmark: false,
                                    iconTheme: IconThemeData(color: const Color.fromARGB(255, 62, 60, 60),
                                     size: 18,    
                                    ),
                                    onSelected: (bool selected) {
                                    setState(() {
                                    _valueGender = selected ? index : null;
                                    });
                                    },
                                    );
                                    },
                                   ).toList(),
                                                  ) 
                                        ),
                                      ),
                                    ],
                                  ),
                                 Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 16),
                                          child: Wrap(
              alignment: WrapAlignment.spaceEvenly , 
              children: List<Widget>.generate(
                                        3,
                                     (int index) {
                                    return ChoiceChip(
                                    label: Text(optionsEmployement[index]),
                                    labelStyle: TextStyle(fontFamily: 'Readex Pro',
                                    color: Colors.white) ,
                                    selected: _valueEmployement == index,
                                    selectedColor: Color(0xFF4B39EF),
                                    showCheckmark: false,
                                    backgroundColor: Colors.grey,
                                    iconTheme: IconThemeData(
                                     size: 18,    
                                    ),
                                    onSelected: (bool selected) {
                                    setState(() {
                                    _valueEmployement = selected ? index : null;
                                    });
                                    },
                                    );
                                    },
                                   ).toList(),
                                                  ) 
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
            ],
          ),
        ),
      );
  }
}
