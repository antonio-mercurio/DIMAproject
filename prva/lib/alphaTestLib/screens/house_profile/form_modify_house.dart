import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

import 'package:prva/alphaTestLib/models/houseProfile.dart';
import 'package:prva/alphaTestLib/screens/shared/constant.dart';

class ModifyHouseProfile extends StatefulWidget {
  final HouseProfileAdj house;
  const ModifyHouseProfile({super.key, required this.house});

  @override
  State<ModifyHouseProfile> createState() =>
      _ModifyHouseProfileState(house: house);
}

class _ModifyHouseProfileState extends State<ModifyHouseProfile> {
  final scaffoldKey = GlobalKey<FormState>();
  final HouseProfileAdj house;

  bool flagImg1 = true;
  bool flagImg2 = true;
  bool flagImg3 = true;
  bool flagImg4 = true;
  _ModifyHouseProfileState({required this.house});
  TextEditingController controller = TextEditingController();
  late LatLng? selLocation;
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
    "Apartment",
    "Single room",
    "Double room",
    "Studio apartment",
    "Two-room apartment",
  ];
  DateTime? startDate;
  DateTime? endDate;
  List<String> imageURLs = ['', '', '', ''];
  bool flagStartDate = true;
  bool flagEndDate = true;
  // controller for the textfield
  final TextEditingController _dateStartController = TextEditingController();
  final TextEditingController _dateEndController = TextEditingController();

  void _selectStartDate(BuildContext context) async {
    startDate = DateTime(2000, 1, 1);

    // format the date as dd/mm/yyyy
    String formattedDate = DateFormat('dd/MM/yyyy').format(startDate!);

    // update the textfield controller
    _dateStartController.text = formattedDate;
  }

  void _selectEndDate(BuildContext context) async {
    endDate = DateTime(2000, 1, 1);

    // format the date as dd/mm/yyyy
    String formattedDate = DateFormat('dd/MM/yyyy').format(endDate!);

    // update the textfield controller
    _dateEndController.text = formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    imageURLs[0] = initImg1();
    imageURLs[1] = initImg2();
    imageURLs[2] = initImg3();
    imageURLs[3] = initImg4();
    _type = initType();
    initPrice();
    initStartDate();
    initEndDate();
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: mainColor,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Align(
            alignment: const AlignmentDirectional(0, -1),
            child: SingleChildScrollView(
              key: Key('scrollable'),
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
                                    Text(
                                      'Update your house profile',
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.plusJakartaSans(
                                        color: const Color(0xFF101213),
                                        fontSize: size32(context),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 12, 0, 24),
                                      child: Text(
                                        'Modify address and type!',
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
                                        child: DropdownButtonFormField(
                                            key: Key('type'),
                                            style: GoogleFonts.plusJakartaSans(
                                              color: const Color(0xFF101213),
                                              fontSize: size16(context),
                                              fontWeight: FontWeight.w500,
                                            ),
                                            decoration: InputDecoration(
                                              labelText: 'Type',
                                              labelStyle:
                                                  GoogleFonts.plusJakartaSans(
                                                color: const Color(0xFF57636C),
                                                fontSize: size16(context),
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
                                            value: _type,
                                            items:
                                                typeOfAppartament.map((type) {
                                              {
                                                return DropdownMenuItem(
                                                  key: Key('item-$type'),
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
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 16),
                                      child: SizedBox(
                                          width: double.infinity,
                                          child:
                                              GooglePlaceAutoCompleteTextField(
                                            textEditingController: controller,
                                            googleAPIKey:
                                                "AIzaSyD8yblyesPc-09bye4ZF9KlO95G6RhhlmA",
                                            inputDecoration: InputDecoration(
                                              labelText: house.address,
                                              labelStyle:
                                                  GoogleFonts.plusJakartaSans(
                                                color: const Color(0xFF57636C),
                                                fontSize: size16(context),
                                                fontWeight: FontWeight.w500,
                                              ),
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFFE0E3E7),
                                                  width: 2,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: mainColor,
                                                  width: 2,
                                                ),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: errorColor,
                                                  width: 2,
                                                ),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: errorColor,
                                                  width: 2,
                                                ),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                              contentPadding:
                                                  const EdgeInsets.all(24),
                                            ),
                                            debounceTime:
                                                800, // default 600 ms,
                                            countries: const [
                                              "it",
                                              "fr"
                                            ], // optional by default null is set
                                            isLatLngRequired:
                                                false, // if you required coordinates from place detail
                                            /* getPlaceDetailWithLatLng:
                                                (Prediction prediction) async {
                                              // this method will return latlng with place detail

                                              if (prediction.lng != null &&
                                                  prediction.lat != null) {
                                                selLocation = LatLng(
                                                    double.parse(prediction.lat
                                                        .toString()),
                                                    double.parse(prediction.lng
                                                        .toString()));
                                                var address = await GeoCoder()
                                                    .getAddressFromLatLng(
                                                        latitude: selLocation!
                                                            .latitude,
                                                        longitude: selLocation!
                                                            .longitude);
                                                //qui accedo ad address e prendo i dettagli che mi servono

                                                _address =
                                                    "${address.addressDetails.road}, ${address.addressDetails.houseNumber}, ${address.addressDetails.postcode}, ${address.addressDetails.city}";

                                                _city =
                                                    address.addressDetails.city;
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
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.location_on),
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
                                          */
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
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 12, 0, 24),
                                        child: Text(
                                          'Something about the house',
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.plusJakartaSans(
                                            color: const Color(0xFF57636C),
                                            fontSize: size16(context),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 16),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: TextFormField(
                                          key: Key('description'),
                                          maxLines: 3,
                                          autofocus: true,
                                          initialValue: house.description,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Description',
                                            labelStyle:
                                                GoogleFonts.plusJakartaSans(
                                              color: const Color(0xFF57636C),
                                              fontSize: size16(context),
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
                                              ? 'Please enter description'
                                              : null,
                                          onChanged: (val) => setState(
                                              () => _description = val),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          'Max number of people that\ncan live in the house:',
                                          style: GoogleFonts.plusJakartaSans(
                                            color: const Color(0xFF101213),
                                            fontSize: size16(context),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(16, 0, 0, 16),
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: TextFormField(
                                                  key: Key('numPeople'),
                                                  initialValue:
                                                      house.numPlp.toString(),
                                                  autofocus: true,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color:
                                                            Color(0xFFE0E3E7),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: mainColor,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: errorColor,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: errorColor,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                    ),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            24),
                                                  ),
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                    color:
                                                        const Color(0xFF101213),
                                                    fontSize: size16(context),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  validator: (val) => val!
                                                          .isEmpty
                                                      ? 'Please enter a number'
                                                      : null,
                                                  onChanged: (val) => setState(
                                                      () => _numberPeople =
                                                          (int.parse(val)))),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          'Floor number of the house:',
                                          style: GoogleFonts.plusJakartaSans(
                                            color: const Color(0xFF101213),
                                            fontSize: size16(context),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(16, 0, 0, 16),
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: TextFormField(
                                                  key: Key('floorField'),
                                                  initialValue: house
                                                      .floorNumber
                                                      .toString(),
                                                  autofocus: true,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color:
                                                            Color(0xFFE0E3E7),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: mainColor,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: errorColor,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: errorColor,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                    ),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            24),
                                                  ),
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                    color:
                                                        const Color(0xFF101213),
                                                    fontSize: size16(context),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  validator: (val) => val!
                                                          .isEmpty
                                                      ? 'Please enter a number'
                                                      : null,
                                                  onChanged: (val) => setState(
                                                      () => _floorNumber =
                                                          (int.parse(val)))),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          'Number of bathrooms:',
                                          style: GoogleFonts.plusJakartaSans(
                                            color: const Color(0xFF101213),
                                            fontSize: size16(context),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(48, 0, 0, 16),
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: TextFormField(
                                                  key: Key('numBaths'),
                                                  initialValue:
                                                      house.numBath.toString(),
                                                  autofocus: true,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color:
                                                            Color(0xFFE0E3E7),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: mainColor,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: errorColor,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: errorColor,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                    ),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            24),
                                                  ),
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                    color:
                                                        const Color(0xFF101213),
                                                    fontSize: size16(context),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  validator: (val) => val!
                                                          .isEmpty
                                                      ? 'Please enter a number'
                                                      : null,
                                                  onChanged: (val) => setState(
                                                      () => _numberBathroom =
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
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 12, 0, 24),
                                      child: Text(
                                        'Something about the rent',
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
                                          controller: _dateStartController,
                                          readOnly: true,
                                          autofocus: true,
                                          autofillHints: const [
                                            AutofillHints.birthday
                                          ],
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                              key: Key('startdate'),
                                              icon: const Icon(
                                                  Icons.calendar_today),
                                              onPressed: () {
                                                // call the function to show the date picker
                                                _selectStartDate(context);
                                              },
                                            ),
                                            labelText: 'Start date of rent',
                                            labelStyle:
                                                GoogleFonts.plusJakartaSans(
                                              color: const Color(0xFF57636C),
                                              fontSize: size16(context),
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
                                      child: SizedBox(
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
                                              key: Key('enddate'),
                                              icon: const Icon(
                                                  Icons.calendar_today),
                                              onPressed: () {
                                                // call the function to show the date picker
                                                _selectEndDate(context);
                                              },
                                            ),
                                            labelText: 'End date of rent',
                                            labelStyle:
                                                GoogleFonts.plusJakartaSans(
                                              color: const Color(0xFF57636C),
                                              fontSize: size16(context),
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
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: TextFormField(
                                            key: Key('price'),
                                            initialValue: _price.toString(),
                                            autofocus: true,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Price',
                                              labelStyle:
                                                  GoogleFonts.plusJakartaSans(
                                                color: const Color(0xFF57636C),
                                                fontSize: size16(context),
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
                                            keyboardType: const TextInputType
                                                .numberWithOptions(
                                                decimal: true),
                                            validator: (val) => (val!.isEmpty ||
                                                    double.parse(val) > 4000 ||
                                                    double.parse(val) < 0)
                                                ? 'Please enter a valid price (range: 0-4000)'
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
                                              key: Key('img1'),
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                if (imageURLs[0] == "") {
                                                  imageURLs[0] = uploadFile();
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
                                                    : Icon(Icons.abc),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: imageURLs[0] == ''
                                                  ? null
                                                  : IconButton(
                                                      key: Key('deleteImg1'),
                                                      icon: const Icon(
                                                          Icons.close),
                                                      color: errorColor,
                                                      onPressed: () async {
                                                        imageURLs[0] = '';
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
                                              key: Key('img2'),
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                if (imageURLs[1].isEmpty) {
                                                  imageURLs[1] = uploadFile();
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
                                                    : Icon(Icons.abc),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: imageURLs
                                                      .elementAt(1)
                                                      .isEmpty
                                                  ? null
                                                  : IconButton(
                                                      key: Key('deleteImg2'),
                                                      icon: const Icon(
                                                          Icons.close),
                                                      color: errorColor,
                                                      onPressed: () async {
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
                                            key: Key('img3'),
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              if (imageURLs[2].isEmpty) {
                                                imageURLs[2] = uploadFile();

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
                                                  : Icon(Icons.abc),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: imageURLs
                                                    .elementAt(2)
                                                    .isEmpty
                                                ? null
                                                : IconButton(
                                                    key: Key('deleteImg3'),
                                                    icon:
                                                        const Icon(Icons.close),
                                                    color: errorColor,
                                                    onPressed: () async {
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
                                                    .height *
                                                0.02),
                                        Column(children: [
                                          InkWell(
                                            key: Key('img4'),
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              if (imageURLs[3].isEmpty) {
                                                imageURLs[3] = uploadFile();
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
                                                  : Icon(Icons.abc),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: imageURLs
                                                    .elementAt(3)
                                                    .isEmpty
                                                ? null
                                                : IconButton(
                                                    key: Key('deleteImg4'),
                                                    icon:
                                                        const Icon(Icons.close),
                                                    color: errorColor,
                                                    onPressed: () async {
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
                              key: Key('updateButton'),
                              onPressed: () async {
                                if (scaffoldKey.currentState!.validate()) {
                                  if (startDate!.isBefore(endDate!)) {
                                    if (imageURLs[0] != '') {
                                      Navigator.pop(context);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
                                'Update!',
                                style: GoogleFonts.plusJakartaSans(
                                  color: backgroundColor,
                                  fontSize: size16(context),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 16),
                            child: ElevatedButton(
                              key: Key('deleteButton'),
                              onPressed: () async {
                                if (mounted) {
                                  Navigator.pop(context);
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
                                'Delete',
                                style: GoogleFonts.plusJakartaSans(
                                  color: Colors.white,
                                  fontSize: size16(context),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ])),
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
      startDate =
          DateTime.utc(house.startYear, house.startMonth, house.startDay);
      flagStartDate = false;
    }
  }

  void initEndDate() {
    if (flagEndDate) {
      _dateEndController.text = DateFormat('dd/MM/yyyy')
          .format(DateTime.utc(house.endYear, house.endMonth, house.endDay));
      endDate = DateTime.utc(house.endYear, house.endMonth, house.endDay);
      flagEndDate = false;
    }
  }

  void initPrice() {
    if (flagPrice) {
      _price = house.price;
      flagPrice = false;
    }
  }

  String uploadFile() {
    return "imagePickerTest";
  }
}
