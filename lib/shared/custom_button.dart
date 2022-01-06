import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final String? text;
  final Color? textColor;


  const CustomButton(
      {Key? key, this.onPressed,
      this.text,
      this.textColor = Colors.white,
      }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(borderRadius:BorderRadius.circular(20),color:Colors.blue ),
      child: MaterialButton(
        height: 50,
        onPressed: onPressed,
        child: Text(
          text!,
          style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
