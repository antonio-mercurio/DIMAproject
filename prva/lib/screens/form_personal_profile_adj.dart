
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // for date formatting

class FormPersonalProfileAdj extends StatefulWidget {
  const FormPersonalProfileAdj({Key? key}) : super(key: key);

  @override
 State<FormPersonalProfileAdj> createState() => _FormPersonalProfileAdjState();
}

class _FormPersonalProfileAdjState extends State<FormPersonalProfileAdj> {
  int? _valueGender = 1;
  int? _valueEmployement = 1;
  List<String> optionsGender = ['male', 'female', 'other'];
  List<String> optionsEmployement = ['student', 'worker'];
  String? _name;
  String? _surname;
  String? _description;
  DateTime? _birthDate;
  // controller for the textfield
  TextEditingController _dateController = TextEditingController();

   void _selectDate(BuildContext context) async {
    // get the initial date
    DateTime initialDate = _birthDate ?? DateTime.now();

    // show the date picker and wait for the result
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    // if the user picked a date, update the state
    if (pickedDate != null && pickedDate != _birthDate) {
      setState(() {
        // set the selected date
        _birthDate = pickedDate;

        // format the date as dd/mm/yyyy
        String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);

        // update the textfield controller
        _dateController.text = formattedDate;
      });
    }
  }
  
  final scaffoldKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                backgroundColor: Colors.black,
                elevation: 0.0,
                title: const Text('Affinder',
                 textAlign: TextAlign.start,
                                style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    ),),
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0, -1),
            child: SingleChildScrollView(
              child: Form(
                        key: scaffoldKey,
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
                            'Create your profile',
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
                                        0, 12, 0, 24),
                                    child: Text(
                                      'Start with you personal data',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: Color(0xFF57636C),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 16),
                                    child: Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                        autofocus: true,
                                        autofillHints: [AutofillHints.name],
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Name',
                                          labelStyle:
                                              TextStyle(
                                                    fontFamily:
                                                        'Plus Jakarta Sans',
                                                    color: Color(0xFF57636C),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                          hintText: 'Name',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFE0E3E7),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF4B39EF),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFFF5963),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFFF5963),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding: EdgeInsets.all(24),
                                        ),
                                        style: TextStyle(
                                              fontFamily: 'Plus Jakarta Sans',
                                              color: Color(0xFF101213),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                       validator:(val) =>
                                        val!.isEmpty ? 'Please enter a name' : null,
                                      onChanged: (val) => setState(() => _name = val),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 16),
                                    child: Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                        autofocus: true,
                                        autofillHints: [AutofillHints.name],
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Surname',
                                          labelStyle:
                                              TextStyle(
                                                    fontFamily:
                                                        'Plus Jakarta Sans',
                                                    color: Color(0xFF57636C),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                          hintText: 'Surname',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFE0E3E7),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF4B39EF),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFFF5963),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFFF5963),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding: EdgeInsets.all(24),
                                        ),
                                        style: TextStyle(
                                              fontFamily: 'Plus Jakarta Sans',
                                              color: Color(0xFF101213),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                        validator: (val) =>
                                        val!.isEmpty ? 'Please enter a surname' : null,
                                      onChanged: (val) => setState(() => _surname = val),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 16),
                                    child: Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                        controller: _dateController,
                                        readOnly: true, 
                                        autofocus: true,
                                        autofillHints: [AutofillHints.birthday],
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () {
                      // call the function to show the date picker
                      _selectDate(context);
                    },
                  ),
                                          labelText: 'Birth Date',
                                          labelStyle:
                                              TextStyle(
                                                    fontFamily:
                                                        'Plus Jakarta Sans',
                                                    color: Color(0xFF57636C),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                          hintText: 'Bitrth Date',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFE0E3E7),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF4B39EF),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFFF5963),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFFF5963),
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding: EdgeInsets.all(24),
                                        ),
                                        style:TextStyle(
                                              fontFamily: 'Plus Jakarta Sans',
                                              color: Color(0xFF101213),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                        validator:(val) =>
                                        val!.isEmpty ? 'Please enter a date' : null ,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 16),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Your gender:',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFF101213),
                                              fontSize: 16,
                                                fontFamily: 'Plus Jakarta Sans',
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 16),
                                                  child: 
                                                  Wrap(
              alignment: WrapAlignment.spaceEvenly , 
              children: List<Widget>.generate(
                                        3,
                                     (int index) {
                                    return ChoiceChip(
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
                                ],
                              ),
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
              padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 24),
              child: Text(
                'Something about you',
                textAlign: TextAlign.start,
                style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Color(0xFF57636C),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Employment:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                        ),
                  ),
                ],
              ),
            ),
            Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 16),
                                                  child: 
                                                  Wrap(
              alignment: WrapAlignment.spaceEvenly , 
              children: List<Widget>.generate(
                                        2,
                                     (int index) {
                                    return ChoiceChip(
                                    label: Text(optionsEmployement[index]),
                                    labelStyle: TextStyle(fontFamily: 'Readex Pro',
                                    color: Colors.white) ,
                                    selected: _valueEmployement == index,
                                    selectedColor: Color(0xFF4B39EF),
                                    showCheckmark: false,
                                    iconTheme: IconThemeData(color: const Color.fromARGB(255, 62, 60, 60),
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
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
              child: Container(
                width: double.infinity,
                child: TextFormField(
                  maxLines: 4,
                  autofocus: true,
                  autofillHints: [AutofillHints.name],
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle:
                        TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              color: Color(0xFF57636C),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                    hintText: 'Description',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFE0E3E7),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF4B39EF),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFFF5963),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFFF5963),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(24),
                  ),
                  style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        color: Color(0xFF101213),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                  keyboardType: TextInputType.multiline,
                  validator: (val) =>
                                        val!.isEmpty ? 'Please enter description' : null,
                                      onChanged: (val) => setState(() => _surname = val),
                ),
              ),
            ),

          ],
        ),
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
              padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 24),
              child: Text(
                'Almost done!',
                textAlign: TextAlign.start,
                style:TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Color(0xFF57636C),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Pick four photo for your profile!',
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                     
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://picsum.photos/seed/857/600',
                        width: MediaQuery.sizeOf(context).width * 0.30,
                        height: MediaQuery.sizeOf(context).height * 0.20,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                   SizedBox(width: MediaQuery.sizeOf(context).width * 0.05),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'https://picsum.photos/seed/536/600',
                      width: MediaQuery.sizeOf(context).width * 0.30,
                      height: MediaQuery.sizeOf(context).height * 0.20,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://picsum.photos/seed/857/600',
                    width:  MediaQuery.sizeOf(context).width * 0.30,
                    height: MediaQuery.sizeOf(context).height * 0.20,
                    fit: BoxFit.cover,
                  ),
                ),
                 SizedBox(width: MediaQuery.sizeOf(context).width * 0.05),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://picsum.photos/seed/536/600',
                    width: MediaQuery.sizeOf(context).width * 0.30,
                    height: MediaQuery.sizeOf(context).height * 0.20,
                    fit: BoxFit.cover,
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
                
                Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 16),
                                  child:  ElevatedButton(
                                  onPressed: () async {
                                    if (scaffoldKey.currentState!.validate()) {
                                        }
                          
                                   },
                                    child : Text('Create',
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                    ),),
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: Size(230, 52),
                                      backgroundColor:Colors.black,
                                       elevation: 3.0,
                                       side: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                    ),
                                    ),
  
                                  ),
                                ),],
                ),
            ),),
          ),
        ),
    );
  }
}
