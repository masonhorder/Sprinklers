import 'package:Sprinklers/style/style.dart';
import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(15.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.3),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: sprinklerBlue, width: 2.3),
  ),
);