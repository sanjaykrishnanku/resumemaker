import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    Key? key,
    required this.onDateSelected,
    this.initialDate,
  }) : super(key: key);
  
  final Function(DateTime) onDateSelected;
  final DateTime? initialDate;

  @override
  DatePickerState createState() => DatePickerState();
}

class DatePickerState extends State<DatePicker> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    // Initialize selectedDate with the provided initial date or current date
    selectedDate = widget.initialDate ?? DateTime.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.isAfter(DateTime(2026)) ? DateTime(2026) : selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2026),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: .5),
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 233, 233, 233),
      ),
      child: TextButton(
        onPressed: () {
          _selectDate(context);
        },
        child: Text(
          formattedDate,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
