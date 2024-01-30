import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // for date formatting

class BirthDatePage extends StatefulWidget {
  const BirthDatePage({Key? key}) : super(key: key);

  @override
  _BirthDatePageState createState() => _BirthDatePageState();
}

class _BirthDatePageState extends State<BirthDatePage> {
  // controller for the textfield
  TextEditingController _dateController = TextEditingController();
  DateTime? creaData;

  // variable to store the selected date
  DateTime? _selectedDate;

  // function to show the date picker dialog
  void _selectDate(BuildContext context) async {
    // get the initial date
    DateTime initialDate = _selectedDate ?? DateTime.now();

    // show the date picker and wait for the result
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    // if the user picked a date, update the state
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        // set the selected date
        _selectedDate = pickedDate;

        // format the date as dd/mm/yyyy
        String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
        int day = pickedDate.day as int;

        // update the textfield controller
        _dateController.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Birth Date Example'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // textfield with an icon button to show the date picker
              TextField(
                controller: _dateController,
                readOnly: true, // prevent the user from typing
                decoration: InputDecoration(
                  labelText: 'Birth Date',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () {
                      // call the function to show the date picker
                      _selectDate(context);
                    },
                  ),
                ),
              ),
              // a text widget to display the selected date
              Text(
                _selectedDate == null
                    ? 'No date selected'
                    : 'Selected date: ${_dateController.text}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
