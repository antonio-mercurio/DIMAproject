import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geocoding_resolver/geocoding_resolver.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/houseProfile.dart';
import 'package:prva/models/user.dart';
import 'package:prva/schermiProva.dart';
import 'package:prva/services/databaseForHouseProfile.dart';

class provaModificaCasa extends StatefulWidget {
  final HouseProfileAdj house;
  provaModificaCasa({super.key, required this.house});

  @override
  State<provaModificaCasa> createState() =>
      _provaModificaCasaState(house: house);
}

class _provaModificaCasaState extends State<provaModificaCasa> {
  final scaffoldKey = GlobalKey<FormState>();
  final HouseProfileAdj house;

  bool flagImg1 = true;
  bool flagImg2 = true;
  bool flagImg3 = true;
  bool flagImg4 = true;
  _provaModificaCasaState({required this.house});
  TextEditingController controller = TextEditingController();
  late LatLng selLocation;

  int? _numberBathroom;
  int? _floorNumber;
  int? _numberPeople;
  String? _address;
  String? _city;
  double? _price;
  bool flagPrice = true;
  String? _description;
  String? _type = '';
  bool flagType = true;
  final List<String> typeOfAppartament = [
    "apartment",
    "Single room",
    "Double room",
    "Studio apartment",
    "Two-room apartment",
  ];
  DateTime? _startDate;
  DateTime? _endDate;
  List<String> imageURLs = ['', '', '', ''];
  bool flagStartDate = true;
  bool flagEndDate = true;
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
    imageURLs[0] = initImg1();
    imageURLs[1] = initImg2();
    imageURLs[2] = initImg3();
    imageURLs[3] = initImg4();
    _type = initType();
    initPrice();
    initStartDate();
    initEndDate();
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
                                  'Update your house profile',
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
                                    'Modify address and type!',
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
                                        value: _type,
                                        items: typeOfAppartament.map((type) {
                                          {
                                            return DropdownMenuItem(
                                              value: type,
                                              child: Text('$type '),
                                            );
                                          }
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
                                        inputDecoration: InputDecoration(
                                          labelText: house.address,
                                          labelStyle: const TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: Color(0xFF57636C),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFE0E3E7),
                                              width: 2,
                                            ),
                                          ),
                                          focusedBorder:
                                              const OutlineInputBorder(
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
                                      initialValue: house.description,
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
                                              initialValue:
                                                  house.numPlp.toString(),
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
                                              initialValue:
                                                  house.floorNumber.toString(),
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
                                              initialValue:
                                                  house.numBath.toString(),
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
                                        initialValue: _price.toString(),
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
                                            if (imageURLs[0] == "") {
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
                                            child: imageURLs[0] == ''
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
                                          child: imageURLs[0] == ''
                                              ? null
                                              : IconButton(
                                                  icon: const Icon(Icons.close),
                                                  color:
                                                      const Color(0xFFFF5963),
                                                  onPressed: () async {
                                                    await FirebaseStorage
                                                        .instance
                                                        .refFromURL(
                                                            imageURLs[0])
                                                        .delete();

                                                    imageURLs[0] = '';
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
                          child: Row(children: [
                            ElevatedButton(
                              onPressed: () async {
                                if (scaffoldKey.currentState!.validate()) {
                                  await DatabaseServiceHouseProfile(
                                          house.idHouse)
                                      .updateHouseProfileAdj(
                                          house.owner,
                                          _type ?? house.type,
                                          _address ?? house.address,
                                          _city ?? house.city,
                                          _description ?? house.description,
                                          _price ?? house.price,
                                          _floorNumber ?? house.floorNumber,
                                          _numberBathroom ?? house.numBath,
                                          _numberPeople ?? house.numPlp,
                                          _startDate?.year ?? house.startYear,
                                          _startDate?.month ?? house.startMonth,
                                          _startDate?.day ?? house.startDay,
                                          _endDate?.year ?? house.endYear,
                                          _endDate?.month ?? house.endMonth,
                                          _endDate?.day ?? house.endDay,
                                          imageURLs[0],
                                          imageURLs[1],
                                          imageURLs[2],
                                          imageURLs[3]);
                                  if (mounted) {
                                    Navigator.pop(context);
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('nope'),
                                    ),
                                  );
                                }
                                return;
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(100, 52),
                                backgroundColor: Colors.black,
                                elevation: 3.0,
                                side: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                              ),
                              child: const Text(
                                'Update',
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            ElevatedButton(
                              onPressed: () async {
                                if (scaffoldKey.currentState!.validate()) {
                                  await DatabaseServiceHouseProfile(
                                          house.idHouse)
                                      .deleteHouseProfileAdj();
                                  if (mounted) {
                                    Navigator.popAndPushNamed(
                                        context, "/homepageHouse");
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('nope'),
                                    ),
                                  );
                                }
                                return;
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(100, 52),
                                backgroundColor: Colors.black,
                                elevation: 3.0,
                                side: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                              ),
                              child: const Text(
                                'Delete',
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ])),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  initImg1() {
    if (house.imageURL1 != "" && flagImg1) {
      imageURLs[0] = house.imageURL1;
      flagImg1 = false;
    }
    return imageURLs[0];
  }

  initImg2() {
    if (house.imageURL2 != "" && flagImg2) {
      imageURLs[1] = house.imageURL2;
      flagImg2 = false;
    }
    return imageURLs[1];
  }

  initImg3() {
    if (house.imageURL3 != "" && flagImg3) {
      imageURLs[2] = house.imageURL3;
      flagImg3 = false;
    }
    return imageURLs[2];
  }

  initImg4() {
    if (house.imageURL4 != "" && flagImg4) {
      imageURLs[3] = house.imageURL4;
      flagImg4 = false;
    }
    return imageURLs[3];
  }

  String? initType() {
    if (house.type != "" && flagType) {
      _type = house.type;
      flagType = false;
    }
    return _type;
  }

  void initStartDate() {
    if (flagStartDate) {
      _dateStartController.text = DateFormat('dd/MM/yyyy').format(
          DateTime.utc(house.startYear, house.startMonth, house.startDay));
      _startDate =
          DateTime.utc(house.startYear, house.startMonth, house.startDay);
      flagStartDate = false;
    }
  }

  void initEndDate() {
    if (flagEndDate) {
      _dateEndController.text = DateFormat('dd/MM/yyyy')
          .format(DateTime.utc(house.endYear, house.endMonth, house.endDay));
      _endDate = DateTime.utc(house.endYear, house.endMonth, house.endDay);
      flagEndDate = false;
    }
  }

  void initPrice() {
    if (flagPrice) {
      _price = house.price;
      flagPrice = false;
    }
  }
}
