import 'package:flutter/material.dart';

final productFieldDecoration = InputDecoration(
  hintText: 'Product Name',
  border: InputBorder.none,
  fillColor: Colors.grey[300],
  filled: true,
);

final authFieldDecoration = InputDecoration(
    prefixIcon: Icon(Icons.email),
    border: OutlineInputBorder(borderSide: BorderSide(width: 2.0,color: Colors.red)),
    labelText: "Email Address");