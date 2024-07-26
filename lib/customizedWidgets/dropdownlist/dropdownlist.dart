import 'package:flutter/material.dart';

class CustomDropDownList extends StatelessWidget {
  final List<String> items;
  final String selectedValue;
  final ValueChanged<String?> onChanged;

  const CustomDropDownList({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        
        borderRadius: BorderRadius.circular(10),
        color:const Color.fromARGB(255, 231, 231, 231),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10),
        child: DropdownButton<String>(
          alignment: AlignmentDirectional.topCenter,
          borderRadius: BorderRadius.circular(20),
          menuMaxHeight: 250,
          style: const TextStyle(color: Colors.black),
          hint: const Text('Select'),

          value: selectedValue,
          dropdownColor:const Color.fromARGB(255, 233, 233, 233),
          onChanged: onChanged,
          focusColor: Colors.white,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: SizedBox(
                width: 80,
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 15,color: Colors.black),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
