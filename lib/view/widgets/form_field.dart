import 'package:flutter/material.dart';

Widget taskInfoField(
  {
    required Function validate,
    required TextEditingController fieldController,
    required String lable,
    required Icon fieldIcon,
    Function()? doing,
  }
) => TextFormField (
  controller: fieldController,
  validator: (p) => validate(p),
  style: TextStyle(color: Colors.white),

  decoration: InputDecoration(

    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white,),
      borderRadius: BorderRadius.circular(15)
    ),

    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(15)
    ),

    labelText: lable,
    labelStyle: TextStyle(color: Colors.white, fontSize: 15),
    prefixIcon: Align(
      widthFactor: 1.0,
      heightFactor: 1.0,
      child: fieldIcon,
    ),
  )
);