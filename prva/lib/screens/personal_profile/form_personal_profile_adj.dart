import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/user.dart';
import 'package:prva/screens/shared/constant.dart';
import 'package:prva/services/image_picker/schermiProva.dart';
import 'package:prva/services/database.dart';
import 'package:prva/services/databaseForFilters.dart';
import 'package:prva/services/match/match_service.dart';
import 'package:prva/screens/shared/loading.dart'; // for date formatting

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
  late List<String> imageURLs;
  bool loading = false;
  // controller for the textfield
  final TextEditingController _dateController = TextEditingController();

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
  void initState() {
    super.initState();
    imageURLs = ['', '', '', ''];
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Utente?>(context);
    if (user == null) {
      return const Loading();
    } else {
      return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: mainColor,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: Align(
                alignment: const AlignmentDirectional(0, -1),
                child: SingleChildScrollView(
                  child: Form(
                    key: scaffoldKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 32, 0, 32),
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.sizeOf(context).height * 0.052,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            alignment: const AlignmentDirectional(0, 0),
                            child: Text(
                              'Create your profile',
                              style: GoogleFonts.plusJakartaSans(
                                color: const Color(0xFF101213),
                                fontSize: size32(context),
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
                              maxWidth: 700,
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
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 12, 0, 24),
                                      child: Text(
                                        'Start with your personal data',
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.plusJakartaSans(
                                          color: const Color(0xFF57636C),
                                          fontSize: size16(context),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 16),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: TextFormField(
                                          autofocus: true,
                                          autofillHints: const [
                                            AutofillHints.name
                                          ],
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Name',
                                            labelStyle:
                                                GoogleFonts.plusJakartaSans(
                                              color: const Color(0xFF57636C),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            hintText: 'Name',
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFE0E3E7),
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: mainColor,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: errorColor,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: errorColor,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding:
                                                const EdgeInsets.all(24),
                                          ),
                                          style: GoogleFonts.plusJakartaSans(
                                            color: const Color(0xFF101213),
                                            fontSize: size16(context),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          validator: (val) => val!.isEmpty
                                              ? 'Please enter a name'
                                              : null,
                                          onChanged: (val) =>
                                              setState(() => _name = val),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 16),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: TextFormField(
                                          autofocus: true,
                                          autofillHints: const [
                                            AutofillHints.name
                                          ],
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Surname',
                                            labelStyle:
                                                GoogleFonts.plusJakartaSans(
                                              color: const Color(0xFF57636C),
                                              fontSize: size16(context),
                                              fontWeight: FontWeight.w500,
                                            ),
                                            hintText: 'Surname',
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFE0E3E7),
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: mainColor,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: errorColor,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: errorColor,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding:
                                                const EdgeInsets.all(24),
                                          ),
                                          style: GoogleFonts.plusJakartaSans(
                                            color: const Color(0xFF101213),
                                            fontSize: size16(context),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          validator: (val) => val!.isEmpty
                                              ? 'Please enter a surname'
                                              : null,
                                          onChanged: (val) =>
                                              setState(() => _surname = val),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 16),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: TextFormField(
                                          controller: _dateController,
                                          readOnly: true,
                                          autofocus: true,
                                          autofillHints: const [
                                            AutofillHints.birthday
                                          ],
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                              icon: const Icon(
                                                  Icons.calendar_today),
                                              onPressed: () {
                                                // call the function to show the date picker
                                                _selectDate(context);
                                              },
                                            ),
                                            labelText: 'Birth Date',
                                            labelStyle:
                                                GoogleFonts.plusJakartaSans(
                                              color: const Color(0xFF57636C),
                                              fontSize: size16(context),
                                              fontWeight: FontWeight.w500,
                                            ),
                                            hintText: 'Bitrth Date',
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFE0E3E7),
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: mainColor,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: errorColor,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: errorColor,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding:
                                                const EdgeInsets.all(24),
                                          ),
                                          style: GoogleFonts.plusJakartaSans(
                                            color: const Color(0xFF101213),
                                            fontSize: size16(context),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          validator: (val) => val!.isEmpty
                                              ? 'Please enter a date'
                                              : null,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 16),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Your gender:',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.plusJakartaSans(
                                              color: const Color(0xFF101213),
                                              fontSize: size16(context),
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
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 0, 16),
                                              child: Wrap(
                                                alignment:
                                                    WrapAlignment.spaceEvenly,
                                                children: List<Widget>.generate(
                                                  3,
                                                  (int index) {
                                                    return ChoiceChip(
                                                      backgroundColor:
                                                          Colors.grey,
                                                      label: Text(
                                                          optionsGender[index]),
                                                      labelStyle:
                                                          GoogleFonts.readexPro(
                                                              fontSize: size12(
                                                                  context),
                                                              color:
                                                                  Colors.white),
                                                      selected:
                                                          _valueGender == index,
                                                      selectedColor: mainColor,
                                                      showCheckmark: false,
                                                      iconTheme: IconThemeData(
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 62, 60, 60),
                                                        size: size18(context),
                                                      ),
                                                      onSelected:
                                                          (bool selected) {
                                                        setState(() {
                                                          _valueGender =
                                                              selected
                                                                  ? index
                                                                  : null;
                                                        });
                                                      },
                                                    );
                                                  },
                                                ).toList(),
                                              )),
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
                          padding: const EdgeInsets.all(12),
                          child: Container(
                            width: double.infinity,
                            constraints: const BoxConstraints(
                              maxWidth: 700,
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
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 12, 0, 24),
                                      child: Text(
                                        'Something about you',
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.plusJakartaSans(
                                          color: const Color(0xFF57636C),
                                          fontSize: size16(context),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 16),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Employment:',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.plusJakartaSans(
                                              color: const Color(0xFF101213),
                                              fontSize: size16(context),
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
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 0, 16),
                                              child: Wrap(
                                                alignment:
                                                    WrapAlignment.spaceEvenly,
                                                children: List<Widget>.generate(
                                                  2,
                                                  (int index) {
                                                    return ChoiceChip(
                                                      backgroundColor:
                                                          Colors.grey,
                                                      label: Text(
                                                          optionsEmployement[
                                                              index]),
                                                      labelStyle:
                                                          GoogleFonts.readexPro(
                                                              fontSize: size12(
                                                                  context),
                                                              color:
                                                                  Colors.white),
                                                      selected:
                                                          _valueEmployement ==
                                                              index,
                                                      selectedColor: mainColor,
                                                      showCheckmark: false,
                                                      iconTheme: IconThemeData(
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 62, 60, 60),
                                                        size: size18(context),
                                                      ),
                                                      onSelected:
                                                          (bool selected) {
                                                        setState(() {
                                                          _valueEmployement =
                                                              selected
                                                                  ? index
                                                                  : null;
                                                        });
                                                      },
                                                    );
                                                  },
                                                ).toList(),
                                              )),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 16),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: TextFormField(
                                          maxLines: 4,
                                          autofocus: true,
                                          autofillHints: const [
                                            AutofillHints.name
                                          ],
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Description',
                                            labelStyle:
                                                GoogleFonts.plusJakartaSans(
                                              color: const Color(0xFF57636C),
                                              fontSize: size16(context),
                                              fontWeight: FontWeight.w500,
                                            ),
                                            hintText: 'Description',
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xFFE0E3E7),
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: mainColor,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: errorColor,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: errorColor,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding:
                                                const EdgeInsets.all(24),
                                          ),
                                          style: GoogleFonts.plusJakartaSans(
                                            color: const Color(0xFF101213),
                                            fontSize: size16(context),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          keyboardType: TextInputType.multiline,
                                          validator: (val) => val!.isEmpty
                                              ? 'Please enter description'
                                              : null,
                                          onChanged: (val) => setState(
                                              () => _description = val),
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
                          padding: const EdgeInsets.all(12),
                          child: Container(
                            width: double.infinity,
                            constraints: const BoxConstraints(
                              maxWidth: 700,
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
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 12, 0, 24),
                                      child: Text(
                                        'Almost done!',
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.plusJakartaSans(
                                          color: const Color(0xFF57636C),
                                          fontSize: size16(context),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 16),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Pick some photos for your profile!',
                                            style: GoogleFonts.plusJakartaSans(
                                              color: const Color(0xFF101213),
                                              fontSize: size16(context),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 16),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(children: [
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                if (imageURLs[0].isEmpty) {
                                                  imageURLs[0] =
                                                      await SchermiProva()
                                                          .uploadFile();
                                                  if (mounted) {
                                                    setState(() {});
                                                  }
                                                }
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: imageURLs
                                                        .elementAt(0)
                                                        .isEmpty
                                                    ? Image.asset(
                                                        'assets/userPhoto.jpg',
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.15,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.20,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Image.network(
                                                        imageURLs[0],
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.15,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.20,
                                                        fit: BoxFit.cover,
                                                      ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child:
                                                  imageURLs.elementAt(0).isEmpty
                                                      ? null
                                                      : IconButton(
                                                          icon: const Icon(
                                                              Icons.close),
                                                          color: errorColor,
                                                          onPressed: () async {
                                                            await FirebaseStorage
                                                                .instance
                                                                .refFromURL(
                                                                    imageURLs
                                                                        .elementAt(
                                                                            0))
                                                                .delete();
                                                            imageURLs[0] = "";
                                                            if (mounted) {
                                                              setState(() {});
                                                            }
                                                          },
                                                        ),
                                            ),
                                          ]),
                                          SizedBox(
                                              width: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.02),
                                          Column(children: [
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                if (imageURLs[1].isEmpty) {
                                                  imageURLs[1] =
                                                      await SchermiProva()
                                                          .uploadFile();
                                                  if (mounted) {
                                                    setState(() {});
                                                  }
                                                }
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: imageURLs
                                                        .elementAt(1)
                                                        .isEmpty
                                                    ? Image.asset(
                                                        'assets/userPhoto.jpg',
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.15,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.20,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Image.network(
                                                        imageURLs[1],
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.15,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.20,
                                                        fit: BoxFit.cover,
                                                      ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child:
                                                  imageURLs.elementAt(1).isEmpty
                                                      ? null
                                                      : IconButton(
                                                          icon: const Icon(
                                                              Icons.close),
                                                          color: errorColor,
                                                          onPressed: () async {
                                                            await FirebaseStorage
                                                                .instance
                                                                .refFromURL(
                                                                    imageURLs
                                                                        .elementAt(
                                                                            1))
                                                                .delete();
                                                            imageURLs[1] = "";
                                                            if (mounted) {
                                                              setState(() {});
                                                            }
                                                          },
                                                        ),
                                            ),
                                          ]),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(children: [
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              if (imageURLs[2].isEmpty) {
                                                imageURLs[2] =
                                                    await SchermiProva()
                                                        .uploadFile();

                                                if (mounted) {
                                                  setState(() {});
                                                }
                                              }
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: imageURLs
                                                      .elementAt(2)
                                                      .isEmpty
                                                  ? Image.asset(
                                                      'assets/userPhoto.jpg',
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.15,
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.20,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.network(
                                                      imageURLs[2],
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.15,
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.20,
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: imageURLs
                                                    .elementAt(2)
                                                    .isEmpty
                                                ? null
                                                : IconButton(
                                                    icon:
                                                        const Icon(Icons.close),
                                                    color: errorColor,
                                                    onPressed: () async {
                                                      await FirebaseStorage
                                                          .instance
                                                          .refFromURL(imageURLs
                                                              .elementAt(2))
                                                          .delete();
                                                      imageURLs[2] = "";
                                                      if (mounted) {
                                                        setState(() {});
                                                      }
                                                    },
                                                  ),
                                          ),
                                        ]),
                                        SizedBox(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.02),
                                        Column(children: [
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              if (imageURLs[3].isEmpty) {
                                                imageURLs[3] =
                                                    await SchermiProva()
                                                        .uploadFile();
                                                if (mounted) {
                                                  setState(() {});
                                                }
                                              }
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: imageURLs
                                                      .elementAt(3)
                                                      .isEmpty
                                                  ? Image.asset(
                                                      'assets/userPhoto.jpg',
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.15,
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.20,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.network(
                                                      imageURLs[3],
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.15,
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.20,
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: imageURLs
                                                    .elementAt(3)
                                                    .isEmpty
                                                ? null
                                                : IconButton(
                                                    icon:
                                                        const Icon(Icons.close),
                                                    color: errorColor,
                                                    onPressed: () async {
                                                      await FirebaseStorage
                                                          .instance
                                                          .refFromURL(imageURLs
                                                              .elementAt(3))
                                                          .delete();
                                                      imageURLs[3] = "";
                                                      if (mounted) {
                                                        setState(() {});
                                                      }
                                                    },
                                                  ),
                                          ),
                                        ]),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0, 0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 16),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (scaffoldKey.currentState!.validate()) {
                                  if (imageURLs[0] != '') {
                                    setState(() {});
                                    await DatabaseServiceFilters(user.uid)
                                        .updateFiltersAdj(
                                      "any",
                                      true,
                                      true,
                                      true,
                                      true,
                                      true,
                                      4000.0,
                                    );
                                    await MatchService(uid: user.uid)
                                        .createNotification(0);
                                    await DatabaseService(user.uid)
                                        .updatePersonalProfileAdj(
                                            _name ?? '',
                                            _surname ?? '',
                                            _description ?? '',
                                            optionsGender[_valueGender ?? 1],
                                            optionsEmployement[
                                                _valueEmployement ?? 1],
                                            _birthDate!.day,
                                            _birthDate!.month,
                                            _birthDate!.year,
                                            imageURLs[0],
                                            imageURLs[1],
                                            imageURLs[2],
                                            imageURLs[3]);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Insert the photos!',
                                        ),
                                      ),
                                    );
                                    return;
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(230, 52),
                                backgroundColor: mainColor,
                                elevation: 3.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                side: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                'Create!',
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
          ));
    }
  }
}
