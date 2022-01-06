import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

final String? hintText;
final int? maxLines;
final TextInputType? textInputType;
final String? Function(String?)? validator;
final TextEditingController? textEditingController;
 const CustomTextField({Key? key, this.hintText, this.textEditingController, this.textInputType, this.maxLines = 1, this.validator}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        maxLines: maxLines,
        controller: textEditingController,
        keyboardType: textInputType,
        validator: validator,
        style: TextStyle(fontWeight: FontWeight.bold),
        decoration: InputDecoration(
             border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            hintText: hintText,
            isDense: true,
            hintStyle: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),

        ),
      ),
    );
  }
}
