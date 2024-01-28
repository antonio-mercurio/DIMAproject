import 'package:flutter/material.dart';
import 'package:prva/models/filters.dart';
import 'package:prva/models/houseProfile.dart';
import 'package:prva/services/databaseFilterPerson.dart';



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
  State<FormFiltersPeopleAdj> createState() => _FormFiltersPeopleAdjState(uidHouse: uidHouse);
}

class _FormFiltersPeopleAdjState extends State<FormFiltersPeopleAdj> {
  final String uidHouse;
  FiltersPersonAdj? filtri;
  int? _genderValue =2;
  int? _employmentValue =2;

  List<String> optionsGender = ['male', 'female', 'not relevant'];
  List<String> optionsEmployement = ['student', 'worker', 'not relevant'];

  int getGenderIndex(String genderString){
    if(genderString== "male"){
      return 0;
    }else if(genderString== "female"){
      return 1;
    }else{
      return 2;
    }
  }

  String getGenderString(int genderNumber){
     if(genderNumber==0 ){
      return "male";
    }else if(genderNumber== 1){
      return "female";
    }else{
      return "not relevant";
    }

  }


  int getEmploymentIndex(String employmentString){
    if(employmentString== "student"){
      return 0;
    }else if(employmentString== "worker"){
      return 1;
    }else{
      return 2;
    }
  }


   String getEmploymentString(int employmentNumber){
     if(employmentNumber==0 ){
      return "student";
    }else if(employmentNumber== 1){
      return "worker";
    }else{
      return "not relevant";
    }

  }

  _FormFiltersPeopleAdjState({required this.uidHouse});

  @override
  Widget build(BuildContext context) {
    
    try {
      final retrievedFilters =
          DatabaseServiceFiltersPerson(uid:uidHouse).getFiltersPersonAdj;
      retrievedFilters.listen((content) {
        filtri = FiltersPersonAdj(
            houseID: content.houseID,
            minAge: content.minAge,
            maxAge: content.maxAge,
            gender: content.gender,
            employment: content.employment);
        if (this.mounted){
      
        }
      });
    }catch(e){
      filtri= FiltersPersonAdj(
        houseID: uidHouse,
        minAge:  1,
        maxAge: 100,
        gender: "not relevant",
        employment: "not relevant");
    }

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
  min: 1.0, // il valore minimo che si può selezionare
  max: 100.0, // il valore massimo che si può selezionare
  divisions: 100, // il numero di divisioni del tracciato
  labels: RangeLabels( // le etichette che mostrano i valori selezionati
    filtri!.minAge.toString(), // il valore iniziale
    filtri!.maxAge.toString(), // il valore finale
  ),
  values: RangeValues( // i valori selezionati dallo slider
    filtri!.minAge as double, // il valore iniziale
     filtri!.maxAge as double, // il valore finale
  ),
  onChanged: (values) { // la funzione che viene chiamata quando si cambia lo slider
    setState(() { // per aggiornare l'interfaccia grafica
      filtri!.minAge = values.start as int; // assegna il nuovo valore iniziale
      filtri!.maxAge  = values.end as int; // assegna il nuovo valore finale
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
          child: Text( '${filtri!.minAge}-${filtri!.maxAge}',
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
                                    selected: getGenderIndex(filtri!.gender!) == index,
                                    selectedColor: Color(0xFF4B39EF),
                                    showCheckmark: false,
                                    iconTheme: IconThemeData(color: const Color.fromARGB(255, 62, 60, 60),
                                     size: 18,    
                                    ),
                                    onSelected: (bool selected) {
                                    setState(() {
                                     _genderValue = selected ? index : 2;
                                     filtri!.gender = getGenderString(_genderValue!);
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
                                    selected: getEmploymentIndex(filtri!.employment!) == index,
                                    selectedColor: Color(0xFF4B39EF),
                                    showCheckmark: false,
                                    backgroundColor: Colors.grey,
                                    iconTheme: IconThemeData(
                                     size: 18,    
                                    ),
                                    onSelected: (bool selected) {
                                    setState(() {
                                    _employmentValue= selected ? index : 2;
                                    filtri!.employment== getEmploymentString(_employmentValue!);
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
                                
                                Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 16),
                                  child:  ElevatedButton(
                                  onPressed: () async {
                        await DatabaseServiceFiltersPerson(uid: uidHouse)
                            .updateFiltersPersonAj(
                          filtri!.minAge,
                          filtri!.maxAge,
                          filtri!.gender,
                          filtri!.employment
                        );
                      Navigator.pop(context);
                    },
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: Size(230, 52),
                                      backgroundColor:Colors.black,
                                       elevation: 3.0,
                                       side: const BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                    ),
                                    child : const Text('Set filters',
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                    ),),
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
            ],
          ),
        ),
      );
  }
}
