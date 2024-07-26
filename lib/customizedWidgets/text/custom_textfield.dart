import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    Key? key,
    required this.screenWidth,
    required this.controller,
    this.textfieldmaxlength,
    required this.validator,
    required this.hinttext,
    this.padding,
    this.keyboardType,
    this.maxlines,
    this.customwidth,
  }) : super(key: key);

  final double screenWidth;
  final TextEditingController controller;
  final int? textfieldmaxlength;
  final String? Function(String?) validator;
  final String hinttext;
  final EdgeInsetsGeometry? padding;
  final TextInputType? keyboardType;
  final int? maxlines;
  final double? customwidth;
  

  @override
  Widget build(BuildContext context) {
    // final FocusNode focusNode2 = FocusNode();
    final textfielddefaultwidth = (screenWidth - (screenWidth * 0.2));
    return Padding(
      padding: padding ?? const EdgeInsets.only(top: 20),
      child: SizedBox(
        child: SizedBox(
          
          width:customwidth ?? (textfielddefaultwidth > 500 ? 400 : textfielddefaultwidth),
          child: TextFormField(
            keyboardType: keyboardType ?? TextInputType.none,
            maxLines: maxlines ?? 1,
            maxLength: textfieldmaxlength ?? 10,
            controller: controller,
            validator: validator,
            showCursor: true,
            decoration: InputDecoration(
              labelText:hinttext ,

              fillColor:const Color.fromARGB(255, 231, 231, 231),
              filled: true,
              // hintText: hinttext,
              hintStyle: const TextStyle(color:  Color.fromARGB(255, 54, 54, 54)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(color: Colors.black,width: 1),
              ),
              
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              errorStyle: const TextStyle(color: Colors.red, shadows: [
                Shadow(blurRadius: .1, color: Colors.black, offset: Offset(0, 0))
              ]),
            ),
            style:  const TextStyle(color:Colors.black),
          ),
        ),
      ),
    );
  }
}
