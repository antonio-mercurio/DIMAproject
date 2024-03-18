import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geocoding_resolver/geocoding_resolver.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/user.dart';
import 'package:prva/services/image_picker/schermiProva.dart';
import 'package:prva/services/databaseForHouseProfile.dart';
import 'package:prva/services/match/match_service.dart';

class FormHouseAdj extends StatefulWidget {
  const FormHouseAdj({super.key});

  @override
  State<FormHouseAdj> createState() => _FormHouseAdjState();
}

class _FormHouseAdjState extends State<FormHouseAdj> {
  final scaffoldKey = GlobalKey<FormState>();

  TextEditingController controller = TextEditingController();
  late LatLng selLocation;

  int? _numberBathroom;
  int? _floorNumber;
  int? _numberPeople;
  String? _address;
  String? _city;
  double? _price;
  String? _description;
  String? _type;
  final List<String> typeOfAppartament = [
    "Apartment",
    "Single room",
    "Double room",
    "Studio apartment",
    "Two-room apartment",
  ];
  DateTime? _startDate;
  DateTime? _endDate;
  List<String> imageURLs = ['', '', '', ''];

  // controller for the textfield
  final TextEditingController _dateStartController = TextEditingController();
  final TextEditingController _dateEndController = TextEditingController();

  void _selectStartDate(BuildContext context) async {
    // get the initial date
    DateTime initialDate = _startDate ?? DateTime.now();

    // show the date picker and wait for the result
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(DateTime.now().year + 10),
    );

    // if the user picked a date, update the state
    if (pickedDate != null && pickedDate != _startDate) {
      setState(() {
        // set the selected date
        _startDate = pickedDate;

        // format the date as dd/mm/yyyy
        String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);

        // update the textfield controller
        _dateStartController.text = formattedDate;
      });
    }
  }

  void _selectEndDate(BuildContext context) async {
    // get the initial date
    DateTime initialDate = _endDate ?? DateTime.now();

    // show the date picker and wait for the result
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(DateTime.now().year + 10),
    );

    // if the user picked a date, update the state
    if (pickedDate != null && pickedDate != _endDate) {
      setState(() {
        // set the selected date
        _endDate = pickedDate;

        // format the date as dd/mm/yyyy
        String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);

        // update the textfield controller
        _dateEndController.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Utente>(context);
    return Scaffold(
        backgroundColor: Colors.white,
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
                            color: Colors.white,
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
                                const Text(
                                  'Create your house profile',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color(0xFF101213),
                                    fontSize: 36,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 12, 0, 24),
                                  child: Text(
                                    'Start with address and type!',
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
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 16),
                                  child: Container(
                                    width: double.infinity,
                                    child: DropdownButtonFormField(
                                        style: const TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF101213),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        decoration: InputDecoration(
                                          labelText: 'Type',
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
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0xFFFF5963),
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
                                        value: _type ?? "Apartment",
                                        items: typeOfAppartament.map((type) {
                                          return DropdownMenuItem(
                                            value: type,
                                            child: Text('$type '),
                                          );
                                        }).toList(),
                                        onChanged: (val) =>
                                            setState(() => _type = val)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 16),
                                  child: Container(
                                      width: double.infinity,
                                      child: GooglePlaceAutoCompleteTextField(
                                        textEditingController: controller,
                                        googleAPIKey:
                                            "AIzaSyD8yblyesPc-09bye4ZF9KlO95G6RhhlmA",
                                        inputDecoration: const InputDecoration(
                                          labelText: 'Address',
                                          labelStyle: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: Color(0xFF57636C),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFE0E3E7),
                                              width: 2,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF4B39EF),
                                              width: 2,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFFF5963),
                                              width: 2,
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFFF5963),
                                              width: 2,
                                            ),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding: EdgeInsets.all(24),
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
                                            selLocation = LatLng(
                                                double.parse(
                                                    prediction.lat.toString()),
                                                double.parse(
                                                    prediction.lng.toString()));
                                            var address = await GeoCoder()
                                                .getAddressFromLatLng(
                                                    latitude:
                                                        selLocation.latitude,
                                                    longitude:
                                                        selLocation.longitude);
                                            //qui accedo ad address e prendo i dettagli che mi servono

                                            _address =
                                                "${address.addressDetails.road}, ${address.addressDetails.houseNumber}, ${address.addressDetails.postcode}, ${address.addressDetails.city}";

                                            _city = address.addressDetails.city;
                                          }
                                        }, // this callback is called when isLatLngRequired is true

                                        itemClick: (Prediction prediction) {
                                          controller.text =
                                              prediction.description!;
                                          controller.selection =
                                              TextSelection.fromPosition(
                                                  TextPosition(
                                                      offset: prediction
                                                          .description!
                                                          .length));
                                        },
                                        // if we want to make custom list item builder
                                        itemBuilder: (context, index,
                                            Prediction prediction) {
                                          return Container(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              children: [
                                                const Icon(Icons.location_on),
                                                const SizedBox(
                                                  width: 7,
                                                ),
                                                Expanded(
                                                    child: Text(prediction
                                                            .description ??
                                                        ""))
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
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 12, 0, 24),
                                    child: Text(
                                      'Something about the house',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: Color(0xFF57636C),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 16),
                                  child: Container(
                                    width: double.infinity,
                                    child: TextFormField(
                                      maxLines: 3,
                                      autofocus: true,
                                      autofillHints: const [
                                        AutofillHints.email
                                      ],
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Description',
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
                                        contentPadding:
                                            const EdgeInsets.all(24),
                                      ),
                                      style: const TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: Color(0xFF101213),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      validator: (val) => val!.isEmpty
                                          ? 'Please enter description'
                                          : null,
                                      onChanged: (val) =>
                                          setState(() => _description = val),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const Text(
                                      'Max number of people that\ncan live in the house:',
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontSize: 16,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(16, 0, 0, 16),
                                        child: Container(
                                          width: double.infinity,
                                          child: TextFormField(
                                              autofocus: true,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFFE0E3E7),
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
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
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFFFF5963),
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
                                              style: const TextStyle(
                                                fontFamily: 'Plus Jakarta Sans',
                                                color: Color(0xFF101213),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              validator: (val) => val!.isEmpty
                                                  ? 'Please enter a number'
                                                  : null,
                                              onChanged: (val) => setState(() =>
                                                  _numberPeople =
                                                      (int.parse(val)))),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const Text(
                                      'Floor number of the house:',
                                      style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 16,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(16, 0, 0, 16),
                                        child: Container(
                                          width: double.infinity,
                                          child: TextFormField(
                                              autofocus: true,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFFE0E3E7),
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
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
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFFFF5963),
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
                                              style: const TextStyle(
                                                fontFamily: 'Plus Jakarta Sans',
                                                color: Color(0xFF101213),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              validator: (val) => val!.isEmpty
                                                  ? 'Please enter a number'
                                                  : null,
                                              onChanged: (val) => setState(() =>
                                                  _floorNumber =
                                                      (int.parse(val)))),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const Text(
                                      'Number of bathrooms:',
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontSize: 16,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(48, 0, 0, 16),
                                        child: Container(
                                          width: double.infinity,
                                          child: TextFormField(
                                              autofocus: true,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFFE0E3E7),
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
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
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFFFF5963),
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
                                              style: const TextStyle(
                                                fontFamily: 'Plus Jakarta Sans',
                                                color: Color(0xFF101213),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              validator: (val) => val!.isEmpty
                                                  ? 'Please enter a number'
                                                  : null,
                                              onChanged: (val) => setState(() =>
                                                  _numberBathroom =
                                                      (int.parse(val)))),
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
                            color: const Color(0xFFE0E3E7),
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 12, 0, 24),
                                  child: Text(
                                    'Something about the rent',
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
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 16),
                                  child: Container(
                                    width: double.infinity,
                                    child: TextFormField(
                                      controller: _dateStartController,
                                      readOnly: true,
                                      autofocus: true,
                                      autofillHints: const [
                                        AutofillHints.birthday
                                      ],
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          icon:
                                              const Icon(Icons.calendar_today),
                                          onPressed: () {
                                            // call the function to show the date picker
                                            _selectStartDate(context);
                                          },
                                        ),
                                        labelText: 'Start date of rent',
                                        labelStyle: const TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF57636C),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        hintText: 'Start date of rent',
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
                                        contentPadding:
                                            const EdgeInsets.all(24),
                                      ),
                                      style: const TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: Color(0xFF101213),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      validator: (val) => val!.isEmpty
                                          ? 'Please enter a date'
                                          : null,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 16),
                                  child: Container(
                                    width: double.infinity,
                                    child: TextFormField(
                                      controller: _dateEndController,
                                      readOnly: true,
                                      autofocus: true,
                                      autofillHints: const [
                                        AutofillHints.birthday
                                      ],
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          icon:
                                              const Icon(Icons.calendar_today),
                                          onPressed: () {
                                            // call the function to show the date picker
                                            _selectEndDate(context);
                                          },
                                        ),
                                        labelText: 'End date of rent',
                                        labelStyle: const TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF57636C),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        hintText: 'End date of rent',
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
                                        contentPadding:
                                            const EdgeInsets.all(24),
                                      ),
                                      style: const TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: Color(0xFF101213),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      validator: (val) => val!.isEmpty
                                          ? 'Please enter a date'
                                          : null,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 16),
                                  child: Container(
                                    width: double.infinity,
                                    child: TextFormField(
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Price',
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
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0xFFFF5963),
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
                                        style: const TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF101213),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        keyboardType: const TextInputType
                                            .numberWithOptions(decimal: true),
                                        validator: (val) => val!.isEmpty
                                            ? 'Please enter a price'
                                            : null,
                                        onChanged: (val) => setState(() =>
                                            _price = (double.parse(val)))),
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 12, 0, 24),
                                  child: Text(
                                    'Almost done!',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Color(0xFF57636C),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 16),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Pick some photos for your profile!',
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 16),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(children: [
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
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
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.30,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .height *
                                                        0.20,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.network(
                                                    imageURLs[0],
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.30,
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
                                          child: imageURLs.elementAt(0).isEmpty
                                              ? null
                                              : IconButton(
                                                  icon: const Icon(Icons.close),
                                                  color:
                                                      const Color(0xFFFF5963),
                                                  onPressed: () async {
                                                    await FirebaseStorage
                                                        .instance
                                                        .refFromURL(imageURLs
                                                            .elementAt(0))
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
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.05),
                                      Column(children: [
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
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
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.30,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .height *
                                                        0.20,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.network(
                                                    imageURLs[1],
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.30,
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
                                          child: imageURLs.elementAt(1).isEmpty
                                              ? null
                                              : IconButton(
                                                  icon: const Icon(Icons.close),
                                                  color:
                                                      const Color(0xFFFF5963),
                                                  onPressed: () async {
                                                    await FirebaseStorage
                                                        .instance
                                                        .refFromURL(imageURLs
                                                            .elementAt(1))
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(children: [
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          if (imageURLs[2].isEmpty) {
                                            imageURLs[2] = await SchermiProva()
                                                .uploadFile();

                                            if (mounted) {
                                              setState(() {});
                                            }
                                          }
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: imageURLs.elementAt(2).isEmpty
                                              ? Image.asset(
                                                  'assets/userPhoto.jpg',
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.30,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.20,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.network(
                                                  imageURLs[2],
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.30,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.20,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: imageURLs.elementAt(2).isEmpty
                                            ? null
                                            : IconButton(
                                                icon: const Icon(Icons.close),
                                                color: const Color(0xFFFF5963),
                                                onPressed: () async {
                                                  await FirebaseStorage.instance
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
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.05),
                                    Column(children: [
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          if (imageURLs[3].isEmpty) {
                                            imageURLs[3] = await SchermiProva()
                                                .uploadFile();
                                            if (mounted) {
                                              setState(() {});
                                            }
                                          }
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: imageURLs.elementAt(3).isEmpty
                                              ? Image.asset(
                                                  'assets/userPhoto.jpg',
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.30,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.20,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.network(
                                                  imageURLs[3],
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.30,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.20,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: imageURLs.elementAt(3).isEmpty
                                            ? null
                                            : IconButton(
                                                icon: const Icon(Icons.close),
                                                color: const Color(0xFFFF5963),
                                                onPressed: () async {
                                                  await FirebaseStorage.instance
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
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (scaffoldKey.currentState!.validate()) {
                              if (_startDate!.isBefore(_endDate!)) {
                                if (imageURLs[0] !=
                                    '' /*&& imageURLs[0]!='' && imageURLs[0]!='' && imageURLs[0]!=''*/) {
                                  setState(() {});

                                  await DatabaseServiceHouseProfile(user.uid)
                                      .createUserDataHouseProfileAdj(
                                          _type ?? 'Apartment',
                                          _address ?? '',
                                          _city ?? '',
                                          _description ?? '',
                                          _price ?? 0,
                                          _floorNumber ?? 0,
                                          _numberBathroom ?? 0,
                                          _numberPeople ?? 0,
                                          _startDate!.year,
                                          _endDate!.year,
                                          _startDate!.month,
                                          _endDate!.month,
                                          _startDate!.day,
                                          _endDate!.day,
                                          selLocation.latitude,
                                          selLocation.longitude,
                                          imageURLs[0],
                                          imageURLs[1],
                                          imageURLs[2],
                                          imageURLs[3],
                                          0);
                                  if (mounted) {
                                    Navigator.pop(context);
                                  }
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
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'End date is before start date!',
                                    ),
                                  ),
                                );
                                return;
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(230, 52),
                            backgroundColor: Colors.black,
                            elevation: 3.0,
                            side: const BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                          ),
                          child: const Text(
                            'Create',
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
        ));
  }
}
